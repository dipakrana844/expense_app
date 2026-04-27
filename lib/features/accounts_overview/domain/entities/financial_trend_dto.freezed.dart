// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_trend_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FinancialTrendDTO {

/// Monthly balance points showing cumulative net worth trend
 List<MonthlyBalancePoint> get netBalanceTrend;/// Monthly income vs expense comparisons for bar chart
 List<IncomeExpenseComparison> get monthlyComparisons;/// Key financial health metrics
 FinancialHealthMetrics get healthMetrics;/// Intelligent insights about financial patterns
 List<FinancialInsight> get insights;
/// Create a copy of FinancialTrendDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialTrendDTOCopyWith<FinancialTrendDTO> get copyWith => _$FinancialTrendDTOCopyWithImpl<FinancialTrendDTO>(this as FinancialTrendDTO, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialTrendDTO&&const DeepCollectionEquality().equals(other.netBalanceTrend, netBalanceTrend)&&const DeepCollectionEquality().equals(other.monthlyComparisons, monthlyComparisons)&&(identical(other.healthMetrics, healthMetrics) || other.healthMetrics == healthMetrics)&&const DeepCollectionEquality().equals(other.insights, insights));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(netBalanceTrend),const DeepCollectionEquality().hash(monthlyComparisons),healthMetrics,const DeepCollectionEquality().hash(insights));

@override
String toString() {
  return 'FinancialTrendDTO(netBalanceTrend: $netBalanceTrend, monthlyComparisons: $monthlyComparisons, healthMetrics: $healthMetrics, insights: $insights)';
}


}

