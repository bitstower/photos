// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetMediaCollection on Isar {
  IsarCollection<Media> get medias => this.collection();
}

const MediaSchema = CollectionSchema(
  name: r'Media',
  id: 6434281596432674333,
  properties: {
    r'deleted': PropertySchema(
      id: 0,
      name: r'deleted',
      type: IsarType.bool,
    ),
    r'duration': PropertySchema(
      id: 1,
      name: r'duration',
      type: IsarType.int,
    ),
    r'hash': PropertySchema(
      id: 2,
      name: r'hash',
      type: IsarType.long,
    ),
    r'localOrigin': PropertySchema(
      id: 3,
      name: r'localOrigin',
      type: IsarType.object,
      target: r'LocalAsset',
    ),
    r'orientatedHeight': PropertySchema(
      id: 4,
      name: r'orientatedHeight',
      type: IsarType.int,
    ),
    r'orientatedWidth': PropertySchema(
      id: 5,
      name: r'orientatedWidth',
      type: IsarType.int,
    ),
    r'orientation': PropertySchema(
      id: 6,
      name: r'orientation',
      type: IsarType.int,
    ),
    r'remoteOrigin': PropertySchema(
      id: 7,
      name: r'remoteOrigin',
      type: IsarType.object,
      target: r'RemoteAsset',
    ),
    r'taken': PropertySchema(
      id: 8,
      name: r'taken',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 9,
      name: r'type',
      type: IsarType.byte,
      enumMap: _MediatypeEnumValueMap,
    ),
    r'uploaded': PropertySchema(
      id: 10,
      name: r'uploaded',
      type: IsarType.bool,
    )
  },
  estimateSize: _mediaEstimateSize,
  serialize: _mediaSerialize,
  deserialize: _mediaDeserialize,
  deserializeProp: _mediaDeserializeProp,
  idName: r'id',
  indexes: {
    r'taken': IndexSchema(
      id: -4761636745693123041,
      name: r'taken',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'taken',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'deleted': IndexSchema(
      id: 2416515181749931262,
      name: r'deleted',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'deleted',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'uploaded_deleted': IndexSchema(
      id: 5013418922836625867,
      name: r'uploaded_deleted',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uploaded',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'deleted',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'hash': IndexSchema(
      id: -7973251393006690288,
      name: r'hash',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'hash',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'LocalAsset': LocalAssetSchema,
    r'RemoteAsset': RemoteAssetSchema
  },
  getId: _mediaGetId,
  getLinks: _mediaGetLinks,
  attach: _mediaAttach,
  version: '3.0.5',
);

int _mediaEstimateSize(
  Media object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.localOrigin;
    if (value != null) {
      bytesCount += 3 +
          LocalAssetSchema.estimateSize(
              value, allOffsets[LocalAsset]!, allOffsets);
    }
  }
  {
    final value = object.remoteOrigin;
    if (value != null) {
      bytesCount += 3 +
          RemoteAssetSchema.estimateSize(
              value, allOffsets[RemoteAsset]!, allOffsets);
    }
  }
  return bytesCount;
}

void _mediaSerialize(
  Media object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.deleted);
  writer.writeInt(offsets[1], object.duration);
  writer.writeLong(offsets[2], object.hash);
  writer.writeObject<LocalAsset>(
    offsets[3],
    allOffsets,
    LocalAssetSchema.serialize,
    object.localOrigin,
  );
  writer.writeInt(offsets[4], object.orientatedHeight);
  writer.writeInt(offsets[5], object.orientatedWidth);
  writer.writeInt(offsets[6], object.orientation);
  writer.writeObject<RemoteAsset>(
    offsets[7],
    allOffsets,
    RemoteAssetSchema.serialize,
    object.remoteOrigin,
  );
  writer.writeLong(offsets[8], object.taken);
  writer.writeByte(offsets[9], object.type.value);
  writer.writeBool(offsets[10], object.uploaded);
}

Media _mediaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Media();
  object.deleted = reader.readBool(offsets[0]);
  object.duration = reader.readInt(offsets[1]);
  object.id = id;
  object.localOrigin = reader.readObjectOrNull<LocalAsset>(
    offsets[3],
    LocalAssetSchema.deserialize,
    allOffsets,
  );
  object.orientatedHeight = reader.readInt(offsets[4]);
  object.orientatedWidth = reader.readInt(offsets[5]);
  object.orientation = reader.readInt(offsets[6]);
  object.remoteOrigin = reader.readObjectOrNull<RemoteAsset>(
    offsets[7],
    RemoteAssetSchema.deserialize,
    allOffsets,
  );
  object.taken = reader.readLong(offsets[8]);
  object.type = _MediatypeValueEnumMap[reader.readByteOrNull(offsets[9])] ??
      MediaType.image;
  object.uploaded = reader.readBool(offsets[10]);
  return object;
}

