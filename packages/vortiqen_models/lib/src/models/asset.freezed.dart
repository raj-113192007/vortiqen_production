// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Asset {
  String get id;
  String get schoolId;
  String get categoryId;
  String get name;
  String? get sku;
  DateTime? get purchaseDate;
  double? get depreciationRate;
  String get status;
  String get condition;
  String? get assignedToUser;
  String? get location;
  DateTime? get createdAt;
  DateTime? get updatedAt;
  User? get assignedTo;
  List<AssetLog> get logs;

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssetCopyWith<Asset> get copyWith =>
      _$AssetCopyWithImpl<Asset>(this as Asset, _$identity);

  /// Serializes this Asset to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Asset &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.depreciationRate, depreciationRate) ||
                other.depreciationRate == depreciationRate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.assignedToUser, assignedToUser) ||
                other.assignedToUser == assignedToUser) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo) &&
            const DeepCollectionEquality().equals(other.logs, logs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      schoolId,
      categoryId,
      name,
      sku,
      purchaseDate,
      depreciationRate,
      status,
      condition,
      assignedToUser,
      location,
      createdAt,
      updatedAt,
      assignedTo,
      const DeepCollectionEquality().hash(logs));

  @override
  String toString() {
    return 'Asset(id: $id, schoolId: $schoolId, categoryId: $categoryId, name: $name, sku: $sku, purchaseDate: $purchaseDate, depreciationRate: $depreciationRate, status: $status, condition: $condition, assignedToUser: $assignedToUser, location: $location, createdAt: $createdAt, updatedAt: $updatedAt, assignedTo: $assignedTo, logs: $logs)';
  }
}

/// @nodoc
abstract mixin class $AssetCopyWith<$Res> {
  factory $AssetCopyWith(Asset value, $Res Function(Asset) _then) =
      _$AssetCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String schoolId,
      String categoryId,
      String name,
      String? sku,
      DateTime? purchaseDate,
      double? depreciationRate,
      String status,
      String condition,
      String? assignedToUser,
      String? location,
      DateTime? createdAt,
      DateTime? updatedAt,
      User? assignedTo,
      List<AssetLog> logs});

  $UserCopyWith<$Res>? get assignedTo;
}

/// @nodoc
class _$AssetCopyWithImpl<$Res> implements $AssetCopyWith<$Res> {
  _$AssetCopyWithImpl(this._self, this._then);