/// @nodoc
abstract mixin class $FinancialTrendDTOCopyWith<$Res>  {
  factory $FinancialTrendDTOCopyWith(FinancialTrendDTO value, $Res Function(FinancialTrendDTO) _then) = _$FinancialTrendDTOCopyWithImpl;
@useResult
$Res call({
 List<MonthlyBalancePoint> netBalanceTrend, List<IncomeExpenseComparison> monthlyComparisons, FinancialHealthMetrics healthMetrics, List<FinancialInsight> insights
});


$FinancialHealthMetricsCopyWith<$Res> get healthMetrics;

}
/// @nodoc
class _$FinancialTrendDTOCopyWithImpl<$Res>
    implements $FinancialTrendDTOCopyWith<$Res> {
  _$FinancialTrendDTOCopyWithImpl(this._self, this._then);

  final FinancialTrendDTO _self;
  final $Res Function(FinancialTrendDTO) _then;

/// Create a copy of FinancialTrendDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? netBalanceTrend = null,Object? monthlyComparisons = null,Object? healthMetrics = null,Object? insights = null,}) {
  return _then(_self.copyWith(
netBalanceTrend: null == netBalanceTrend ? _self.netBalanceTrend : netBalanceTrend // ignore: cast_nullable_to_non_nullable
as List<MonthlyBalancePoint>,monthlyComparisons: null == monthlyComparisons ? _self.monthlyComparisons : monthlyComparisons // ignore: cast_nullable_to_non_nullable
as List<IncomeExpenseComparison>,healthMetrics: null == healthMetrics ? _self.healthMetrics : healthMetrics // ignore: cast_nullable_to_non_nullable
as FinancialHealthMetrics,insights: null == insights ? _self.insights : insights // ignore: cast_nullable_to_non_nullable
as List<FinancialInsight>,
  ));
}
/// Create a copy of FinancialTrendDTO
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialHealthMetricsCopyWith<$Res> get healthMetrics {
  
  return $FinancialHealthMetricsCopyWith<$Res>(_self.healthMetrics, (value) {
    return _then(_self.copyWith(healthMetrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [FinancialTrendDTO].
extension FinancialTrendDTOPatterns on FinancialTrendDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialTrendDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialTrendDTO() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialTrendDTO value)  $default,){
final _that = this;
switch (_that) {
case _FinancialTrendDTO():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialTrendDTO value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialTrendDTO() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MonthlyBalancePoint> netBalanceTrend,  List<IncomeExpenseComparison> monthlyComparisons,  FinancialHealthMetrics healthMetrics,  List<FinancialInsight> insights)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialTrendDTO() when $default != null:
return $default(_that.netBalanceTrend,_that.monthlyComparisons,_that.healthMetrics,_that.insights);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MonthlyBalancePoint> netBalanceTrend,  List<IncomeExpenseComparison> monthlyComparisons,  FinancialHealthMetrics healthMetrics,  List<FinancialInsight> insights)  $default,) {final _that = this;
switch (_that) {
case _FinancialTrendDTO():
return $default(_that.netBalanceTrend,_that.monthlyComparisons,_that.healthMetrics,_that.insights);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MonthlyBalancePoint> netBalanceTrend,  List<IncomeExpenseComparison> monthlyComparisons,  FinancialHealthMetrics healthMetrics,  List<FinancialInsight> insights)?  $default,) {final _that = this;
switch (_that) {
case _FinancialTrendDTO() when $default != null:
return $default(_that.netBalanceTrend,_that.monthlyComparisons,_that.healthMetrics,_that.insights);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialTrendDTO implements FinancialTrendDTO {
  const _FinancialTrendDTO({required final  List<MonthlyBalancePoint> netBalanceTrend, required final  List<IncomeExpenseComparison> monthlyComparisons, required this.healthMetrics, required final  List<FinancialInsight> insights}): _netBalanceTrend = netBalanceTrend,_monthlyComparisons = monthlyComparisons,_insights = insights;
  

/// Monthly balance points showing cumulative net worth trend
 final  List<MonthlyBalancePoint> _netBalanceTrend;
/// Monthly balance points showing cumulative net worth trend
@override List<MonthlyBalancePoint> get netBalanceTrend {
  if (_netBalanceTrend is EqualUnmodifiableListView) return _netBalanceTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_netBalanceTrend);
}

/// Monthly income vs expense comparisons for bar chart
 final  List<IncomeExpenseComparison> _monthlyComparisons;
/// Monthly income vs expense comparisons for bar chart
@override List<IncomeExpenseComparison> get monthlyComparisons {
  if (_monthlyComparisons is EqualUnmodifiableListView) return _monthlyComparisons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthlyComparisons);
}

/// Key financial health metrics
@override final  FinancialHealthMetrics healthMetrics;
/// Intelligent insights about financial patterns
 final  List<FinancialInsight> _insights;
/// Intelligent insights about financial patterns
@override List<FinancialInsight> get insights {
  if (_insights is EqualUnmodifiableListView) return _insights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insights);
}


/// Create a copy of FinancialTrendDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialTrendDTOCopyWith<_FinancialTrendDTO> get copyWith => __$FinancialTrendDTOCopyWithImpl<_FinancialTrendDTO>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialTrendDTO&&const DeepCollectionEquality().equals(other._netBalanceTrend, _netBalanceTrend)&&const DeepCollectionEquality().equals(other._monthlyComparisons, _monthlyComparisons)&&(identical(other.healthMetrics, healthMetrics) || other.healthMetrics == healthMetrics)&&const DeepCollectionEquality().equals(other._insights, _insights));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_netBalanceTrend),const DeepCollectionEquality().hash(_monthlyComparisons),healthMetrics,const DeepCollectionEquality().hash(_insights));

@override
String toString() {
  return 'FinancialTrendDTO(netBalanceTrend: $netBalanceTrend, monthlyComparisons: $monthlyComparisons, healthMetrics: $healthMetrics, insights: $insights)';
}


}

/// @nodoc
abstract mixin class _$FinancialTrendDTOCopyWith<$Res> implements $FinancialTrendDTOCopyWith<$Res> {
  factory _$FinancialTrendDTOCopyWith(_FinancialTrendDTO value, $Res Function(_FinancialTrendDTO) _then) = __$FinancialTrendDTOCopyWithImpl;
@override @useResult
$Res call({
 List<MonthlyBalancePoint> netBalanceTrend, List<IncomeExpenseComparison> monthlyComparisons, FinancialHealthMetrics healthMetrics, List<FinancialInsight> insights
});


@override $FinancialHealthMetricsCopyWith<$Res> get healthMetrics;

}
/// @nodoc
class __$FinancialTrendDTOCopyWithImpl<$Res>
    implements _$FinancialTrendDTOCopyWith<$Res> {
  __$FinancialTrendDTOCopyWithImpl(this._self, this._then);

  final _FinancialTrendDTO _self;
  final $Res Function(_FinancialTrendDTO) _then;

/// Create a copy of FinancialTrendDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? netBalanceTrend = null,Object? monthlyComparisons = null,Object? healthMetrics = null,Object? insights = null,}) {
  return _then(_FinancialTrendDTO(
netBalanceTrend: null == netBalanceTrend ? _self._netBalanceTrend : netBalanceTrend // ignore: cast_nullable_to_non_nullable
as List<MonthlyBalancePoint>,monthlyComparisons: null == monthlyComparisons ? _self._monthlyComparisons : monthlyComparisons // ignore: cast_nullable_to_non_nullable
as List<IncomeExpenseComparison>,healthMetrics: null == healthMetrics ? _self.healthMetrics : healthMetrics // ignore: cast_nullable_to_non_nullable
as FinancialHealthMetrics,insights: null == insights ? _self._insights : insights // ignore: cast_nullable_to_non_nullable
as List<FinancialInsight>,
  ));
}

/// Create a copy of FinancialTrendDTO
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialHealthMetricsCopyWith<$Res> get healthMetrics {
  
  return $FinancialHealthMetricsCopyWith<$Res>(_self.healthMetrics, (value) {
    return _then(_self.copyWith(healthMetrics: value));
  });
}
}

/// @nodoc
mixin _$MonthlyBalancePoint {

/// Month identifier in YYYY-MM format
 String get monthKey;/// First day of the month for chart positioning
 DateTime get date;/// Cumulative net balance at end of month
 double get cumulativeBalance;/// Total income for this month
 double get monthlyIncome;/// Total expenses for this month
 double get monthlyExpense;/// Net change for this month (income - expense)
 double get netChange;
/// Create a copy of MonthlyBalancePoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyBalancePointCopyWith<MonthlyBalancePoint> get copyWith => _$MonthlyBalancePointCopyWithImpl<MonthlyBalancePoint>(this as MonthlyBalancePoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyBalancePoint&&(identical(other.monthKey, monthKey) || other.monthKey == monthKey)&&(identical(other.date, date) || other.date == date)&&(identical(other.cumulativeBalance, cumulativeBalance) || other.cumulativeBalance == cumulativeBalance)&&(identical(other.monthlyIncome, monthlyIncome) || other.monthlyIncome == monthlyIncome)&&(identical(other.monthlyExpense, monthlyExpense) || other.monthlyExpense == monthlyExpense)&&(identical(other.netChange, netChange) || other.netChange == netChange));
}


@override
int get hashCode => Object.hash(runtimeType,monthKey,date,cumulativeBalance,monthlyIncome,monthlyExpense,netChange);

