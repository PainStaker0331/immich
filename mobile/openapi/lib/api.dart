//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/album_api.dart';
part 'api/asset_api.dart';
part 'api/authentication_api.dart';
part 'api/device_info_api.dart';
part 'api/server_info_api.dart';
part 'api/user_api.dart';

part 'model/add_assets_dto.dart';
part 'model/add_users_dto.dart';
part 'model/admin_signup_response_dto.dart';
part 'model/album_count_response_dto.dart';
part 'model/album_response_dto.dart';
part 'model/asset_count_by_time_bucket.dart';
part 'model/asset_count_by_time_bucket_response_dto.dart';
part 'model/asset_count_by_user_id_response_dto.dart';
part 'model/asset_file_upload_response_dto.dart';
part 'model/asset_response_dto.dart';
part 'model/asset_type_enum.dart';
part 'model/check_duplicate_asset_dto.dart';
part 'model/check_duplicate_asset_response_dto.dart';
part 'model/create_album_dto.dart';
part 'model/create_device_info_dto.dart';
part 'model/create_profile_image_response_dto.dart';
part 'model/create_user_dto.dart';
part 'model/curated_locations_response_dto.dart';
part 'model/curated_objects_response_dto.dart';
part 'model/delete_asset_dto.dart';
part 'model/delete_asset_response_dto.dart';
part 'model/delete_asset_status.dart';
part 'model/device_info_response_dto.dart';
part 'model/device_type_enum.dart';
part 'model/exif_response_dto.dart';
part 'model/get_asset_by_time_bucket_dto.dart';
part 'model/get_asset_count_by_time_bucket_dto.dart';
part 'model/login_credential_dto.dart';
part 'model/login_response_dto.dart';
part 'model/logout_response_dto.dart';
part 'model/remove_assets_dto.dart';
part 'model/search_asset_dto.dart';
part 'model/server_info_response_dto.dart';
part 'model/server_ping_response.dart';
part 'model/server_version_reponse_dto.dart';
part 'model/sign_up_dto.dart';
part 'model/smart_info_response_dto.dart';
part 'model/thumbnail_format.dart';
part 'model/time_group_enum.dart';
part 'model/update_album_dto.dart';
part 'model/update_device_info_dto.dart';
part 'model/update_user_dto.dart';
part 'model/user_count_response_dto.dart';
part 'model/user_response_dto.dart';
part 'model/validate_access_token_response_dto.dart';


const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ApiClient defaultApiClient = ApiClient();