  final Asset _self;
  final $Res Function(Asset) _then;

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? schoolId = null,
    Object? categoryId = null,
    Object? name = null,
    Object? sku = freezed,
    Object? purchaseDate = freezed,
    Object? depreciationRate = freezed,
    Object? status = null,
    Object? condition = null,
    Object? assignedToUser = freezed,
    Object? location = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? assignedTo = freezed,
    Object? logs = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      schoolId: null == schoolId
          ? _self.schoolId
          : schoolId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sku: freezed == sku
          ? _self.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseDate: freezed == purchaseDate
          ? _self.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      depreciationRate: freezed == depreciationRate
          ? _self.depreciationRate
          : depreciationRate // ignore: cast_nullable_to_non_nullable
              as double?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      condition: null == condition
          ? _self.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      assignedToUser: freezed == assignedToUser
          ? _self.assignedToUser
          : assignedToUser // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      assignedTo: freezed == assignedTo
          ? _self.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as User?,
      logs: null == logs
          ? _self.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<AssetLog>,
    ));
  }

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get assignedTo {
    if (_self.assignedTo == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_self.assignedTo!, (value) {
      return _then(_self.copyWith(assignedTo: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Asset].
extension AssetPatterns on Asset {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Asset value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Asset() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Asset value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Asset():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Asset value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Asset() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String schoolId,
            String categoryId,
            String name,
            String? sku,
            DateTime? purchaseDate,
            double? depreciationRate,
            String status,
            String condition,
            String? assignedToUser,
            String? location,
            DateTime? createdAt,
            DateTime? updatedAt,
            User? assignedTo,
            List<AssetLog> logs)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Asset() when $default != null:
        return $default(
            _that.id,
            _that.schoolId,
            _that.categoryId,
            _that.name,
            _that.sku,
            _that.purchaseDate,
            _that.depreciationRate,
            _that.status,
            _that.condition,
            _that.assignedToUser,
            _that.location,
            _that.createdAt,
            _that.updatedAt,
            _that.assignedTo,
            _that.logs);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String schoolId,
            String categoryId,
            String name,
            String? sku,
            DateTime? purchaseDate,
            double? depreciationRate,
            String status,
            String condition,
            String? assignedToUser,
            String? location,
            DateTime? createdAt,
            DateTime? updatedAt,
            User? assignedTo,
            List<AssetLog> logs)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Asset():
        return $default(
            _that.id,
            _that.schoolId,
            _that.categoryId,
            _that.name,
            _that.sku,
            _that.purchaseDate,
            _that.depreciationRate,
            _that.status,
            _that.condition,
            _that.assignedToUser,
            _that.location,
            _that.createdAt,
            _that.updatedAt,
            _that.assignedTo,
            _that.logs);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String schoolId,
            String categoryId,
            String name,
            String? sku,
            DateTime? purchaseDate,
            double? depreciationRate,
            String status,
            String condition,
            String? assignedToUser,
            String? location,
            DateTime? createdAt,
            DateTime? updatedAt,
            User? assignedTo,
            List<AssetLog> logs)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Asset() when $default != null:
        return $default(
            _that.id,
            _that.schoolId,
            _that.categoryId,
            _that.name,
            _that.sku,
            _that.purchaseDate,
            _that.depreciationRate,
            _that.status,
            _that.condition,
            _that.assignedToUser,
            _that.location,
            _that.createdAt,
            _that.updatedAt,
            _that.assignedTo,
            _that.logs);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Asset implements Asset {
  const _Asset(
      {required this.id,
      required this.schoolId,
      required this.categoryId,
      required this.name,
      this.sku,
      this.purchaseDate,
      this.depreciationRate,
      this.status = 'AVAILABLE',
      this.condition = 'GOOD',
      this.assignedToUser,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.assignedTo,
      final List<AssetLog> logs = const []})
      : _logs = logs;
  factory _Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  @override
  final String id;
  @override
  final String schoolId;
  @override
  final String categoryId;
  @override
  final String name;
  @override
  final String? sku;
  @override
  final DateTime? purchaseDate;
  @override
  final double? depreciationRate;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String condition;
  @override
  final String? assignedToUser;
  @override
  final String? location;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final User? assignedTo;
  final List<AssetLog> _logs;
  @override
  @JsonKey()
  List<AssetLog> get logs {
    if (_logs is EqualUnmodifiableListView) return _logs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_logs);
  }

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AssetCopyWith<_Asset> get copyWith =>
      __$AssetCopyWithImpl<_Asset>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AssetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Asset &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.depreciationRate, depreciationRate) ||
                other.depreciationRate == depreciationRate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.assignedToUser, assignedToUser) ||
                other.assignedToUser == assignedToUser) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo) &&
            const DeepCollectionEquality().equals(other._logs, _logs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      schoolId,
      categoryId,
      name,
      sku,
      purchaseDate,
      depreciationRate,
      status,
      condition,
      assignedToUser,
      location,
      createdAt,
      updatedAt,
      assignedTo,
      const DeepCollectionEquality().hash(_logs));

  @override
  String toString() {
    return 'Asset(id: $id, schoolId: $schoolId, categoryId: $categoryId, name: $name, sku: $sku, purchaseDate: $purchaseDate, depreciationRate: $depreciationRate, status: $status, condition: $condition, assignedToUser: $assignedToUser, location: $location, createdAt: $createdAt, updatedAt: $updatedAt, assignedTo: $assignedTo, logs: $logs)';
  }
}

/// @nodoc
abstract mixin class _$AssetCopyWith<$Res> implements $AssetCopyWith<$Res> {
  factory _$AssetCopyWith(_Asset value, $Res Function(_Asset) _then) =
      __$AssetCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String schoolId,
      String categoryId,
      String name,
      String? sku,
      DateTime? purchaseDate,
      double? depreciationRate,
      String status,
      String condition,
      String? assignedToUser,
      String? location,
      DateTime? createdAt,
      DateTime? updatedAt,
      User? assignedTo,
      List<AssetLog> logs});

  @override
  $UserCopyWith<$Res>? get assignedTo;
}

/// @nodoc
class __$AssetCopyWithImpl<$Res> implements _$AssetCopyWith<$Res> {
  __$AssetCopyWithImpl(this._self, this._then);

  final _Asset _self;
  final $Res Function(_Asset) _then;

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? schoolId = null,
    Object? categoryId = null,
    Object? name = null,
    Object? sku = freezed,
    Object? purchaseDate = freezed,
    Object? depreciationRate = freezed,
    Object? status = null,
    Object? condition = null,
    Object? assignedToUser = freezed,
    Object? location = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? assignedTo = freezed,
    Object? logs = null,
  }) {
    return _then(_Asset(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      schoolId: null == schoolId
          ? _self.schoolId
          : schoolId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sku: freezed == sku
          ? _self.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseDate: freezed == purchaseDate
          ? _self.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      depreciationRate: freezed == depreciationRate
          ? _self.depreciationRate
          : depreciationRate // ignore: cast_nullable_to_non_nullable
              as double?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      condition: null == condition
          ? _self.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      assignedToUser: freezed == assignedToUser
          ? _self.assignedToUser
          : assignedToUser // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      assignedTo: freezed == assignedTo
          ? _self.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as User?,
      logs: null == logs
          ? _self._logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<AssetLog>,
    ));
  }

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get assignedTo {
    if (_self.assignedTo == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_self.assignedTo!, (value) {
      return _then(_self.copyWith(assignedTo: value));
    });
  }
}

