//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AddAssetsDto {
  /// Returns a new [AddAssetsDto] instance.
  AddAssetsDto({
    this.assetIds = const [],
  });

  List<String> assetIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AddAssetsDto &&
     other.assetIds == assetIds;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (assetIds.hashCode);

  @override
  String toString() => 'AddAssetsDto[assetIds=$assetIds]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'assetIds'] = assetIds;
    return _json;
  }

  /// Returns a new [AddAssetsDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AddAssetsDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AddAssetsDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AddAssetsDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AddAssetsDto(
        assetIds: json[r'assetIds'] is List
            ? (json[r'assetIds'] as List).cast<String>()
            : const [],
      );
    }
    return null;
  }

  static List<AddAssetsDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AddAssetsDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AddAssetsDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AddAssetsDto> mapFromJson(dynamic json) {
    final map = <String, AddAssetsDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AddAssetsDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AddAssetsDto-objects as value to a dart map
  static Map<String, List<AddAssetsDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AddAssetsDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AddAssetsDto.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'assetIds',
  };
}