@override
String toString() {
  return 'MonthlyBalancePoint(monthKey: $monthKey, date: $date, cumulativeBalance: $cumulativeBalance, monthlyIncome: $monthlyIncome, monthlyExpense: $monthlyExpense, netChange: $netChange)';
}


}

/// @nodoc
abstract mixin class $MonthlyBalancePointCopyWith<$Res>  {
  factory $MonthlyBalancePointCopyWith(MonthlyBalancePoint value, $Res Function(MonthlyBalancePoint) _then) = _$MonthlyBalancePointCopyWithImpl;
@useResult
$Res call({
 String monthKey, DateTime date, double cumulativeBalance, double monthlyIncome, double monthlyExpense, double netChange
});




}
/// @nodoc
class _$MonthlyBalancePointCopyWithImpl<$Res>
    implements $MonthlyBalancePointCopyWith<$Res> {
  _$MonthlyBalancePointCopyWithImpl(this._self, this._then);

  final MonthlyBalancePoint _self;
  final $Res Function(MonthlyBalancePoint) _then;

/// Create a copy of MonthlyBalancePoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? monthKey = null,Object? date = null,Object? cumulativeBalance = null,Object? monthlyIncome = null,Object? monthlyExpense = null,Object? netChange = null,}) {
  return _then(_self.copyWith(
monthKey: null == monthKey ? _self.monthKey : monthKey // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,cumulativeBalance: null == cumulativeBalance ? _self.cumulativeBalance : cumulativeBalance // ignore: cast_nullable_to_non_nullable
as double,monthlyIncome: null == monthlyIncome ? _self.monthlyIncome : monthlyIncome // ignore: cast_nullable_to_non_nullable
as double,monthlyExpense: null == monthlyExpense ? _self.monthlyExpense : monthlyExpense // ignore: cast_nullable_to_non_nullable
as double,netChange: null == netChange ? _self.netChange : netChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlyBalancePoint].
extension MonthlyBalancePointPatterns on MonthlyBalancePoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyBalancePoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyBalancePoint() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyBalancePoint value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyBalancePoint():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyBalancePoint value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyBalancePoint() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String monthKey,  DateTime date,  double cumulativeBalance,  double monthlyIncome,  double monthlyExpense,  double netChange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyBalancePoint() when $default != null:
return $default(_that.monthKey,_that.date,_that.cumulativeBalance,_that.monthlyIncome,_that.monthlyExpense,_that.netChange);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String monthKey,  DateTime date,  double cumulativeBalance,  double monthlyIncome,  double monthlyExpense,  double netChange)  $default,) {final _that = this;
switch (_that) {
case _MonthlyBalancePoint():
return $default(_that.monthKey,_that.date,_that.cumulativeBalance,_that.monthlyIncome,_that.monthlyExpense,_that.netChange);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String monthKey,  DateTime date,  double cumulativeBalance,  double monthlyIncome,  double monthlyExpense,  double netChange)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyBalancePoint() when $default != null:
return $default(_that.monthKey,_that.date,_that.cumulativeBalance,_that.monthlyIncome,_that.monthlyExpense,_that.netChange);case _:
  return null;

}
}

}

/// @nodoc


class _MonthlyBalancePoint implements MonthlyBalancePoint {
  const _MonthlyBalancePoint({required this.monthKey, required this.date, required this.cumulativeBalance, required this.monthlyIncome, required this.monthlyExpense, required this.netChange});
  

/// Month identifier in YYYY-MM format
@override final  String monthKey;
/// First day of the month for chart positioning
@override final  DateTime date;
/// Cumulative net balance at end of month
@override final  double cumulativeBalance;
/// Total income for this month
@override final  double monthlyIncome;
/// Total expenses for this month
@override final  double monthlyExpense;
/// Net change for this month (income - expense)
@override final  double netChange;

/// Create a copy of MonthlyBalancePoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyBalancePointCopyWith<_MonthlyBalancePoint> get copyWith => __$MonthlyBalancePointCopyWithImpl<_MonthlyBalancePoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyBalancePoint&&(identical(other.monthKey, monthKey) || other.monthKey == monthKey)&&(identical(other.date, date) || other.date == date)&&(identical(other.cumulativeBalance, cumulativeBalance) || other.cumulativeBalance == cumulativeBalance)&&(identical(other.monthlyIncome, monthlyIncome) || other.monthlyIncome == monthlyIncome)&&(identical(other.monthlyExpense, monthlyExpense) || other.monthlyExpense == monthlyExpense)&&(identical(other.netChange, netChange) || other.netChange == netChange));
}


@override
int get hashCode => Object.hash(runtimeType,monthKey,date,cumulativeBalance,monthlyIncome,monthlyExpense,netChange);

@override
String toString() {
  return 'MonthlyBalancePoint(monthKey: $monthKey, date: $date, cumulativeBalance: $cumulativeBalance, monthlyIncome: $monthlyIncome, monthlyExpense: $monthlyExpense, netChange: $netChange)';
}


}