P _mediaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readInt(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<LocalAsset>(
        offset,
        LocalAssetSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readInt(offset)) as P;
    case 5:
      return (reader.readInt(offset)) as P;
    case 6:
      return (reader.readInt(offset)) as P;
    case 7:
      return (reader.readObjectOrNull<RemoteAsset>(
        offset,
        RemoteAssetSchema.deserialize,
        allOffsets,
      )) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (_MediatypeValueEnumMap[reader.readByteOrNull(offset)] ??
          MediaType.image) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MediatypeEnumValueMap = {
  'image': 0,
  'video': 1,
};
const _MediatypeValueEnumMap = {
  0: MediaType.image,
  1: MediaType.video,
};

Id _mediaGetId(Media object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _mediaGetLinks(Media object) {
  return [];
}

void _mediaAttach(IsarCollection<dynamic> col, Id id, Media object) {
  object.id = id;
}

extension MediaQueryWhereSort on QueryBuilder<Media, Media, QWhere> {
  QueryBuilder<Media, Media, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Media, Media, QAfterWhere> anyTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'taken'),
      );
    });
  }

  QueryBuilder<Media, Media, QAfterWhere> anyDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'deleted'),
      );
    });
  }

  QueryBuilder<Media, Media, QAfterWhere> anyUploadedDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'uploaded_deleted'),
      );
    });
  }

  QueryBuilder<Media, Media, QAfterWhere> anyHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'hash'),
      );
    });
  }
}

extension MediaQueryWhere on QueryBuilder<Media, Media, QWhereClause> {
  QueryBuilder<Media, Media, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Media, Media, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> idBetween(
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

  QueryBuilder<Media, Media, QAfterWhereClause> takenEqualTo(int taken) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'taken',
        value: [taken],
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> takenNotEqualTo(int taken) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taken',
              lower: [],
              upper: [taken],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taken',
              lower: [taken],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taken',
              lower: [taken],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taken',
              lower: [],
              upper: [taken],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> takenGreaterThan(
    int taken, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taken',
        lower: [taken],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> takenLessThan(
    int taken, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taken',
        lower: [],
        upper: [taken],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> takenBetween(
    int lowerTaken,
    int upperTaken, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taken',
        lower: [lowerTaken],
        includeLower: includeLower,
        upper: [upperTaken],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'deleted',
        value: [deleted],
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> deletedNotEqualTo(
      bool deleted) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deleted',
              lower: [],
              upper: [deleted],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deleted',
              lower: [deleted],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deleted',
              lower: [deleted],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deleted',
              lower: [],
              upper: [deleted],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> uploadedEqualToAnyDeleted(
      bool uploaded) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uploaded_deleted',
        value: [uploaded],
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> uploadedNotEqualToAnyDeleted(
      bool uploaded) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uploaded_deleted',
              lower: [],
              upper: [uploaded],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uploaded_deleted',
              lower: [uploaded],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uploaded_deleted',
              lower: [uploaded],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uploaded_deleted',
              lower: [],
              upper: [uploaded],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> uploadedDeletedEqualTo(
      bool uploaded, bool deleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uploaded_deleted',
        value: [uploaded, deleted],
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause>
      uploadedEqualToDeletedNotEqualTo(bool uploaded, bool deleted) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uploaded_deleted',
              lower: [uploaded],
              upper: [uploaded, deleted],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uploaded_deleted',
              lower: [uploaded, deleted],
              includeLower: false,
              upper: [uploaded],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uploaded_deleted',
              lower: [uploaded, deleted],
              includeLower: false,
              upper: [uploaded],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uploaded_deleted',
              lower: [uploaded],
              upper: [uploaded, deleted],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> hashEqualTo(int hash) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hash',
        value: [hash],
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> hashNotEqualTo(int hash) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hash',
              lower: [],
              upper: [hash],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hash',
              lower: [hash],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hash',
              lower: [hash],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hash',
              lower: [],
              upper: [hash],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> hashGreaterThan(
    int hash, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hash',
        lower: [hash],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> hashLessThan(
    int hash, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hash',
        lower: [],
        upper: [hash],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterWhereClause> hashBetween(
    int lowerHash,
    int upperHash, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hash',
        lower: [lowerHash],
        includeLower: includeLower,
        upper: [upperHash],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MediaQueryFilter on QueryBuilder<Media, Media, QFilterCondition> {
  QueryBuilder<Media, Media, QAfterFilterCondition> deletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deleted',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> durationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> durationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> durationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> durationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> hashEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hash',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> hashGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hash',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> hashLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hash',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> hashBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Media, Media, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Media, Media, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Media, Media, QAfterFilterCondition> localOriginIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localOrigin',
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> localOriginIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localOrigin',
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> orientatedHeightEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orientatedHeight',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> orientatedHeightGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orientatedHeight',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> orientatedHeightLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orientatedHeight',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> orientatedHeightBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orientatedHeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> orientatedWidthEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orientatedWidth',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> orientatedWidthGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orientatedWidth',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> orientatedWidthLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orientatedWidth',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> orientatedWidthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orientatedWidth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> orientationEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orientation',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> orientationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orientation',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> orientationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orientation',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> orientationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orientation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> remoteOriginIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remoteOrigin',
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> remoteOriginIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remoteOrigin',
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> takenEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taken',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> takenGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taken',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> takenLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taken',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> takenBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> typeEqualTo(
      MediaType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> typeGreaterThan(
    MediaType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> typeLessThan(
    MediaType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> typeBetween(
    MediaType lower,
    MediaType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> uploadedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uploaded',
        value: value,
      ));
    });
  }
}

extension MediaQueryObject on QueryBuilder<Media, Media, QFilterCondition> {
  QueryBuilder<Media, Media, QAfterFilterCondition> localOrigin(
      FilterQuery<LocalAsset> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'localOrigin');
    });
  }

  QueryBuilder<Media, Media, QAfterFilterCondition> remoteOrigin(
      FilterQuery<RemoteAsset> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'remoteOrigin');
    });
  }
}

extension MediaQueryLinks on QueryBuilder<Media, Media, QFilterCondition> {}

extension MediaQuerySortBy on QueryBuilder<Media, Media, QSortBy> {
  QueryBuilder<Media, Media, QAfterSortBy> sortByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hash', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hash', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByOrientatedHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orientatedHeight', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByOrientatedHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orientatedHeight', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByOrientatedWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orientatedWidth', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByOrientatedWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orientatedWidth', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByOrientation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orientation', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByOrientationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orientation', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taken', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taken', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByUploaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploaded', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> sortByUploadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploaded', Sort.desc);
    });
  }
}

