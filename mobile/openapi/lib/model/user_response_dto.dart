//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserResponseDto {
  /// Returns a new [UserResponseDto] instance.
  UserResponseDto({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.profileImagePath,
    required this.shouldChangePassword,
    required this.isAdmin,
  });

  String id;

  String email;

  String firstName;

  String lastName;

  String createdAt;

  String profileImagePath;

  bool shouldChangePassword;

  bool isAdmin;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserResponseDto &&
     other.id == id &&
     other.email == email &&
     other.firstName == firstName &&
     other.lastName == lastName &&
     other.createdAt == createdAt &&
     other.profileImagePath == profileImagePath &&
     other.shouldChangePassword == shouldChangePassword &&
     other.isAdmin == isAdmin;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (email.hashCode) +
    (firstName.hashCode) +
    (lastName.hashCode) +
    (createdAt.hashCode) +
    (profileImagePath.hashCode) +
    (shouldChangePassword.hashCode) +
    (isAdmin.hashCode);

  @override
  String toString() => 'UserResponseDto[id=$id, email=$email, firstName=$firstName, lastName=$lastName, createdAt=$createdAt, profileImagePath=$profileImagePath, shouldChangePassword=$shouldChangePassword, isAdmin=$isAdmin]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'id'] = id;
      _json[r'email'] = email;
      _json[r'firstName'] = firstName;
      _json[r'lastName'] = lastName;
      _json[r'createdAt'] = createdAt;
      _json[r'profileImagePath'] = profileImagePath;
      _json[r'shouldChangePassword'] = shouldChangePassword;
      _json[r'isAdmin'] = isAdmin;
    return _json;
  }

  /// Returns a new [UserResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserResponseDto(
        id: mapValueOfType<String>(json, r'id')!,
        email: mapValueOfType<String>(json, r'email')!,
        firstName: mapValueOfType<String>(json, r'firstName')!,
        lastName: mapValueOfType<String>(json, r'lastName')!,
        createdAt: mapValueOfType<String>(json, r'createdAt')!,
        profileImagePath: mapValueOfType<String>(json, r'profileImagePath')!,
        shouldChangePassword: mapValueOfType<bool>(json, r'shouldChangePassword')!,
        isAdmin: mapValueOfType<bool>(json, r'isAdmin')!,
      );
    }
    return null;
  }

  static List<UserResponseDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserResponseDto> mapFromJson(dynamic json) {
    final map = <String, UserResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserResponseDto-objects as value to a dart map
  static Map<String, List<UserResponseDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserResponseDto.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'email',
    'firstName',
    'lastName',
    'createdAt',
    'profileImagePath',
    'shouldChangePassword',
    'isAdmin',
  };
}