/// @nodoc
abstract mixin class _$MonthlyBalancePointCopyWith<$Res> implements $MonthlyBalancePointCopyWith<$Res> {
  factory _$MonthlyBalancePointCopyWith(_MonthlyBalancePoint value, $Res Function(_MonthlyBalancePoint) _then) = __$MonthlyBalancePointCopyWithImpl;
@override @useResult
$Res call({
 String monthKey, DateTime date, double cumulativeBalance, double monthlyIncome, double monthlyExpense, double netChange
});




}
/// @nodoc
class __$MonthlyBalancePointCopyWithImpl<$Res>
    implements _$MonthlyBalancePointCopyWith<$Res> {
  __$MonthlyBalancePointCopyWithImpl(this._self, this._then);

  final _MonthlyBalancePoint _self;
  final $Res Function(_MonthlyBalancePoint) _then;

/// Create a copy of MonthlyBalancePoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? monthKey = null,Object? date = null,Object? cumulativeBalance = null,Object? monthlyIncome = null,Object? monthlyExpense = null,Object? netChange = null,}) {
  return _then(_MonthlyBalancePoint(
monthKey: null == monthKey ? _self.monthKey : monthKey // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,cumulativeBalance: null == cumulativeBalance ? _self.cumulativeBalance : cumulativeBalance // ignore: cast_nullable_to_non_nullable
as double,monthlyIncome: null == monthlyIncome ? _self.monthlyIncome : monthlyIncome // ignore: cast_nullable_to_non_nullable
as double,monthlyExpense: null == monthlyExpense ? _self.monthlyExpense : monthlyExpense // ignore: cast_nullable_to_non_nullable
as double,netChange: null == netChange ? _self.netChange : netChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$IncomeExpenseComparison {

/// Month identifier in YYYY-MM format
 String get monthKey;/// Total income for the month
 double get income;/// Total expenses for the month
 double get expense;/// Difference (income - expense)
 double get difference;
/// Create a copy of IncomeExpenseComparison
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeExpenseComparisonCopyWith<IncomeExpenseComparison> get copyWith => _$IncomeExpenseComparisonCopyWithImpl<IncomeExpenseComparison>(this as IncomeExpenseComparison, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeExpenseComparison&&(identical(other.monthKey, monthKey) || other.monthKey == monthKey)&&(identical(other.income, income) || other.income == income)&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.difference, difference) || other.difference == difference));
}


@override
int get hashCode => Object.hash(runtimeType,monthKey,income,expense,difference);

@override
String toString() {
  return 'IncomeExpenseComparison(monthKey: $monthKey, income: $income, expense: $expense, difference: $difference)';
}


}

/// @nodoc
abstract mixin class $IncomeExpenseComparisonCopyWith<$Res>  {
  factory $IncomeExpenseComparisonCopyWith(IncomeExpenseComparison value, $Res Function(IncomeExpenseComparison) _then) = _$IncomeExpenseComparisonCopyWithImpl;
@useResult
$Res call({
 String monthKey, double income, double expense, double difference
});




}
/// @nodoc
class _$IncomeExpenseComparisonCopyWithImpl<$Res>
    implements $IncomeExpenseComparisonCopyWith<$Res> {
  _$IncomeExpenseComparisonCopyWithImpl(this._self, this._then);

  final IncomeExpenseComparison _self;
  final $Res Function(IncomeExpenseComparison) _then;

/// Create a copy of IncomeExpenseComparison
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? monthKey = null,Object? income = null,Object? expense = null,Object? difference = null,}) {
  return _then(_self.copyWith(
monthKey: null == monthKey ? _self.monthKey : monthKey // ignore: cast_nullable_to_non_nullable
as String,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as double,expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as double,difference: null == difference ? _self.difference : difference // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [IncomeExpenseComparison].
extension IncomeExpenseComparisonPatterns on IncomeExpenseComparison {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomeExpenseComparison value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomeExpenseComparison() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomeExpenseComparison value)  $default,){
final _that = this;
switch (_that) {
case _IncomeExpenseComparison():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomeExpenseComparison value)?  $default,){
final _that = this;
switch (_that) {
case _IncomeExpenseComparison() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String monthKey,  double income,  double expense,  double difference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomeExpenseComparison() when $default != null:
return $default(_that.monthKey,_that.income,_that.expense,_that.difference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String monthKey,  double income,  double expense,  double difference)  $default,) {final _that = this;
switch (_that) {
case _IncomeExpenseComparison():
return $default(_that.monthKey,_that.income,_that.expense,_that.difference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String monthKey,  double income,  double expense,  double difference)?  $default,) {final _that = this;
switch (_that) {
case _IncomeExpenseComparison() when $default != null:
return $default(_that.monthKey,_that.income,_that.expense,_that.difference);case _:
  return null;

}
}

}

/// @nodoc


class _IncomeExpenseComparison implements IncomeExpenseComparison {
  const _IncomeExpenseComparison({required this.monthKey, required this.income, required this.expense, required this.difference});
  

/// Month identifier in YYYY-MM format
@override final  String monthKey;
/// Total income for the month
@override final  double income;
/// Total expenses for the month
@override final  double expense;
/// Difference (income - expense)
@override final  double difference;

/// Create a copy of IncomeExpenseComparison
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomeExpenseComparisonCopyWith<_IncomeExpenseComparison> get copyWith => __$IncomeExpenseComparisonCopyWithImpl<_IncomeExpenseComparison>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomeExpenseComparison&&(identical(other.monthKey, monthKey) || other.monthKey == monthKey)&&(identical(other.income, income) || other.income == income)&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.difference, difference) || other.difference == difference));
}


@override
int get hashCode => Object.hash(runtimeType,monthKey,income,expense,difference);

@override
String toString() {
  return 'IncomeExpenseComparison(monthKey: $monthKey, income: $income, expense: $expense, difference: $difference)';
}


}