extension MediaQuerySortThenBy on QueryBuilder<Media, Media, QSortThenBy> {
  QueryBuilder<Media, Media, QAfterSortBy> thenByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hash', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hash', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByOrientatedHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orientatedHeight', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByOrientatedHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orientatedHeight', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByOrientatedWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orientatedWidth', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByOrientatedWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orientatedWidth', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByOrientation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orientation', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByOrientationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orientation', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taken', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taken', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByUploaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploaded', Sort.asc);
    });
  }

  QueryBuilder<Media, Media, QAfterSortBy> thenByUploadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploaded', Sort.desc);
    });
  }
}

extension MediaQueryWhereDistinct on QueryBuilder<Media, Media, QDistinct> {
  QueryBuilder<Media, Media, QDistinct> distinctByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deleted');
    });
  }

  QueryBuilder<Media, Media, QDistinct> distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duration');
    });
  }

  QueryBuilder<Media, Media, QDistinct> distinctByHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hash');
    });
  }

  QueryBuilder<Media, Media, QDistinct> distinctByOrientatedHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orientatedHeight');
    });
  }

  QueryBuilder<Media, Media, QDistinct> distinctByOrientatedWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orientatedWidth');
    });
  }

  QueryBuilder<Media, Media, QDistinct> distinctByOrientation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orientation');
    });
  }

  QueryBuilder<Media, Media, QDistinct> distinctByTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taken');
    });
  }

  QueryBuilder<Media, Media, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<Media, Media, QDistinct> distinctByUploaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uploaded');
    });
  }
}

extension MediaQueryProperty on QueryBuilder<Media, Media, QQueryProperty> {
  QueryBuilder<Media, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Media, bool, QQueryOperations> deletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deleted');
    });
  }

  QueryBuilder<Media, int, QQueryOperations> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duration');
    });
  }

  QueryBuilder<Media, int, QQueryOperations> hashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hash');
    });
  }

  QueryBuilder<Media, LocalAsset?, QQueryOperations> localOriginProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localOrigin');
    });
  }

  QueryBuilder<Media, int, QQueryOperations> orientatedHeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orientatedHeight');
    });
  }

  QueryBuilder<Media, int, QQueryOperations> orientatedWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orientatedWidth');
    });
  }

  QueryBuilder<Media, int, QQueryOperations> orientationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orientation');
    });
  }

  QueryBuilder<Media, RemoteAsset?, QQueryOperations> remoteOriginProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteOrigin');
    });
  }

  QueryBuilder<Media, int, QQueryOperations> takenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taken');
    });
  }

  QueryBuilder<Media, MediaType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Media, bool, QQueryOperations> uploadedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uploaded');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const LocalAssetSchema = Schema(
  name: r'LocalAsset',
  id: -8554576320587453525,
  properties: {
    r'localId': PropertySchema(
      id: 0,
      name: r'localId',
      type: IsarType.string,
    )
  },
  estimateSize: _localAssetEstimateSize,
  serialize: _localAssetSerialize,
  deserialize: _localAssetDeserialize,
  deserializeProp: _localAssetDeserializeProp,
);