/// @nodoc
mixin _$AssetLog {
  String get id;
  String get assetId;
  String get action;
  String? get userId;
  String? get adminId;
  String? get notes;
  DateTime? get createdAt;

  /// Create a copy of AssetLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssetLogCopyWith<AssetLog> get copyWith =>
      _$AssetLogCopyWithImpl<AssetLog>(this as AssetLog, _$identity);

  /// Serializes this AssetLog to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AssetLog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.assetId, assetId) || other.assetId == assetId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.adminId, adminId) || other.adminId == adminId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, assetId, action, userId, adminId, notes, createdAt);

  @override
  String toString() {
    return 'AssetLog(id: $id, assetId: $assetId, action: $action, userId: $userId, adminId: $adminId, notes: $notes, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $AssetLogCopyWith<$Res> {
  factory $AssetLogCopyWith(AssetLog value, $Res Function(AssetLog) _then) =
      _$AssetLogCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String assetId,
      String action,
      String? userId,
      String? adminId,
      String? notes,
      DateTime? createdAt});
}

/// @nodoc
class _$AssetLogCopyWithImpl<$Res> implements $AssetLogCopyWith<$Res> {
  _$AssetLogCopyWithImpl(this._self, this._then);

  final AssetLog _self;
  final $Res Function(AssetLog) _then;

  /// Create a copy of AssetLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? assetId = null,
    Object? action = null,
    Object? userId = freezed,
    Object? adminId = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      assetId: null == assetId
          ? _self.assetId
          : assetId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      adminId: freezed == adminId
          ? _self.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AssetLog].
extension AssetLogPatterns on AssetLog {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AssetLog value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AssetLog() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AssetLog value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssetLog():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AssetLog value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssetLog() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String assetId, String action, String? userId,
            String? adminId, String? notes, DateTime? createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AssetLog() when $default != null:
        return $default(_that.id, _that.assetId, _that.action, _that.userId,
            _that.adminId, _that.notes, _that.createdAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String assetId, String action, String? userId,
            String? adminId, String? notes, DateTime? createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssetLog():
        return $default(_that.id, _that.assetId, _that.action, _that.userId,
            _that.adminId, _that.notes, _that.createdAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String assetId, String action, String? userId,
            String? adminId, String? notes, DateTime? createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssetLog() when $default != null:
        return $default(_that.id, _that.assetId, _that.action, _that.userId,
            _that.adminId, _that.notes, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AssetLog implements AssetLog {
  const _AssetLog(
      {required this.id,
      required this.assetId,
      required this.action,
      this.userId,
      this.adminId,
      this.notes,
      this.createdAt});
  factory _AssetLog.fromJson(Map<String, dynamic> json) =>
      _$AssetLogFromJson(json);

  @override
  final String id;
  @override
  final String assetId;
  @override
  final String action;
  @override
  final String? userId;
  @override
  final String? adminId;
  @override
  final String? notes;
  @override
  final DateTime? createdAt;

  /// Create a copy of AssetLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AssetLogCopyWith<_AssetLog> get copyWith =>
      __$AssetLogCopyWithImpl<_AssetLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AssetLogToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AssetLog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.assetId, assetId) || other.assetId == assetId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.adminId, adminId) || other.adminId == adminId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, assetId, action, userId, adminId, notes, createdAt);

  @override
  String toString() {
    return 'AssetLog(id: $id, assetId: $assetId, action: $action, userId: $userId, adminId: $adminId, notes: $notes, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$AssetLogCopyWith<$Res>
    implements $AssetLogCopyWith<$Res> {
  factory _$AssetLogCopyWith(_AssetLog value, $Res Function(_AssetLog) _then) =
      __$AssetLogCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String assetId,
      String action,
      String? userId,
      String? adminId,
      String? notes,
      DateTime? createdAt});
}

/// @nodoc
class __$AssetLogCopyWithImpl<$Res> implements _$AssetLogCopyWith<$Res> {
  __$AssetLogCopyWithImpl(this._self, this._then);

  final _AssetLog _self;
  final $Res Function(_AssetLog) _then;

  /// Create a copy of AssetLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? assetId = null,
    Object? action = null,
    Object? userId = freezed,
    Object? adminId = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_AssetLog(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      assetId: null == assetId
          ? _self.assetId
          : assetId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      adminId: freezed == adminId
          ? _self.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