/// @nodoc
abstract mixin class _$IncomeExpenseComparisonCopyWith<$Res> implements $IncomeExpenseComparisonCopyWith<$Res> {
  factory _$IncomeExpenseComparisonCopyWith(_IncomeExpenseComparison value, $Res Function(_IncomeExpenseComparison) _then) = __$IncomeExpenseComparisonCopyWithImpl;
@override @useResult
$Res call({
 String monthKey, double income, double expense, double difference
});




}
/// @nodoc
class __$IncomeExpenseComparisonCopyWithImpl<$Res>
    implements _$IncomeExpenseComparisonCopyWith<$Res> {
  __$IncomeExpenseComparisonCopyWithImpl(this._self, this._then);

  final _IncomeExpenseComparison _self;
  final $Res Function(_IncomeExpenseComparison) _then;

/// Create a copy of IncomeExpenseComparison
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? monthKey = null,Object? income = null,Object? expense = null,Object? difference = null,}) {
  return _then(_IncomeExpenseComparison(
monthKey: null == monthKey ? _self.monthKey : monthKey // ignore: cast_nullable_to_non_nullable
as String,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as double,expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as double,difference: null == difference ? _self.difference : difference // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$FinancialHealthMetrics {

/// Average monthly income over analyzed period
 double get averageMonthlyIncome;/// Average monthly expenses over analyzed period
 double get averageMonthlyExpense;/// Savings rate as percentage (income - expenses) / income * 100
 double get savingsRate;/// Income consistency score (0-100, higher = more consistent)
 double get incomeConsistency;/// Best performing month details
 MonthlyPerformance get bestMonth;/// Worst performing month details
 MonthlyPerformance get worstMonth;
/// Create a copy of FinancialHealthMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialHealthMetricsCopyWith<FinancialHealthMetrics> get copyWith => _$FinancialHealthMetricsCopyWithImpl<FinancialHealthMetrics>(this as FinancialHealthMetrics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialHealthMetrics&&(identical(other.averageMonthlyIncome, averageMonthlyIncome) || other.averageMonthlyIncome == averageMonthlyIncome)&&(identical(other.averageMonthlyExpense, averageMonthlyExpense) || other.averageMonthlyExpense == averageMonthlyExpense)&&(identical(other.savingsRate, savingsRate) || other.savingsRate == savingsRate)&&(identical(other.incomeConsistency, incomeConsistency) || other.incomeConsistency == incomeConsistency)&&(identical(other.bestMonth, bestMonth) || other.bestMonth == bestMonth)&&(identical(other.worstMonth, worstMonth) || other.worstMonth == worstMonth));
}


@override
int get hashCode => Object.hash(runtimeType,averageMonthlyIncome,averageMonthlyExpense,savingsRate,incomeConsistency,bestMonth,worstMonth);

@override
String toString() {
  return 'FinancialHealthMetrics(averageMonthlyIncome: $averageMonthlyIncome, averageMonthlyExpense: $averageMonthlyExpense, savingsRate: $savingsRate, incomeConsistency: $incomeConsistency, bestMonth: $bestMonth, worstMonth: $worstMonth)';
}


}

/// @nodoc
abstract mixin class $FinancialHealthMetricsCopyWith<$Res>  {
  factory $FinancialHealthMetricsCopyWith(FinancialHealthMetrics value, $Res Function(FinancialHealthMetrics) _then) = _$FinancialHealthMetricsCopyWithImpl;
@useResult
$Res call({
 double averageMonthlyIncome, double averageMonthlyExpense, double savingsRate, double incomeConsistency, MonthlyPerformance bestMonth, MonthlyPerformance worstMonth
});


$MonthlyPerformanceCopyWith<$Res> get bestMonth;$MonthlyPerformanceCopyWith<$Res> get worstMonth;

}
/// @nodoc
class _$FinancialHealthMetricsCopyWithImpl<$Res>
    implements $FinancialHealthMetricsCopyWith<$Res> {
  _$FinancialHealthMetricsCopyWithImpl(this._self, this._then);

  final FinancialHealthMetrics _self;
  final $Res Function(FinancialHealthMetrics) _then;

/// Create a copy of FinancialHealthMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? averageMonthlyIncome = null,Object? averageMonthlyExpense = null,Object? savingsRate = null,Object? incomeConsistency = null,Object? bestMonth = null,Object? worstMonth = null,}) {
  return _then(_self.copyWith(
averageMonthlyIncome: null == averageMonthlyIncome ? _self.averageMonthlyIncome : averageMonthlyIncome // ignore: cast_nullable_to_non_nullable
as double,averageMonthlyExpense: null == averageMonthlyExpense ? _self.averageMonthlyExpense : averageMonthlyExpense // ignore: cast_nullable_to_non_nullable
as double,savingsRate: null == savingsRate ? _self.savingsRate : savingsRate // ignore: cast_nullable_to_non_nullable
as double,incomeConsistency: null == incomeConsistency ? _self.incomeConsistency : incomeConsistency // ignore: cast_nullable_to_non_nullable
as double,bestMonth: null == bestMonth ? _self.bestMonth : bestMonth // ignore: cast_nullable_to_non_nullable
as MonthlyPerformance,worstMonth: null == worstMonth ? _self.worstMonth : worstMonth // ignore: cast_nullable_to_non_nullable
as MonthlyPerformance,
  ));
}
/// Create a copy of FinancialHealthMetrics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthlyPerformanceCopyWith<$Res> get bestMonth {
  
  return $MonthlyPerformanceCopyWith<$Res>(_self.bestMonth, (value) {
    return _then(_self.copyWith(bestMonth: value));
  });
}/// Create a copy of FinancialHealthMetrics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthlyPerformanceCopyWith<$Res> get worstMonth {
  
  return $MonthlyPerformanceCopyWith<$Res>(_self.worstMonth, (value) {
    return _then(_self.copyWith(worstMonth: value));
  });
}
}


