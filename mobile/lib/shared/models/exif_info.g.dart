// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exif_info.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetExifInfoCollection on Isar {
  IsarCollection<ExifInfo> get exifInfos => this.collection();
}

const ExifInfoSchema = CollectionSchema(
  name: r'ExifInfo',
  id: -2409260054350835217,
  properties: {
    r'city': PropertySchema(
      id: 0,
      name: r'city',
      type: IsarType.string,
    ),
    r'country': PropertySchema(
      id: 1,
      name: r'country',
      type: IsarType.string,
    ),
    r'exposureSeconds': PropertySchema(
      id: 2,
      name: r'exposureSeconds',
      type: IsarType.float,
    ),
    r'f': PropertySchema(
      id: 3,
      name: r'f',
      type: IsarType.float,
    ),
    r'fileSize': PropertySchema(
      id: 4,
      name: r'fileSize',
      type: IsarType.long,
    ),
    r'iso': PropertySchema(
      id: 5,
      name: r'iso',
      type: IsarType.int,
    ),
    r'lat': PropertySchema(
      id: 6,
      name: r'lat',
      type: IsarType.float,
    ),
    r'lens': PropertySchema(
      id: 7,
      name: r'lens',
      type: IsarType.string,
    ),
    r'long': PropertySchema(
      id: 8,
      name: r'long',
      type: IsarType.float,
    ),
    r'make': PropertySchema(
      id: 9,
      name: r'make',
      type: IsarType.string,
    ),
    r'mm': PropertySchema(
      id: 10,
      name: r'mm',
      type: IsarType.float,
    ),
    r'model': PropertySchema(
      id: 11,
      name: r'model',
      type: IsarType.string,
    ),
    r'state': PropertySchema(
      id: 12,
      name: r'state',
      type: IsarType.string,
    )
  },
  estimateSize: _exifInfoEstimateSize,
  serialize: _exifInfoSerialize,
  deserialize: _exifInfoDeserialize,
  deserializeProp: _exifInfoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _exifInfoGetId,
  getLinks: _exifInfoGetLinks,
  attach: _exifInfoAttach,
  version: '3.0.5',
);

int _exifInfoEstimateSize(
  ExifInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.city;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.country;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lens;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.make;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.model;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.state;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _exifInfoSerialize(
  ExifInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.city);
  writer.writeString(offsets[1], object.country);
  writer.writeFloat(offsets[2], object.exposureSeconds);
  writer.writeFloat(offsets[3], object.f);
  writer.writeLong(offsets[4], object.fileSize);
  writer.writeInt(offsets[5], object.iso);
  writer.writeFloat(offsets[6], object.lat);
  writer.writeString(offsets[7], object.lens);
  writer.writeFloat(offsets[8], object.long);
  writer.writeString(offsets[9], object.make);
  writer.writeFloat(offsets[10], object.mm);
  writer.writeString(offsets[11], object.model);
  writer.writeString(offsets[12], object.state);
}

ExifInfo _exifInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExifInfo(
    city: reader.readStringOrNull(offsets[0]),
    country: reader.readStringOrNull(offsets[1]),
    exposureSeconds: reader.readFloatOrNull(offsets[2]),
    f: reader.readFloatOrNull(offsets[3]),
    fileSize: reader.readLongOrNull(offsets[4]),
    iso: reader.readIntOrNull(offsets[5]),
    lat: reader.readFloatOrNull(offsets[6]),
    lens: reader.readStringOrNull(offsets[7]),
    long: reader.readFloatOrNull(offsets[8]),
    make: reader.readStringOrNull(offsets[9]),
    mm: reader.readFloatOrNull(offsets[10]),
    model: reader.readStringOrNull(offsets[11]),
    state: reader.readStringOrNull(offsets[12]),
  );
  object.id = id;
  return object;
}

