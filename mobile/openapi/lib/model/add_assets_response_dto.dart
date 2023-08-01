//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AddAssetsResponseDto {
  /// Returns a new [AddAssetsResponseDto] instance.
  AddAssetsResponseDto({
    this.album,
    this.alreadyInAlbum = const [],
    required this.successfullyAdded,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AlbumResponseDto? album;

  List<String> alreadyInAlbum;

  int successfullyAdded;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AddAssetsResponseDto &&
     other.album == album &&
     other.alreadyInAlbum == alreadyInAlbum &&
     other.successfullyAdded == successfullyAdded;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (album == null ? 0 : album!.hashCode) +
    (alreadyInAlbum.hashCode) +
    (successfullyAdded.hashCode);

  @override
  String toString() => 'AddAssetsResponseDto[album=$album, alreadyInAlbum=$alreadyInAlbum, successfullyAdded=$successfullyAdded]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.album != null) {
      json[r'album'] = this.album;
    } else {
    //  json[r'album'] = null;
    }
      json[r'alreadyInAlbum'] = this.alreadyInAlbum;
      json[r'successfullyAdded'] = this.successfullyAdded;
    return json;
  }

  /// Returns a new [AddAssetsResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AddAssetsResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      return AddAssetsResponseDto(
        album: AlbumResponseDto.fromJson(json[r'album']),
        alreadyInAlbum: json[r'alreadyInAlbum'] is Iterable
            ? (json[r'alreadyInAlbum'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        successfullyAdded: mapValueOfType<int>(json, r'successfullyAdded')!,
      );
    }
    return null;
  }

  static List<AddAssetsResponseDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AddAssetsResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AddAssetsResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AddAssetsResponseDto> mapFromJson(dynamic json) {
    final map = <String, AddAssetsResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AddAssetsResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AddAssetsResponseDto-objects as value to a dart map
  static Map<String, List<AddAssetsResponseDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AddAssetsResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AddAssetsResponseDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'alreadyInAlbum',
    'successfullyAdded',
  };
}