/// Adds pattern-matching-related methods to [FinancialHealthMetrics].
extension FinancialHealthMetricsPatterns on FinancialHealthMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialHealthMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialHealthMetrics() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialHealthMetrics value)  $default,){
final _that = this;
switch (_that) {
case _FinancialHealthMetrics():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialHealthMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialHealthMetrics() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double averageMonthlyIncome,  double averageMonthlyExpense,  double savingsRate,  double incomeConsistency,  MonthlyPerformance bestMonth,  MonthlyPerformance worstMonth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialHealthMetrics() when $default != null:
return $default(_that.averageMonthlyIncome,_that.averageMonthlyExpense,_that.savingsRate,_that.incomeConsistency,_that.bestMonth,_that.worstMonth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double averageMonthlyIncome,  double averageMonthlyExpense,  double savingsRate,  double incomeConsistency,  MonthlyPerformance bestMonth,  MonthlyPerformance worstMonth)  $default,) {final _that = this;
switch (_that) {
case _FinancialHealthMetrics():
return $default(_that.averageMonthlyIncome,_that.averageMonthlyExpense,_that.savingsRate,_that.incomeConsistency,_that.bestMonth,_that.worstMonth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double averageMonthlyIncome,  double averageMonthlyExpense,  double savingsRate,  double incomeConsistency,  MonthlyPerformance bestMonth,  MonthlyPerformance worstMonth)?  $default,) {final _that = this;
switch (_that) {
case _FinancialHealthMetrics() when $default != null:
return $default(_that.averageMonthlyIncome,_that.averageMonthlyExpense,_that.savingsRate,_that.incomeConsistency,_that.bestMonth,_that.worstMonth);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialHealthMetrics implements FinancialHealthMetrics {
  const _FinancialHealthMetrics({required this.averageMonthlyIncome, required this.averageMonthlyExpense, required this.savingsRate, required this.incomeConsistency, required this.bestMonth, required this.worstMonth});
  

/// Average monthly income over analyzed period
@override final  double averageMonthlyIncome;
/// Average monthly expenses over analyzed period
@override final  double averageMonthlyExpense;
/// Savings rate as percentage (income - expenses) / income * 100
@override final  double savingsRate;
/// Income consistency score (0-100, higher = more consistent)
@override final  double incomeConsistency;
/// Best performing month details
@override final  MonthlyPerformance bestMonth;
/// Worst performing month details
@override final  MonthlyPerformance worstMonth;

/// Create a copy of FinancialHealthMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialHealthMetricsCopyWith<_FinancialHealthMetrics> get copyWith => __$FinancialHealthMetricsCopyWithImpl<_FinancialHealthMetrics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialHealthMetrics&&(identical(other.averageMonthlyIncome, averageMonthlyIncome) || other.averageMonthlyIncome == averageMonthlyIncome)&&(identical(other.averageMonthlyExpense, averageMonthlyExpense) || other.averageMonthlyExpense == averageMonthlyExpense)&&(identical(other.savingsRate, savingsRate) || other.savingsRate == savingsRate)&&(identical(other.incomeConsistency, incomeConsistency) || other.incomeConsistency == incomeConsistency)&&(identical(other.bestMonth, bestMonth) || other.bestMonth == bestMonth)&&(identical(other.worstMonth, worstMonth) || other.worstMonth == worstMonth));
}


@override
int get hashCode => Object.hash(runtimeType,averageMonthlyIncome,averageMonthlyExpense,savingsRate,incomeConsistency,bestMonth,worstMonth);

@override
String toString() {
  return 'FinancialHealthMetrics(averageMonthlyIncome: $averageMonthlyIncome, averageMonthlyExpense: $averageMonthlyExpense, savingsRate: $savingsRate, incomeConsistency: $incomeConsistency, bestMonth: $bestMonth, worstMonth: $worstMonth)';
}


}

/// @nodoc
abstract mixin class _$FinancialHealthMetricsCopyWith<$Res> implements $FinancialHealthMetricsCopyWith<$Res> {
  factory _$FinancialHealthMetricsCopyWith(_FinancialHealthMetrics value, $Res Function(_FinancialHealthMetrics) _then) = __$FinancialHealthMetricsCopyWithImpl;
@override @useResult
$Res call({
 double averageMonthlyIncome, double averageMonthlyExpense, double savingsRate, double incomeConsistency, MonthlyPerformance bestMonth, MonthlyPerformance worstMonth
});


@override $MonthlyPerformanceCopyWith<$Res> get bestMonth;@override $MonthlyPerformanceCopyWith<$Res> get worstMonth;

}
/// @nodoc
class __$FinancialHealthMetricsCopyWithImpl<$Res>
    implements _$FinancialHealthMetricsCopyWith<$Res> {
  __$FinancialHealthMetricsCopyWithImpl(this._self, this._then);

  final _FinancialHealthMetrics _self;
  final $Res Function(_FinancialHealthMetrics) _then;

/// Create a copy of FinancialHealthMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? averageMonthlyIncome = null,Object? averageMonthlyExpense = null,Object? savingsRate = null,Object? incomeConsistency = null,Object? bestMonth = null,Object? worstMonth = null,}) {
  return _then(_FinancialHealthMetrics(
averageMonthlyIncome: null == averageMonthlyIncome ? _self.averageMonthlyIncome : averageMonthlyIncome // ignore: cast_nullable_to_non_nullable
as double,averageMonthlyExpense: null == averageMonthlyExpense ? _self.averageMonthlyExpense : averageMonthlyExpense // ignore: cast_nullable_to_non_nullable
as double,savingsRate: null == savingsRate ? _self.savingsRate : savingsRate // ignore: cast_nullable_to_non_nullable
as double,incomeConsistency: null == incomeConsistency ? _self.incomeConsistency : incomeConsistency // ignore: cast_nullable_to_non_nullable
as double,bestMonth: null == bestMonth ? _self.bestMonth : bestMonth // ignore: cast_nullable_to_non_nullable
as MonthlyPerformance,worstMonth: null == worstMonth ? _self.worstMonth : worstMonth // ignore: cast_nullable_to_non_nullable
as MonthlyPerformance,
  ));
}

/// Create a copy of FinancialHealthMetrics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthlyPerformanceCopyWith<$Res> get bestMonth {
  
  return $MonthlyPerformanceCopyWith<$Res>(_self.bestMonth, (value) {
    return _then(_self.copyWith(bestMonth: value));
  });
}/// Create a copy of FinancialHealthMetrics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthlyPerformanceCopyWith<$Res> get worstMonth {
  
  return $MonthlyPerformanceCopyWith<$Res>(_self.worstMonth, (value) {
    return _then(_self.copyWith(worstMonth: value));
  });
}
}

