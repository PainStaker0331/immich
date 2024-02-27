from __future__ import annotations

import os
from abc import ABC, abstractmethod
from pathlib import Path
from shutil import rmtree
from typing import Any

import onnxruntime as ort
from huggingface_hub import snapshot_download

import ann.ann
from app.models.constants import SUPPORTED_PROVIDERS

from ..config import get_cache_dir, get_hf_model_name, log, settings
from ..schemas import ModelRuntime, ModelType
from .ann import AnnSession


class InferenceModel(ABC):
    _model_type: ModelType

    def __init__(
        self,
        model_name: str,
        cache_dir: Path | str | None = None,
        providers: list[str] | None = None,
        provider_options: list[dict[str, Any]] | None = None,
        sess_options: ort.SessionOptions | None = None,
        preferred_runtime: ModelRuntime | None = None,
        **model_kwargs: Any,
    ) -> None:
        self.loaded = False
        self.model_name = model_name
        self.cache_dir = Path(cache_dir) if cache_dir is not None else self.cache_dir_default
        self.providers = providers if providers is not None else self.providers_default
        self.provider_options = provider_options if provider_options is not None else self.provider_options_default
        self.sess_options = sess_options if sess_options is not None else self.sess_options_default
        self.preferred_runtime = preferred_runtime if preferred_runtime is not None else self.preferred_runtime_default

    def download(self) -> None:
        if not self.cached:
            log.info(
                f"Downloading {self.model_type.replace('-', ' ')} model '{self.model_name}'. This may take a while."
            )
            self._download()

    def load(self) -> None:
        if self.loaded:
            return
        self.download()
        log.info(f"Loading {self.model_type.replace('-', ' ')} model '{self.model_name}' to memory")
        self._load()
        self.loaded = True

    def predict(self, inputs: Any, **model_kwargs: Any) -> Any:
        self.load()
        if model_kwargs:
            self.configure(**model_kwargs)
        return self._predict(inputs)

    @abstractmethod
    def _predict(self, inputs: Any) -> Any: ...

    def configure(self, **model_kwargs: Any) -> None:
        pass

    def _download(self) -> None:
        ignore_patterns = [] if self.preferred_runtime == ModelRuntime.ARMNN else ["*.armnn"]
        snapshot_download(
            get_hf_model_name(self.model_name),
            cache_dir=self.cache_dir,
            local_dir=self.cache_dir,
            local_dir_use_symlinks=False,
            ignore_patterns=ignore_patterns,
        )

    @abstractmethod
    def _load(self) -> None: ...

    def clear_cache(self) -> None:
        if not self.cache_dir.exists():
            log.warning(
                f"Attempted to clear cache for model '{self.model_name}', but cache directory does not exist",
            )
            return
        if not rmtree.avoids_symlink_attacks:
            raise RuntimeError("Attempted to clear cache, but rmtree is not safe on this platform")

        if self.cache_dir.is_dir():
            log.info(f"Cleared cache directory for model '{self.model_name}'.")
            rmtree(self.cache_dir)
        else:
            log.warning(
                (
                    f"Encountered file instead of directory at cache path "
                    f"for '{self.model_name}'. Removing file and replacing with a directory."
                ),
            )
            self.cache_dir.unlink()
        self.cache_dir.mkdir(parents=True, exist_ok=True)

    def _make_session(self, model_path: Path) -> AnnSession | ort.InferenceSession:
        if not model_path.is_file():
            onnx_path = model_path.with_suffix(".onnx")
            if not onnx_path.is_file():
                raise ValueError(f"Model path '{model_path}' does not exist")

            log.warning(
                f"Could not find model path '{model_path}'. " f"Falling back to ONNX model path '{onnx_path}' instead.",
            )
            model_path = onnx_path

        match model_path.suffix:
            case ".armnn":
                session = AnnSession(model_path)
            case ".onnx":
                cwd = os.getcwd()
                try:
                    os.chdir(model_path.parent)
                    session = ort.InferenceSession(
                        model_path.as_posix(),
                        sess_options=self.sess_options,
                        providers=self.providers,
                        provider_options=self.provider_options,
                    )
                finally:
                    os.chdir(cwd)
            case _:
                raise ValueError(f"Unsupported model file type: {model_path.suffix}")
        return session

    @property
    def model_type(self) -> ModelType:
        return self._model_type

    @property
    def cache_dir(self) -> Path:
        return self._cache_dir

    @cache_dir.setter
    def cache_dir(self, cache_dir: Path) -> None:
        self._cache_dir = cache_dir

    @property
    def cache_dir_default(self) -> Path:
        return get_cache_dir(self.model_name, self.model_type)

    @property
    def cached(self) -> bool:
        return self.cache_dir.is_dir() and any(self.cache_dir.iterdir())

    @property
    def providers(self) -> list[str]:
        return self._providers

    @providers.setter
    def providers(self, providers: list[str]) -> None:
        log.info(
            (f"Setting '{self.model_name}' execution providers to {providers}, " "in descending order of preference"),
        )
        self._providers = providers

    @property
    def providers_default(self) -> list[str]:
        available_providers = set(ort.get_available_providers())
        log.debug(f"Available ORT providers: {available_providers}")
        if (openvino := "OpenVINOExecutionProvider") in available_providers:
            device_ids: list[str] = ort.capi._pybind_state.get_available_openvino_device_ids()
            log.debug(f"Available OpenVINO devices: {device_ids}")

            gpu_devices = [device_id for device_id in device_ids if device_id.startswith("GPU")]
            if not gpu_devices:
                log.warning("No GPU device found in OpenVINO. Falling back to CPU.")
                available_providers.remove(openvino)
        return [provider for provider in SUPPORTED_PROVIDERS if provider in available_providers]

    @property
    def provider_options(self) -> list[dict[str, Any]]:
        return self._provider_options

    @provider_options.setter
    def provider_options(self, provider_options: list[dict[str, Any]]) -> None:
        log.debug(f"Setting execution provider options to {provider_options}")
        self._provider_options = provider_options

    @property
    def provider_options_default(self) -> list[dict[str, Any]]:
        options = []
        for provider in self.providers:
            match provider:
                case "CPUExecutionProvider" | "CUDAExecutionProvider":
                    option = {"arena_extend_strategy": "kSameAsRequested"}
                case "OpenVINOExecutionProvider":
                    option = {"device_type": "GPU_FP32"}
                case _:
                    option = {}
            options.append(option)
        return options

    @property
    def sess_options(self) -> ort.SessionOptions:
        return self._sess_options

    @sess_options.setter
    def sess_options(self, sess_options: ort.SessionOptions) -> None:
        log.debug(f"Setting execution_mode to {sess_options.execution_mode.name}")
        log.debug(f"Setting inter_op_num_threads to {sess_options.inter_op_num_threads}")
        log.debug(f"Setting intra_op_num_threads to {sess_options.intra_op_num_threads}")
        self._sess_options = sess_options

    @property
    def sess_options_default(self) -> ort.SessionOptions:
        sess_options = ort.SessionOptions()
        sess_options.enable_cpu_mem_arena = False

        # avoid thread contention between models
        if settings.model_inter_op_threads > 0:
            sess_options.inter_op_num_threads = settings.model_inter_op_threads
        # these defaults work well for CPU, but bottleneck GPU
        elif settings.model_inter_op_threads == 0 and self.providers == ["CPUExecutionProvider"]:
            sess_options.inter_op_num_threads = 1

        if settings.model_intra_op_threads > 0:
            sess_options.intra_op_num_threads = settings.model_intra_op_threads
        elif settings.model_intra_op_threads == 0 and self.providers == ["CPUExecutionProvider"]:
            sess_options.intra_op_num_threads = 2

        if sess_options.inter_op_num_threads > 1:
            sess_options.execution_mode = ort.ExecutionMode.ORT_PARALLEL

        return sess_options

    @property
    def preferred_runtime(self) -> ModelRuntime:
        return self._preferred_runtime

    @preferred_runtime.setter
    def preferred_runtime(self, preferred_runtime: ModelRuntime) -> None:
        log.debug(f"Setting preferred runtime to {preferred_runtime}")
        self._preferred_runtime = preferred_runtime

    @property
    def preferred_runtime_default(self) -> ModelRuntime:
        return ModelRuntime.ARMNN if ann.ann.is_available and settings.ann else ModelRuntime.ONNX
