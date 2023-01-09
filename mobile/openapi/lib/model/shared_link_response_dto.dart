//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SharedLinkResponseDto {
  /// Returns a new [SharedLinkResponseDto] instance.
  SharedLinkResponseDto({
    required this.type,
    required this.id,
    this.description,
    required this.userId,
    required this.key,
    required this.createdAt,
    required this.expiresAt,
    this.assets = const [],
    this.album,
    required this.allowUpload,
  });

  SharedLinkType type;

  String id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  String userId;

  String key;

  String createdAt;

  String? expiresAt;

  List<String> assets;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AlbumResponseDto? album;

  bool allowUpload;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SharedLinkResponseDto &&
     other.type == type &&
     other.id == id &&
     other.description == description &&
     other.userId == userId &&
     other.key == key &&
     other.createdAt == createdAt &&
     other.expiresAt == expiresAt &&
     other.assets == assets &&
     other.album == album &&
     other.allowUpload == allowUpload;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (type.hashCode) +
    (id.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (userId.hashCode) +
    (key.hashCode) +
    (createdAt.hashCode) +
    (expiresAt == null ? 0 : expiresAt!.hashCode) +
    (assets.hashCode) +
    (album == null ? 0 : album!.hashCode) +
    (allowUpload.hashCode);

  @override
  String toString() => 'SharedLinkResponseDto[type=$type, id=$id, description=$description, userId=$userId, key=$key, createdAt=$createdAt, expiresAt=$expiresAt, assets=$assets, album=$album, allowUpload=$allowUpload]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'type'] = type;
      _json[r'id'] = id;
    if (description != null) {
      _json[r'description'] = description;
    } else {
      _json[r'description'] = null;
    }
      _json[r'userId'] = userId;
      _json[r'key'] = key;
      _json[r'createdAt'] = createdAt;
    if (expiresAt != null) {
      _json[r'expiresAt'] = expiresAt;
    } else {
      _json[r'expiresAt'] = null;
    }
      _json[r'assets'] = assets;
    if (album != null) {
      _json[r'album'] = album;
    } else {
      _json[r'album'] = null;
    }
      _json[r'allowUpload'] = allowUpload;
    return _json;
  }

  /// Returns a new [SharedLinkResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SharedLinkResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SharedLinkResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SharedLinkResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SharedLinkResponseDto(
        type: SharedLinkType.fromJson(json[r'type'])!,
        id: mapValueOfType<String>(json, r'id')!,
        description: mapValueOfType<String>(json, r'description'),
        userId: mapValueOfType<String>(json, r'userId')!,
        key: mapValueOfType<String>(json, r'key')!,
        createdAt: mapValueOfType<String>(json, r'createdAt')!,
        expiresAt: mapValueOfType<String>(json, r'expiresAt'),
        assets: json[r'assets'] is List
            ? (json[r'assets'] as List).cast<String>()
            : const [],
        album: AlbumResponseDto.fromJson(json[r'album']),
        allowUpload: mapValueOfType<bool>(json, r'allowUpload')!,
      );
    }
    return null;
  }

  static List<SharedLinkResponseDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SharedLinkResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SharedLinkResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SharedLinkResponseDto> mapFromJson(dynamic json) {
    final map = <String, SharedLinkResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SharedLinkResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SharedLinkResponseDto-objects as value to a dart map
  static Map<String, List<SharedLinkResponseDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SharedLinkResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SharedLinkResponseDto.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'type',
    'id',
    'userId',
    'key',
    'createdAt',
    'expiresAt',
    'assets',
    'allowUpload',
  };
}