/// @nodoc
mixin _$MonthlyPerformance {

/// Month identifier in YYYY-MM format
 String get monthKey;/// Net balance at end of month
 double get netBalance;/// Savings rate for the month
 double get savingsRate;
/// Create a copy of MonthlyPerformance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyPerformanceCopyWith<MonthlyPerformance> get copyWith => _$MonthlyPerformanceCopyWithImpl<MonthlyPerformance>(this as MonthlyPerformance, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyPerformance&&(identical(other.monthKey, monthKey) || other.monthKey == monthKey)&&(identical(other.netBalance, netBalance) || other.netBalance == netBalance)&&(identical(other.savingsRate, savingsRate) || other.savingsRate == savingsRate));
}


@override
int get hashCode => Object.hash(runtimeType,monthKey,netBalance,savingsRate);

@override
String toString() {
  return 'MonthlyPerformance(monthKey: $monthKey, netBalance: $netBalance, savingsRate: $savingsRate)';
}


}

/// @nodoc
abstract mixin class $MonthlyPerformanceCopyWith<$Res>  {
  factory $MonthlyPerformanceCopyWith(MonthlyPerformance value, $Res Function(MonthlyPerformance) _then) = _$MonthlyPerformanceCopyWithImpl;
@useResult
$Res call({
 String monthKey, double netBalance, double savingsRate
});




}
/// @nodoc
class _$MonthlyPerformanceCopyWithImpl<$Res>
    implements $MonthlyPerformanceCopyWith<$Res> {
  _$MonthlyPerformanceCopyWithImpl(this._self, this._then);

  final MonthlyPerformance _self;
  final $Res Function(MonthlyPerformance) _then;

/// Create a copy of MonthlyPerformance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? monthKey = null,Object? netBalance = null,Object? savingsRate = null,}) {
  return _then(_self.copyWith(
monthKey: null == monthKey ? _self.monthKey : monthKey // ignore: cast_nullable_to_non_nullable
as String,netBalance: null == netBalance ? _self.netBalance : netBalance // ignore: cast_nullable_to_non_nullable
as double,savingsRate: null == savingsRate ? _self.savingsRate : savingsRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlyPerformance].
extension MonthlyPerformancePatterns on MonthlyPerformance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyPerformance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyPerformance() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyPerformance value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyPerformance():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyPerformance value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyPerformance() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String monthKey,  double netBalance,  double savingsRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyPerformance() when $default != null:
return $default(_that.monthKey,_that.netBalance,_that.savingsRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String monthKey,  double netBalance,  double savingsRate)  $default,) {final _that = this;
switch (_that) {
case _MonthlyPerformance():
return $default(_that.monthKey,_that.netBalance,_that.savingsRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String monthKey,  double netBalance,  double savingsRate)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyPerformance() when $default != null:
return $default(_that.monthKey,_that.netBalance,_that.savingsRate);case _:
  return null;

}
}

}

/// @nodoc


class _MonthlyPerformance implements MonthlyPerformance {
  const _MonthlyPerformance({required this.monthKey, required this.netBalance, required this.savingsRate});
  

/// Month identifier in YYYY-MM format
@override final  String monthKey;
/// Net balance at end of month
@override final  double netBalance;
/// Savings rate for the month
@override final  double savingsRate;

/// Create a copy of MonthlyPerformance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyPerformanceCopyWith<_MonthlyPerformance> get copyWith => __$MonthlyPerformanceCopyWithImpl<_MonthlyPerformance>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyPerformance&&(identical(other.monthKey, monthKey) || other.monthKey == monthKey)&&(identical(other.netBalance, netBalance) || other.netBalance == netBalance)&&(identical(other.savingsRate, savingsRate) || other.savingsRate == savingsRate));
}


@override
int get hashCode => Object.hash(runtimeType,monthKey,netBalance,savingsRate);

@override
String toString() {
  return 'MonthlyPerformance(monthKey: $monthKey, netBalance: $netBalance, savingsRate: $savingsRate)';
}


}

