// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetJarCollection on Isar {
  IsarCollection<Jar> get jars => this.collection();
}

const JarSchema = CollectionSchema(
  name: r'Jar',
  id: -1216068105858010852,
  properties: {
    r'payload': PropertySchema(
      id: 0,
      name: r'payload',
      type: IsarType.byteList,
    )
  },
  estimateSize: _jarEstimateSize,
  serialize: _jarSerialize,
  deserialize: _jarDeserialize,
  deserializeProp: _jarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _jarGetId,
  getLinks: _jarGetLinks,
  attach: _jarAttach,
  version: '3.0.5',
);

int _jarEstimateSize(
  Jar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.payload.length;
  return bytesCount;
}

void _jarSerialize(
  Jar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByteList(offsets[0], object.payload);
}

Jar _jarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Jar();
  object.id = id;
  object.payload = reader.readByteList(offsets[0]) ?? [];
  return object;
}

P _jarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readByteList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _jarGetId(Jar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _jarGetLinks(Jar object) {
  return [];
}

void _jarAttach(IsarCollection<dynamic> col, Id id, Jar object) {
  object.id = id;
}

extension JarQueryWhereSort on QueryBuilder<Jar, Jar, QWhere> {
  QueryBuilder<Jar, Jar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension JarQueryWhere on QueryBuilder<Jar, Jar, QWhereClause> {
  QueryBuilder<Jar, Jar, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Jar, Jar, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Jar, Jar, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Jar, Jar, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Jar, Jar, QAfterWhereClause> idBetween(
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

extension JarQueryFilter on QueryBuilder<Jar, Jar, QFilterCondition> {
  QueryBuilder<Jar, Jar, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Jar, Jar, QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<Jar, Jar, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<Jar, Jar, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<Jar, Jar, QAfterFilterCondition> payloadElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payload',
        value: value,
      ));
    });
  }

  QueryBuilder<Jar, Jar, QAfterFilterCondition> payloadElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payload',
        value: value,
      ));
    });
  }

  QueryBuilder<Jar, Jar, QAfterFilterCondition> payloadElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payload',
        value: value,
      ));
    });
  }

  QueryBuilder<Jar, Jar, QAfterFilterCondition> payloadElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payload',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Jar, Jar, QAfterFilterCondition> payloadLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'payload',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Jar, Jar, QAfterFilterCondition> payloadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'payload',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Jar, Jar, QAfterFilterCondition> payloadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'payload',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Jar, Jar, QAfterFilterCondition> payloadLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'payload',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Jar, Jar, QAfterFilterCondition> payloadLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'payload',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Jar, Jar, QAfterFilterCondition> payloadLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'payload',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension JarQueryObject on QueryBuilder<Jar, Jar, QFilterCondition> {}

extension JarQueryLinks on QueryBuilder<Jar, Jar, QFilterCondition> {}

extension JarQuerySortBy on QueryBuilder<Jar, Jar, QSortBy> {}

extension JarQuerySortThenBy on QueryBuilder<Jar, Jar, QSortThenBy> {
  QueryBuilder<Jar, Jar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Jar, Jar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension JarQueryWhereDistinct on QueryBuilder<Jar, Jar, QDistinct> {
  QueryBuilder<Jar, Jar, QDistinct> distinctByPayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payload');
    });
  }
}

extension JarQueryProperty on QueryBuilder<Jar, Jar, QQueryProperty> {
  QueryBuilder<Jar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Jar, List<int>, QQueryOperations> payloadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payload');
    });
  }
}
