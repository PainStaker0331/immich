//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class TimeBucketEnum {
  /// Instantiate a new enum with the provided [value].
  const TimeBucketEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const day = TimeBucketEnum._(r'day');
  static const month = TimeBucketEnum._(r'month');

  /// List of all possible values in this [enum][TimeBucketEnum].
  static const values = <TimeBucketEnum>[
    day,
    month,
  ];

  static TimeBucketEnum? fromJson(dynamic value) => TimeBucketEnumTypeTransformer().decode(value);

  static List<TimeBucketEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TimeBucketEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TimeBucketEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TimeBucketEnum] to String,
/// and [decode] dynamic data back to [TimeBucketEnum].
class TimeBucketEnumTypeTransformer {
  factory TimeBucketEnumTypeTransformer() => _instance ??= const TimeBucketEnumTypeTransformer._();

  const TimeBucketEnumTypeTransformer._();

  String encode(TimeBucketEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a TimeBucketEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TimeBucketEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'day': return TimeBucketEnum.day;
        case r'month': return TimeBucketEnum.month;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [TimeBucketEnumTypeTransformer] instance.
  static TimeBucketEnumTypeTransformer? _instance;
}