P _exifInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readFloatOrNull(offset)) as P;
    case 3:
      return (reader.readFloatOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readIntOrNull(offset)) as P;
    case 6:
      return (reader.readFloatOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readFloatOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readFloatOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _exifInfoGetId(ExifInfo object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _exifInfoGetLinks(ExifInfo object) {
  return [];
}

void _exifInfoAttach(IsarCollection<dynamic> col, Id id, ExifInfo object) {
  object.id = id;
}

extension ExifInfoQueryWhereSort on QueryBuilder<ExifInfo, ExifInfo, QWhere> {
  QueryBuilder<ExifInfo, ExifInfo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ExifInfoQueryWhere on QueryBuilder<ExifInfo, ExifInfo, QWhereClause> {
  QueryBuilder<ExifInfo, ExifInfo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ExifInfoQueryFilter
    on QueryBuilder<ExifInfo, ExifInfo, QFilterCondition> {
  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> cityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'city',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> cityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'city',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> cityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> cityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> cityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> cityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'city',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> cityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> cityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> cityContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> cityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'city',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> cityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> cityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> countryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'country',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> countryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'country',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> countryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> countryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> countryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> countryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'country',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> countryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> countryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> countryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> countryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'country',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> countryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> countryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition>
      exposureSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exposureSeconds',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition>
      exposureSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exposureSeconds',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition>
      exposureSecondsEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exposureSeconds',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition>
      exposureSecondsGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exposureSeconds',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition>
      exposureSecondsLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exposureSeconds',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition>
      exposureSecondsBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exposureSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> fIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'f',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> fIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'f',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> fEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'f',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> fGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'f',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> fLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'f',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> fBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'f',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> fileSizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileSize',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> fileSizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileSize',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> fileSizeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileSize',
        value: value,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> fileSizeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileSize',
        value: value,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> fileSizeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileSize',
        value: value,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> fileSizeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> isoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'iso',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> isoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'iso',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> isoEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iso',
        value: value,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> isoGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iso',
        value: value,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> isoLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iso',
        value: value,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> isoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iso',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> latIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lat',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> latIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lat',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> latEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> latGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> latLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> latBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> lensIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lens',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> lensIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lens',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> lensEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> lensGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> lensLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> lensBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lens',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> lensStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> lensEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> lensContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> lensMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lens',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> lensIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lens',
        value: '',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> lensIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lens',
        value: '',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> longIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'long',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> longIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'long',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> longEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'long',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> longGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'long',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> longLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'long',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> longBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'long',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> makeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'make',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> makeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'make',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> makeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'make',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> makeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'make',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> makeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'make',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> makeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'make',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> makeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'make',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> makeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'make',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> makeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'make',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> makeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'make',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> makeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'make',
        value: '',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> makeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'make',
        value: '',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> mmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mm',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> mmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mm',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> mmEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> mmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> mmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> mmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> modelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'model',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> modelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'model',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> modelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> modelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> modelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> modelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'model',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> modelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> modelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> modelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> modelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'model',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> modelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> modelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> stateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'state',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> stateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'state',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> stateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> stateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> stateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> stateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'state',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> stateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> stateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> stateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> stateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'state',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> stateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: '',
      ));
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterFilterCondition> stateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'state',
        value: '',
      ));
    });
  }
}

extension ExifInfoQueryObject
    on QueryBuilder<ExifInfo, ExifInfo, QFilterCondition> {}

extension ExifInfoQueryLinks
    on QueryBuilder<ExifInfo, ExifInfo, QFilterCondition> {}

extension ExifInfoQuerySortBy on QueryBuilder<ExifInfo, ExifInfo, QSortBy> {
  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByExposureSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exposureSeconds', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByExposureSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exposureSeconds', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByF() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'f', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByFDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'f', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByFileSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileSize', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByFileSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileSize', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByIso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iso', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByIsoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iso', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lat', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lat', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByLens() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lens', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByLensDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lens', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByLong() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'long', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByLongDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'long', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByMake() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'make', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByMakeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'make', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByMm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mm', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByMmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mm', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> sortByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }
}

extension ExifInfoQuerySortThenBy
    on QueryBuilder<ExifInfo, ExifInfo, QSortThenBy> {
  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByExposureSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exposureSeconds', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByExposureSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exposureSeconds', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByF() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'f', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByFDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'f', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByFileSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileSize', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByFileSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileSize', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByIso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iso', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByIsoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iso', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lat', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lat', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByLens() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lens', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByLensDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lens', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByLong() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'long', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByLongDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'long', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByMake() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'make', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByMakeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'make', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByMm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mm', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByMmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mm', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QAfterSortBy> thenByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }
}

extension ExifInfoQueryWhereDistinct
    on QueryBuilder<ExifInfo, ExifInfo, QDistinct> {
  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByCity(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'city', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByCountry(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'country', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByExposureSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exposureSeconds');
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByF() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'f');
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByFileSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileSize');
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByIso() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iso');
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lat');
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByLens(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lens', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByLong() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'long');
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByMake(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'make', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByMm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mm');
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByModel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'model', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExifInfo, ExifInfo, QDistinct> distinctByState(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'state', caseSensitive: caseSensitive);
    });
  }
}

extension ExifInfoQueryProperty
    on QueryBuilder<ExifInfo, ExifInfo, QQueryProperty> {
  QueryBuilder<ExifInfo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ExifInfo, String?, QQueryOperations> cityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'city');
    });
  }

  QueryBuilder<ExifInfo, String?, QQueryOperations> countryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'country');
    });
  }

  QueryBuilder<ExifInfo, double?, QQueryOperations> exposureSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exposureSeconds');
    });
  }

  QueryBuilder<ExifInfo, double?, QQueryOperations> fProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'f');
    });
  }

  QueryBuilder<ExifInfo, int?, QQueryOperations> fileSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileSize');
    });
  }

  QueryBuilder<ExifInfo, int?, QQueryOperations> isoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iso');
    });
  }

  QueryBuilder<ExifInfo, double?, QQueryOperations> latProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lat');
    });
  }

  QueryBuilder<ExifInfo, String?, QQueryOperations> lensProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lens');
    });
  }

  QueryBuilder<ExifInfo, double?, QQueryOperations> longProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'long');
    });
  }

  QueryBuilder<ExifInfo, String?, QQueryOperations> makeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'make');
    });
  }

  QueryBuilder<ExifInfo, double?, QQueryOperations> mmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mm');
    });
  }

  QueryBuilder<ExifInfo, String?, QQueryOperations> modelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'model');
    });
  }

  QueryBuilder<ExifInfo, String?, QQueryOperations> stateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'state');
    });
  }
}