int _localAssetEstimateSize(
  LocalAsset object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.localId.length * 3;
  return bytesCount;
}

void _localAssetSerialize(
  LocalAsset object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.localId);
}

LocalAsset _localAssetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalAsset();
  object.localId = reader.readString(offsets[0]);
  return object;
}

P _localAssetDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension LocalAssetQueryFilter
    on QueryBuilder<LocalAsset, LocalAsset, QFilterCondition> {
  QueryBuilder<LocalAsset, LocalAsset, QAfterFilterCondition> localIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalAsset, LocalAsset, QAfterFilterCondition>
      localIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalAsset, LocalAsset, QAfterFilterCondition> localIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalAsset, LocalAsset, QAfterFilterCondition> localIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalAsset, LocalAsset, QAfterFilterCondition> localIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalAsset, LocalAsset, QAfterFilterCondition> localIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalAsset, LocalAsset, QAfterFilterCondition> localIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalAsset, LocalAsset, QAfterFilterCondition> localIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalAsset, LocalAsset, QAfterFilterCondition> localIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalAsset, LocalAsset, QAfterFilterCondition>
      localIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localId',
        value: '',
      ));
    });
  }
}

extension LocalAssetQueryObject
    on QueryBuilder<LocalAsset, LocalAsset, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const RemoteAssetSchema = Schema(
  name: r'RemoteAsset',
  id: -962630459024812197,
  properties: {
    r'checksum': PropertySchema(
      id: 0,
      name: r'checksum',
      type: IsarType.byteList,
    ),
    r'fileSize': PropertySchema(
      id: 1,
      name: r'fileSize',
      type: IsarType.long,
    ),
    r'fileType': PropertySchema(
      id: 2,
      name: r'fileType',
      type: IsarType.string,
    ),
    r'secret': PropertySchema(
      id: 3,
      name: r'secret',
      type: IsarType.byteList,
    ),
    r'uuid': PropertySchema(
      id: 4,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _remoteAssetEstimateSize,
  serialize: _remoteAssetSerialize,
  deserialize: _remoteAssetDeserialize,
  deserializeProp: _remoteAssetDeserializeProp,
);

int _remoteAssetEstimateSize(
  RemoteAsset object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.checksum.length;
  bytesCount += 3 + object.fileType.length * 3;
  bytesCount += 3 + object.secret.length;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _remoteAssetSerialize(
  RemoteAsset object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByteList(offsets[0], object.checksum);
  writer.writeLong(offsets[1], object.fileSize);
  writer.writeString(offsets[2], object.fileType);
  writer.writeByteList(offsets[3], object.secret);
  writer.writeString(offsets[4], object.uuid);
}

RemoteAsset _remoteAssetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RemoteAsset();
  object.checksum = reader.readByteList(offsets[0]) ?? [];
  object.fileSize = reader.readLong(offsets[1]);
  object.fileType = reader.readString(offsets[2]);
  object.secret = reader.readByteList(offsets[3]) ?? [];
  object.uuid = reader.readString(offsets[4]);
  return object;
}

P _remoteAssetDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readByteList(offset) ?? []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readByteList(offset) ?? []) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RemoteAssetQueryFilter
    on QueryBuilder<RemoteAsset, RemoteAsset, QFilterCondition> {
  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      checksumElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checksum',
        value: value,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      checksumElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'checksum',
        value: value,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      checksumElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'checksum',
        value: value,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      checksumElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'checksum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      checksumLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checksum',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      checksumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checksum',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      checksumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checksum',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      checksumLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checksum',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      checksumLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checksum',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      checksumLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checksum',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> fileSizeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileSize',
        value: value,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      fileSizeGreaterThan(
    int value, {
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

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      fileSizeLessThan(
    int value, {
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

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> fileSizeBetween(
    int lower,
    int upper, {
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

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> fileTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      fileTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      fileTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> fileTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      fileTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      fileTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      fileTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> fileTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      fileTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileType',
        value: '',
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      fileTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileType',
        value: '',
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      secretElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secret',
        value: value,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      secretElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secret',
        value: value,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      secretElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secret',
        value: value,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      secretElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secret',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      secretLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secret',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      secretIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secret',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      secretIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secret',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      secretLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secret',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      secretLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secret',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      secretLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'secret',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<RemoteAsset, RemoteAsset, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension RemoteAssetQueryObject
    on QueryBuilder<RemoteAsset, RemoteAsset, QFilterCondition> {}