/// @nodoc
abstract mixin class _$MonthlyPerformanceCopyWith<$Res> implements $MonthlyPerformanceCopyWith<$Res> {
  factory _$MonthlyPerformanceCopyWith(_MonthlyPerformance value, $Res Function(_MonthlyPerformance) _then) = __$MonthlyPerformanceCopyWithImpl;
@override @useResult
$Res call({
 String monthKey, double netBalance, double savingsRate
});




}
/// @nodoc
class __$MonthlyPerformanceCopyWithImpl<$Res>
    implements _$MonthlyPerformanceCopyWith<$Res> {
  __$MonthlyPerformanceCopyWithImpl(this._self, this._then);

  final _MonthlyPerformance _self;
  final $Res Function(_MonthlyPerformance) _then;

/// Create a copy of MonthlyPerformance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? monthKey = null,Object? netBalance = null,Object? savingsRate = null,}) {
  return _then(_MonthlyPerformance(
monthKey: null == monthKey ? _self.monthKey : monthKey // ignore: cast_nullable_to_non_nullable
as String,netBalance: null == netBalance ? _self.netBalance : netBalance // ignore: cast_nullable_to_non_nullable
as double,savingsRate: null == savingsRate ? _self.savingsRate : savingsRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$FinancialInsight {

/// Unique identifier for the insight
 String get id;/// Type of insight for categorization
 InsightType get type;/// Severity level indicating importance
 InsightSeverity get severity;/// Short descriptive title
 String get title;/// Detailed explanation message
 String get message;/// When the insight was created
 DateTime get createdDate;/// Whether the user has acknowledged/read this insight
 bool get isRead;/// Optional metadata for additional context
 Map<String, dynamic>? get metadata;
/// Create a copy of FinancialInsight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialInsightCopyWith<FinancialInsight> get copyWith => _$FinancialInsightCopyWithImpl<FinancialInsight>(this as FinancialInsight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialInsight&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,severity,title,message,createdDate,isRead,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'FinancialInsight(id: $id, type: $type, severity: $severity, title: $title, message: $message, createdDate: $createdDate, isRead: $isRead, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $FinancialInsightCopyWith<$Res>  {
  factory $FinancialInsightCopyWith(FinancialInsight value, $Res Function(FinancialInsight) _then) = _$FinancialInsightCopyWithImpl;
@useResult
$Res call({
 String id, InsightType type, InsightSeverity severity, String title, String message, DateTime createdDate, bool isRead, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$FinancialInsightCopyWithImpl<$Res>
    implements $FinancialInsightCopyWith<$Res> {
  _$FinancialInsightCopyWithImpl(this._self, this._then);

  final FinancialInsight _self;
  final $Res Function(FinancialInsight) _then;

/// Create a copy of FinancialInsight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? severity = null,Object? title = null,Object? message = null,Object? createdDate = null,Object? isRead = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InsightType,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as InsightSeverity,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [FinancialInsight].
extension FinancialInsightPatterns on FinancialInsight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialInsight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialInsight() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialInsight value)  $default,){
final _that = this;
switch (_that) {
case _FinancialInsight():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialInsight value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialInsight() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  InsightType type,  InsightSeverity severity,  String title,  String message,  DateTime createdDate,  bool isRead,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialInsight() when $default != null:
return $default(_that.id,_that.type,_that.severity,_that.title,_that.message,_that.createdDate,_that.isRead,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  InsightType type,  InsightSeverity severity,  String title,  String message,  DateTime createdDate,  bool isRead,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _FinancialInsight():
return $default(_that.id,_that.type,_that.severity,_that.title,_that.message,_that.createdDate,_that.isRead,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  InsightType type,  InsightSeverity severity,  String title,  String message,  DateTime createdDate,  bool isRead,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _FinancialInsight() when $default != null:
return $default(_that.id,_that.type,_that.severity,_that.title,_that.message,_that.createdDate,_that.isRead,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialInsight implements FinancialInsight {
  const _FinancialInsight({required this.id, required this.type, required this.severity, required this.title, required this.message, required this.createdDate, required this.isRead, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  

/// Unique identifier for the insight
@override final  String id;
/// Type of insight for categorization
@override final  InsightType type;
/// Severity level indicating importance
@override final  InsightSeverity severity;
/// Short descriptive title
@override final  String title;
/// Detailed explanation message
@override final  String message;
/// When the insight was created
@override final  DateTime createdDate;
/// Whether the user has acknowledged/read this insight
@override final  bool isRead;
/// Optional metadata for additional context
 final  Map<String, dynamic>? _metadata;
/// Optional metadata for additional context
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of FinancialInsight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialInsightCopyWith<_FinancialInsight> get copyWith => __$FinancialInsightCopyWithImpl<_FinancialInsight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialInsight&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,severity,title,message,createdDate,isRead,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'FinancialInsight(id: $id, type: $type, severity: $severity, title: $title, message: $message, createdDate: $createdDate, isRead: $isRead, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$FinancialInsightCopyWith<$Res> implements $FinancialInsightCopyWith<$Res> {
  factory _$FinancialInsightCopyWith(_FinancialInsight value, $Res Function(_FinancialInsight) _then) = __$FinancialInsightCopyWithImpl;
@override @useResult
$Res call({
 String id, InsightType type, InsightSeverity severity, String title, String message, DateTime createdDate, bool isRead, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$FinancialInsightCopyWithImpl<$Res>
    implements _$FinancialInsightCopyWith<$Res> {
  __$FinancialInsightCopyWithImpl(this._self, this._then);

  final _FinancialInsight _self;
  final $Res Function(_FinancialInsight) _then;

/// Create a copy of FinancialInsight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? severity = null,Object? title = null,Object? message = null,Object? createdDate = null,Object? isRead = null,Object? metadata = freezed,}) {
  return _then(_FinancialInsight(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InsightType,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as InsightSeverity,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
