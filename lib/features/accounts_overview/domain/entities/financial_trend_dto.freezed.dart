// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_trend_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FinancialTrendDTO {
  /// Monthly balance points showing cumulative net worth trend
  List<MonthlyBalancePoint> get netBalanceTrend =>
      throw _privateConstructorUsedError;

  /// Monthly income vs expense comparisons for bar chart
  List<IncomeExpenseComparison> get monthlyComparisons =>
      throw _privateConstructorUsedError;

  /// Key financial health metrics
  FinancialHealthMetrics get healthMetrics =>
      throw _privateConstructorUsedError;

  /// Intelligent insights about financial patterns
  List<FinancialInsight> get insights => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FinancialTrendDTOCopyWith<FinancialTrendDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialTrendDTOCopyWith<$Res> {
  factory $FinancialTrendDTOCopyWith(
          FinancialTrendDTO value, $Res Function(FinancialTrendDTO) then) =
      _$FinancialTrendDTOCopyWithImpl<$Res, FinancialTrendDTO>;
  @useResult
  $Res call(
      {List<MonthlyBalancePoint> netBalanceTrend,
      List<IncomeExpenseComparison> monthlyComparisons,
      FinancialHealthMetrics healthMetrics,
      List<FinancialInsight> insights});

  $FinancialHealthMetricsCopyWith<$Res> get healthMetrics;
}

/// @nodoc
class _$FinancialTrendDTOCopyWithImpl<$Res, $Val extends FinancialTrendDTO>
    implements $FinancialTrendDTOCopyWith<$Res> {
  _$FinancialTrendDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? netBalanceTrend = null,
    Object? monthlyComparisons = null,
    Object? healthMetrics = null,
    Object? insights = null,
  }) {
    return _then(_value.copyWith(
      netBalanceTrend: null == netBalanceTrend
          ? _value.netBalanceTrend
          : netBalanceTrend // ignore: cast_nullable_to_non_nullable
              as List<MonthlyBalancePoint>,
      monthlyComparisons: null == monthlyComparisons
          ? _value.monthlyComparisons
          : monthlyComparisons // ignore: cast_nullable_to_non_nullable
              as List<IncomeExpenseComparison>,
      healthMetrics: null == healthMetrics
          ? _value.healthMetrics
          : healthMetrics // ignore: cast_nullable_to_non_nullable
              as FinancialHealthMetrics,
      insights: null == insights
          ? _value.insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<FinancialInsight>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FinancialHealthMetricsCopyWith<$Res> get healthMetrics {
    return $FinancialHealthMetricsCopyWith<$Res>(_value.healthMetrics, (value) {
      return _then(_value.copyWith(healthMetrics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FinancialTrendDTOImplCopyWith<$Res>
    implements $FinancialTrendDTOCopyWith<$Res> {
  factory _$$FinancialTrendDTOImplCopyWith(_$FinancialTrendDTOImpl value,
          $Res Function(_$FinancialTrendDTOImpl) then) =
      __$$FinancialTrendDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<MonthlyBalancePoint> netBalanceTrend,
      List<IncomeExpenseComparison> monthlyComparisons,
      FinancialHealthMetrics healthMetrics,
      List<FinancialInsight> insights});

  @override
  $FinancialHealthMetricsCopyWith<$Res> get healthMetrics;
}

/// @nodoc
class __$$FinancialTrendDTOImplCopyWithImpl<$Res>
    extends _$FinancialTrendDTOCopyWithImpl<$Res, _$FinancialTrendDTOImpl>
    implements _$$FinancialTrendDTOImplCopyWith<$Res> {
  __$$FinancialTrendDTOImplCopyWithImpl(_$FinancialTrendDTOImpl _value,
      $Res Function(_$FinancialTrendDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? netBalanceTrend = null,
    Object? monthlyComparisons = null,
    Object? healthMetrics = null,
    Object? insights = null,
  }) {
    return _then(_$FinancialTrendDTOImpl(
      netBalanceTrend: null == netBalanceTrend
          ? _value._netBalanceTrend
          : netBalanceTrend // ignore: cast_nullable_to_non_nullable
              as List<MonthlyBalancePoint>,
      monthlyComparisons: null == monthlyComparisons
          ? _value._monthlyComparisons
          : monthlyComparisons // ignore: cast_nullable_to_non_nullable
              as List<IncomeExpenseComparison>,
      healthMetrics: null == healthMetrics
          ? _value.healthMetrics
          : healthMetrics // ignore: cast_nullable_to_non_nullable
              as FinancialHealthMetrics,
      insights: null == insights
          ? _value._insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<FinancialInsight>,
    ));
  }
}

/// @nodoc

class _$FinancialTrendDTOImpl implements _FinancialTrendDTO {
  const _$FinancialTrendDTOImpl(
      {required final List<MonthlyBalancePoint> netBalanceTrend,
      required final List<IncomeExpenseComparison> monthlyComparisons,
      required this.healthMetrics,
      required final List<FinancialInsight> insights})
      : _netBalanceTrend = netBalanceTrend,
        _monthlyComparisons = monthlyComparisons,
        _insights = insights;

  /// Monthly balance points showing cumulative net worth trend
  final List<MonthlyBalancePoint> _netBalanceTrend;

  /// Monthly balance points showing cumulative net worth trend
  @override
  List<MonthlyBalancePoint> get netBalanceTrend {
    if (_netBalanceTrend is EqualUnmodifiableListView) return _netBalanceTrend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_netBalanceTrend);
  }

  /// Monthly income vs expense comparisons for bar chart
  final List<IncomeExpenseComparison> _monthlyComparisons;

  /// Monthly income vs expense comparisons for bar chart
  @override
  List<IncomeExpenseComparison> get monthlyComparisons {
    if (_monthlyComparisons is EqualUnmodifiableListView)
      return _monthlyComparisons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyComparisons);
  }

  /// Key financial health metrics
  @override
  final FinancialHealthMetrics healthMetrics;

  /// Intelligent insights about financial patterns
  final List<FinancialInsight> _insights;

  /// Intelligent insights about financial patterns
  @override
  List<FinancialInsight> get insights {
    if (_insights is EqualUnmodifiableListView) return _insights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_insights);
  }

  @override
  String toString() {
    return 'FinancialTrendDTO(netBalanceTrend: $netBalanceTrend, monthlyComparisons: $monthlyComparisons, healthMetrics: $healthMetrics, insights: $insights)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialTrendDTOImpl &&
            const DeepCollectionEquality()
                .equals(other._netBalanceTrend, _netBalanceTrend) &&
            const DeepCollectionEquality()
                .equals(other._monthlyComparisons, _monthlyComparisons) &&
            (identical(other.healthMetrics, healthMetrics) ||
                other.healthMetrics == healthMetrics) &&
            const DeepCollectionEquality().equals(other._insights, _insights));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_netBalanceTrend),
      const DeepCollectionEquality().hash(_monthlyComparisons),
      healthMetrics,
      const DeepCollectionEquality().hash(_insights));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialTrendDTOImplCopyWith<_$FinancialTrendDTOImpl> get copyWith =>
      __$$FinancialTrendDTOImplCopyWithImpl<_$FinancialTrendDTOImpl>(
          this, _$identity);
}

abstract class _FinancialTrendDTO implements FinancialTrendDTO {
  const factory _FinancialTrendDTO(
          {required final List<MonthlyBalancePoint> netBalanceTrend,
          required final List<IncomeExpenseComparison> monthlyComparisons,
          required final FinancialHealthMetrics healthMetrics,
          required final List<FinancialInsight> insights}) =
      _$FinancialTrendDTOImpl;

  @override

  /// Monthly balance points showing cumulative net worth trend
  List<MonthlyBalancePoint> get netBalanceTrend;
  @override

  /// Monthly income vs expense comparisons for bar chart
  List<IncomeExpenseComparison> get monthlyComparisons;
  @override

  /// Key financial health metrics
  FinancialHealthMetrics get healthMetrics;
  @override

  /// Intelligent insights about financial patterns
  List<FinancialInsight> get insights;
  @override
  @JsonKey(ignore: true)
  _$$FinancialTrendDTOImplCopyWith<_$FinancialTrendDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MonthlyBalancePoint {
  /// Month identifier in YYYY-MM format
  String get monthKey => throw _privateConstructorUsedError;

  /// First day of the month for chart positioning
  DateTime get date => throw _privateConstructorUsedError;

  /// Cumulative net balance at end of month
  double get cumulativeBalance => throw _privateConstructorUsedError;

  /// Total income for this month
  double get monthlyIncome => throw _privateConstructorUsedError;

  /// Total expenses for this month
  double get monthlyExpense => throw _privateConstructorUsedError;

  /// Net change for this month (income - expense)
  double get netChange => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MonthlyBalancePointCopyWith<MonthlyBalancePoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyBalancePointCopyWith<$Res> {
  factory $MonthlyBalancePointCopyWith(
          MonthlyBalancePoint value, $Res Function(MonthlyBalancePoint) then) =
      _$MonthlyBalancePointCopyWithImpl<$Res, MonthlyBalancePoint>;
  @useResult
  $Res call(
      {String monthKey,
      DateTime date,
      double cumulativeBalance,
      double monthlyIncome,
      double monthlyExpense,
      double netChange});
}

/// @nodoc
class _$MonthlyBalancePointCopyWithImpl<$Res, $Val extends MonthlyBalancePoint>
    implements $MonthlyBalancePointCopyWith<$Res> {
  _$MonthlyBalancePointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthKey = null,
    Object? date = null,
    Object? cumulativeBalance = null,
    Object? monthlyIncome = null,
    Object? monthlyExpense = null,
    Object? netChange = null,
  }) {
    return _then(_value.copyWith(
      monthKey: null == monthKey
          ? _value.monthKey
          : monthKey // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cumulativeBalance: null == cumulativeBalance
          ? _value.cumulativeBalance
          : cumulativeBalance // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyIncome: null == monthlyIncome
          ? _value.monthlyIncome
          : monthlyIncome // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyExpense: null == monthlyExpense
          ? _value.monthlyExpense
          : monthlyExpense // ignore: cast_nullable_to_non_nullable
              as double,
      netChange: null == netChange
          ? _value.netChange
          : netChange // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlyBalancePointImplCopyWith<$Res>
    implements $MonthlyBalancePointCopyWith<$Res> {
  factory _$$MonthlyBalancePointImplCopyWith(_$MonthlyBalancePointImpl value,
          $Res Function(_$MonthlyBalancePointImpl) then) =
      __$$MonthlyBalancePointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String monthKey,
      DateTime date,
      double cumulativeBalance,
      double monthlyIncome,
      double monthlyExpense,
      double netChange});
}

/// @nodoc
class __$$MonthlyBalancePointImplCopyWithImpl<$Res>
    extends _$MonthlyBalancePointCopyWithImpl<$Res, _$MonthlyBalancePointImpl>
    implements _$$MonthlyBalancePointImplCopyWith<$Res> {
  __$$MonthlyBalancePointImplCopyWithImpl(_$MonthlyBalancePointImpl _value,
      $Res Function(_$MonthlyBalancePointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthKey = null,
    Object? date = null,
    Object? cumulativeBalance = null,
    Object? monthlyIncome = null,
    Object? monthlyExpense = null,
    Object? netChange = null,
  }) {
    return _then(_$MonthlyBalancePointImpl(
      monthKey: null == monthKey
          ? _value.monthKey
          : monthKey // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cumulativeBalance: null == cumulativeBalance
          ? _value.cumulativeBalance
          : cumulativeBalance // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyIncome: null == monthlyIncome
          ? _value.monthlyIncome
          : monthlyIncome // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyExpense: null == monthlyExpense
          ? _value.monthlyExpense
          : monthlyExpense // ignore: cast_nullable_to_non_nullable
              as double,
      netChange: null == netChange
          ? _value.netChange
          : netChange // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$MonthlyBalancePointImpl implements _MonthlyBalancePoint {
  const _$MonthlyBalancePointImpl(
      {required this.monthKey,
      required this.date,
      required this.cumulativeBalance,
      required this.monthlyIncome,
      required this.monthlyExpense,
      required this.netChange});

  /// Month identifier in YYYY-MM format
  @override
  final String monthKey;

  /// First day of the month for chart positioning
  @override
  final DateTime date;

  /// Cumulative net balance at end of month
  @override
  final double cumulativeBalance;

  /// Total income for this month
  @override
  final double monthlyIncome;

  /// Total expenses for this month
  @override
  final double monthlyExpense;

  /// Net change for this month (income - expense)
  @override
  final double netChange;

  @override
  String toString() {
    return 'MonthlyBalancePoint(monthKey: $monthKey, date: $date, cumulativeBalance: $cumulativeBalance, monthlyIncome: $monthlyIncome, monthlyExpense: $monthlyExpense, netChange: $netChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyBalancePointImpl &&
            (identical(other.monthKey, monthKey) ||
                other.monthKey == monthKey) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.cumulativeBalance, cumulativeBalance) ||
                other.cumulativeBalance == cumulativeBalance) &&
            (identical(other.monthlyIncome, monthlyIncome) ||
                other.monthlyIncome == monthlyIncome) &&
            (identical(other.monthlyExpense, monthlyExpense) ||
                other.monthlyExpense == monthlyExpense) &&
            (identical(other.netChange, netChange) ||
                other.netChange == netChange));
  }

  @override
  int get hashCode => Object.hash(runtimeType, monthKey, date,
      cumulativeBalance, monthlyIncome, monthlyExpense, netChange);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyBalancePointImplCopyWith<_$MonthlyBalancePointImpl> get copyWith =>
      __$$MonthlyBalancePointImplCopyWithImpl<_$MonthlyBalancePointImpl>(
          this, _$identity);
}

abstract class _MonthlyBalancePoint implements MonthlyBalancePoint {
  const factory _MonthlyBalancePoint(
      {required final String monthKey,
      required final DateTime date,
      required final double cumulativeBalance,
      required final double monthlyIncome,
      required final double monthlyExpense,
      required final double netChange}) = _$MonthlyBalancePointImpl;

  @override

  /// Month identifier in YYYY-MM format
  String get monthKey;
  @override

  /// First day of the month for chart positioning
  DateTime get date;
  @override

  /// Cumulative net balance at end of month
  double get cumulativeBalance;
  @override

  /// Total income for this month
  double get monthlyIncome;
  @override

  /// Total expenses for this month
  double get monthlyExpense;
  @override

  /// Net change for this month (income - expense)
  double get netChange;
  @override
  @JsonKey(ignore: true)
  _$$MonthlyBalancePointImplCopyWith<_$MonthlyBalancePointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IncomeExpenseComparison {
  /// Month identifier in YYYY-MM format
  String get monthKey => throw _privateConstructorUsedError;

  /// Total income for the month
  double get income => throw _privateConstructorUsedError;

  /// Total expenses for the month
  double get expense => throw _privateConstructorUsedError;

  /// Difference (income - expense)
  double get difference => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IncomeExpenseComparisonCopyWith<IncomeExpenseComparison> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeExpenseComparisonCopyWith<$Res> {
  factory $IncomeExpenseComparisonCopyWith(IncomeExpenseComparison value,
          $Res Function(IncomeExpenseComparison) then) =
      _$IncomeExpenseComparisonCopyWithImpl<$Res, IncomeExpenseComparison>;
  @useResult
  $Res call(
      {String monthKey, double income, double expense, double difference});
}

/// @nodoc
class _$IncomeExpenseComparisonCopyWithImpl<$Res,
        $Val extends IncomeExpenseComparison>
    implements $IncomeExpenseComparisonCopyWith<$Res> {
  _$IncomeExpenseComparisonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthKey = null,
    Object? income = null,
    Object? expense = null,
    Object? difference = null,
  }) {
    return _then(_value.copyWith(
      monthKey: null == monthKey
          ? _value.monthKey
          : monthKey // ignore: cast_nullable_to_non_nullable
              as String,
      income: null == income
          ? _value.income
          : income // ignore: cast_nullable_to_non_nullable
              as double,
      expense: null == expense
          ? _value.expense
          : expense // ignore: cast_nullable_to_non_nullable
              as double,
      difference: null == difference
          ? _value.difference
          : difference // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IncomeExpenseComparisonImplCopyWith<$Res>
    implements $IncomeExpenseComparisonCopyWith<$Res> {
  factory _$$IncomeExpenseComparisonImplCopyWith(
          _$IncomeExpenseComparisonImpl value,
          $Res Function(_$IncomeExpenseComparisonImpl) then) =
      __$$IncomeExpenseComparisonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String monthKey, double income, double expense, double difference});
}

/// @nodoc
class __$$IncomeExpenseComparisonImplCopyWithImpl<$Res>
    extends _$IncomeExpenseComparisonCopyWithImpl<$Res,
        _$IncomeExpenseComparisonImpl>
    implements _$$IncomeExpenseComparisonImplCopyWith<$Res> {
  __$$IncomeExpenseComparisonImplCopyWithImpl(
      _$IncomeExpenseComparisonImpl _value,
      $Res Function(_$IncomeExpenseComparisonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthKey = null,
    Object? income = null,
    Object? expense = null,
    Object? difference = null,
  }) {
    return _then(_$IncomeExpenseComparisonImpl(
      monthKey: null == monthKey
          ? _value.monthKey
          : monthKey // ignore: cast_nullable_to_non_nullable
              as String,
      income: null == income
          ? _value.income
          : income // ignore: cast_nullable_to_non_nullable
              as double,
      expense: null == expense
          ? _value.expense
          : expense // ignore: cast_nullable_to_non_nullable
              as double,
      difference: null == difference
          ? _value.difference
          : difference // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$IncomeExpenseComparisonImpl implements _IncomeExpenseComparison {
  const _$IncomeExpenseComparisonImpl(
      {required this.monthKey,
      required this.income,
      required this.expense,
      required this.difference});

  /// Month identifier in YYYY-MM format
  @override
  final String monthKey;

  /// Total income for the month
  @override
  final double income;

  /// Total expenses for the month
  @override
  final double expense;

  /// Difference (income - expense)
  @override
  final double difference;

  @override
  String toString() {
    return 'IncomeExpenseComparison(monthKey: $monthKey, income: $income, expense: $expense, difference: $difference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomeExpenseComparisonImpl &&
            (identical(other.monthKey, monthKey) ||
                other.monthKey == monthKey) &&
            (identical(other.income, income) || other.income == income) &&
            (identical(other.expense, expense) || other.expense == expense) &&
            (identical(other.difference, difference) ||
                other.difference == difference));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, monthKey, income, expense, difference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomeExpenseComparisonImplCopyWith<_$IncomeExpenseComparisonImpl>
      get copyWith => __$$IncomeExpenseComparisonImplCopyWithImpl<
          _$IncomeExpenseComparisonImpl>(this, _$identity);
}

abstract class _IncomeExpenseComparison implements IncomeExpenseComparison {
  const factory _IncomeExpenseComparison(
      {required final String monthKey,
      required final double income,
      required final double expense,
      required final double difference}) = _$IncomeExpenseComparisonImpl;

  @override

  /// Month identifier in YYYY-MM format
  String get monthKey;
  @override

  /// Total income for the month
  double get income;
  @override

  /// Total expenses for the month
  double get expense;
  @override

  /// Difference (income - expense)
  double get difference;
  @override
  @JsonKey(ignore: true)
  _$$IncomeExpenseComparisonImplCopyWith<_$IncomeExpenseComparisonImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FinancialHealthMetrics {
  /// Average monthly income over analyzed period
  double get averageMonthlyIncome => throw _privateConstructorUsedError;

  /// Average monthly expenses over analyzed period
  double get averageMonthlyExpense => throw _privateConstructorUsedError;

  /// Savings rate as percentage (income - expenses) / income * 100
  double get savingsRate => throw _privateConstructorUsedError;

  /// Income consistency score (0-100, higher = more consistent)
  double get incomeConsistency => throw _privateConstructorUsedError;

  /// Best performing month details
  MonthlyPerformance get bestMonth => throw _privateConstructorUsedError;

  /// Worst performing month details
  MonthlyPerformance get worstMonth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FinancialHealthMetricsCopyWith<FinancialHealthMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialHealthMetricsCopyWith<$Res> {
  factory $FinancialHealthMetricsCopyWith(FinancialHealthMetrics value,
          $Res Function(FinancialHealthMetrics) then) =
      _$FinancialHealthMetricsCopyWithImpl<$Res, FinancialHealthMetrics>;
  @useResult
  $Res call(
      {double averageMonthlyIncome,
      double averageMonthlyExpense,
      double savingsRate,
      double incomeConsistency,
      MonthlyPerformance bestMonth,
      MonthlyPerformance worstMonth});

  $MonthlyPerformanceCopyWith<$Res> get bestMonth;
  $MonthlyPerformanceCopyWith<$Res> get worstMonth;
}

/// @nodoc
class _$FinancialHealthMetricsCopyWithImpl<$Res,
        $Val extends FinancialHealthMetrics>
    implements $FinancialHealthMetricsCopyWith<$Res> {
  _$FinancialHealthMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageMonthlyIncome = null,
    Object? averageMonthlyExpense = null,
    Object? savingsRate = null,
    Object? incomeConsistency = null,
    Object? bestMonth = null,
    Object? worstMonth = null,
  }) {
    return _then(_value.copyWith(
      averageMonthlyIncome: null == averageMonthlyIncome
          ? _value.averageMonthlyIncome
          : averageMonthlyIncome // ignore: cast_nullable_to_non_nullable
              as double,
      averageMonthlyExpense: null == averageMonthlyExpense
          ? _value.averageMonthlyExpense
          : averageMonthlyExpense // ignore: cast_nullable_to_non_nullable
              as double,
      savingsRate: null == savingsRate
          ? _value.savingsRate
          : savingsRate // ignore: cast_nullable_to_non_nullable
              as double,
      incomeConsistency: null == incomeConsistency
          ? _value.incomeConsistency
          : incomeConsistency // ignore: cast_nullable_to_non_nullable
              as double,
      bestMonth: null == bestMonth
          ? _value.bestMonth
          : bestMonth // ignore: cast_nullable_to_non_nullable
              as MonthlyPerformance,
      worstMonth: null == worstMonth
          ? _value.worstMonth
          : worstMonth // ignore: cast_nullable_to_non_nullable
              as MonthlyPerformance,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MonthlyPerformanceCopyWith<$Res> get bestMonth {
    return $MonthlyPerformanceCopyWith<$Res>(_value.bestMonth, (value) {
      return _then(_value.copyWith(bestMonth: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MonthlyPerformanceCopyWith<$Res> get worstMonth {
    return $MonthlyPerformanceCopyWith<$Res>(_value.worstMonth, (value) {
      return _then(_value.copyWith(worstMonth: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FinancialHealthMetricsImplCopyWith<$Res>
    implements $FinancialHealthMetricsCopyWith<$Res> {
  factory _$$FinancialHealthMetricsImplCopyWith(
          _$FinancialHealthMetricsImpl value,
          $Res Function(_$FinancialHealthMetricsImpl) then) =
      __$$FinancialHealthMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double averageMonthlyIncome,
      double averageMonthlyExpense,
      double savingsRate,
      double incomeConsistency,
      MonthlyPerformance bestMonth,
      MonthlyPerformance worstMonth});

  @override
  $MonthlyPerformanceCopyWith<$Res> get bestMonth;
  @override
  $MonthlyPerformanceCopyWith<$Res> get worstMonth;
}

/// @nodoc
class __$$FinancialHealthMetricsImplCopyWithImpl<$Res>
    extends _$FinancialHealthMetricsCopyWithImpl<$Res,
        _$FinancialHealthMetricsImpl>
    implements _$$FinancialHealthMetricsImplCopyWith<$Res> {
  __$$FinancialHealthMetricsImplCopyWithImpl(
      _$FinancialHealthMetricsImpl _value,
      $Res Function(_$FinancialHealthMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageMonthlyIncome = null,
    Object? averageMonthlyExpense = null,
    Object? savingsRate = null,
    Object? incomeConsistency = null,
    Object? bestMonth = null,
    Object? worstMonth = null,
  }) {
    return _then(_$FinancialHealthMetricsImpl(
      averageMonthlyIncome: null == averageMonthlyIncome
          ? _value.averageMonthlyIncome
          : averageMonthlyIncome // ignore: cast_nullable_to_non_nullable
              as double,
      averageMonthlyExpense: null == averageMonthlyExpense
          ? _value.averageMonthlyExpense
          : averageMonthlyExpense // ignore: cast_nullable_to_non_nullable
              as double,
      savingsRate: null == savingsRate
          ? _value.savingsRate
          : savingsRate // ignore: cast_nullable_to_non_nullable
              as double,
      incomeConsistency: null == incomeConsistency
          ? _value.incomeConsistency
          : incomeConsistency // ignore: cast_nullable_to_non_nullable
              as double,
      bestMonth: null == bestMonth
          ? _value.bestMonth
          : bestMonth // ignore: cast_nullable_to_non_nullable
              as MonthlyPerformance,
      worstMonth: null == worstMonth
          ? _value.worstMonth
          : worstMonth // ignore: cast_nullable_to_non_nullable
              as MonthlyPerformance,
    ));
  }
}

/// @nodoc

class _$FinancialHealthMetricsImpl implements _FinancialHealthMetrics {
  const _$FinancialHealthMetricsImpl(
      {required this.averageMonthlyIncome,
      required this.averageMonthlyExpense,
      required this.savingsRate,
      required this.incomeConsistency,
      required this.bestMonth,
      required this.worstMonth});

  /// Average monthly income over analyzed period
  @override
  final double averageMonthlyIncome;

  /// Average monthly expenses over analyzed period
  @override
  final double averageMonthlyExpense;

  /// Savings rate as percentage (income - expenses) / income * 100
  @override
  final double savingsRate;

  /// Income consistency score (0-100, higher = more consistent)
  @override
  final double incomeConsistency;

  /// Best performing month details
  @override
  final MonthlyPerformance bestMonth;

  /// Worst performing month details
  @override
  final MonthlyPerformance worstMonth;

  @override
  String toString() {
    return 'FinancialHealthMetrics(averageMonthlyIncome: $averageMonthlyIncome, averageMonthlyExpense: $averageMonthlyExpense, savingsRate: $savingsRate, incomeConsistency: $incomeConsistency, bestMonth: $bestMonth, worstMonth: $worstMonth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialHealthMetricsImpl &&
            (identical(other.averageMonthlyIncome, averageMonthlyIncome) ||
                other.averageMonthlyIncome == averageMonthlyIncome) &&
            (identical(other.averageMonthlyExpense, averageMonthlyExpense) ||
                other.averageMonthlyExpense == averageMonthlyExpense) &&
            (identical(other.savingsRate, savingsRate) ||
                other.savingsRate == savingsRate) &&
            (identical(other.incomeConsistency, incomeConsistency) ||
                other.incomeConsistency == incomeConsistency) &&
            (identical(other.bestMonth, bestMonth) ||
                other.bestMonth == bestMonth) &&
            (identical(other.worstMonth, worstMonth) ||
                other.worstMonth == worstMonth));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      averageMonthlyIncome,
      averageMonthlyExpense,
      savingsRate,
      incomeConsistency,
      bestMonth,
      worstMonth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialHealthMetricsImplCopyWith<_$FinancialHealthMetricsImpl>
      get copyWith => __$$FinancialHealthMetricsImplCopyWithImpl<
          _$FinancialHealthMetricsImpl>(this, _$identity);
}

abstract class _FinancialHealthMetrics implements FinancialHealthMetrics {
  const factory _FinancialHealthMetrics(
          {required final double averageMonthlyIncome,
          required final double averageMonthlyExpense,
          required final double savingsRate,
          required final double incomeConsistency,
          required final MonthlyPerformance bestMonth,
          required final MonthlyPerformance worstMonth}) =
      _$FinancialHealthMetricsImpl;

  @override

  /// Average monthly income over analyzed period
  double get averageMonthlyIncome;
  @override

  /// Average monthly expenses over analyzed period
  double get averageMonthlyExpense;
  @override

  /// Savings rate as percentage (income - expenses) / income * 100
  double get savingsRate;
  @override

  /// Income consistency score (0-100, higher = more consistent)
  double get incomeConsistency;
  @override

  /// Best performing month details
  MonthlyPerformance get bestMonth;
  @override

  /// Worst performing month details
  MonthlyPerformance get worstMonth;
  @override
  @JsonKey(ignore: true)
  _$$FinancialHealthMetricsImplCopyWith<_$FinancialHealthMetricsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MonthlyPerformance {
  /// Month identifier in YYYY-MM format
  String get monthKey => throw _privateConstructorUsedError;

  /// Net balance at end of month
  double get netBalance => throw _privateConstructorUsedError;

  /// Savings rate for the month
  double get savingsRate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MonthlyPerformanceCopyWith<MonthlyPerformance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyPerformanceCopyWith<$Res> {
  factory $MonthlyPerformanceCopyWith(
          MonthlyPerformance value, $Res Function(MonthlyPerformance) then) =
      _$MonthlyPerformanceCopyWithImpl<$Res, MonthlyPerformance>;
  @useResult
  $Res call({String monthKey, double netBalance, double savingsRate});
}

/// @nodoc
class _$MonthlyPerformanceCopyWithImpl<$Res, $Val extends MonthlyPerformance>
    implements $MonthlyPerformanceCopyWith<$Res> {
  _$MonthlyPerformanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthKey = null,
    Object? netBalance = null,
    Object? savingsRate = null,
  }) {
    return _then(_value.copyWith(
      monthKey: null == monthKey
          ? _value.monthKey
          : monthKey // ignore: cast_nullable_to_non_nullable
              as String,
      netBalance: null == netBalance
          ? _value.netBalance
          : netBalance // ignore: cast_nullable_to_non_nullable
              as double,
      savingsRate: null == savingsRate
          ? _value.savingsRate
          : savingsRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlyPerformanceImplCopyWith<$Res>
    implements $MonthlyPerformanceCopyWith<$Res> {
  factory _$$MonthlyPerformanceImplCopyWith(_$MonthlyPerformanceImpl value,
          $Res Function(_$MonthlyPerformanceImpl) then) =
      __$$MonthlyPerformanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String monthKey, double netBalance, double savingsRate});
}

/// @nodoc
class __$$MonthlyPerformanceImplCopyWithImpl<$Res>
    extends _$MonthlyPerformanceCopyWithImpl<$Res, _$MonthlyPerformanceImpl>
    implements _$$MonthlyPerformanceImplCopyWith<$Res> {
  __$$MonthlyPerformanceImplCopyWithImpl(_$MonthlyPerformanceImpl _value,
      $Res Function(_$MonthlyPerformanceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthKey = null,
    Object? netBalance = null,
    Object? savingsRate = null,
  }) {
    return _then(_$MonthlyPerformanceImpl(
      monthKey: null == monthKey
          ? _value.monthKey
          : monthKey // ignore: cast_nullable_to_non_nullable
              as String,
      netBalance: null == netBalance
          ? _value.netBalance
          : netBalance // ignore: cast_nullable_to_non_nullable
              as double,
      savingsRate: null == savingsRate
          ? _value.savingsRate
          : savingsRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$MonthlyPerformanceImpl implements _MonthlyPerformance {
  const _$MonthlyPerformanceImpl(
      {required this.monthKey,
      required this.netBalance,
      required this.savingsRate});

  /// Month identifier in YYYY-MM format
  @override
  final String monthKey;

  /// Net balance at end of month
  @override
  final double netBalance;

  /// Savings rate for the month
  @override
  final double savingsRate;

  @override
  String toString() {
    return 'MonthlyPerformance(monthKey: $monthKey, netBalance: $netBalance, savingsRate: $savingsRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyPerformanceImpl &&
            (identical(other.monthKey, monthKey) ||
                other.monthKey == monthKey) &&
            (identical(other.netBalance, netBalance) ||
                other.netBalance == netBalance) &&
            (identical(other.savingsRate, savingsRate) ||
                other.savingsRate == savingsRate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, monthKey, netBalance, savingsRate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyPerformanceImplCopyWith<_$MonthlyPerformanceImpl> get copyWith =>
      __$$MonthlyPerformanceImplCopyWithImpl<_$MonthlyPerformanceImpl>(
          this, _$identity);
}

abstract class _MonthlyPerformance implements MonthlyPerformance {
  const factory _MonthlyPerformance(
      {required final String monthKey,
      required final double netBalance,
      required final double savingsRate}) = _$MonthlyPerformanceImpl;

  @override

  /// Month identifier in YYYY-MM format
  String get monthKey;
  @override

  /// Net balance at end of month
  double get netBalance;
  @override

  /// Savings rate for the month
  double get savingsRate;
  @override
  @JsonKey(ignore: true)
  _$$MonthlyPerformanceImplCopyWith<_$MonthlyPerformanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FinancialInsight {
  /// Unique identifier for the insight
  String get id => throw _privateConstructorUsedError;

  /// Type of insight for categorization
  InsightType get type => throw _privateConstructorUsedError;

  /// Severity level indicating importance
  InsightSeverity get severity => throw _privateConstructorUsedError;

  /// Short descriptive title
  String get title => throw _privateConstructorUsedError;

  /// Detailed explanation message
  String get message => throw _privateConstructorUsedError;

  /// When the insight was created
  DateTime get createdDate => throw _privateConstructorUsedError;

  /// Whether the user has acknowledged/read this insight
  bool get isRead => throw _privateConstructorUsedError;

  /// Optional metadata for additional context
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FinancialInsightCopyWith<FinancialInsight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialInsightCopyWith<$Res> {
  factory $FinancialInsightCopyWith(
          FinancialInsight value, $Res Function(FinancialInsight) then) =
      _$FinancialInsightCopyWithImpl<$Res, FinancialInsight>;
  @useResult
  $Res call(
      {String id,
      InsightType type,
      InsightSeverity severity,
      String title,
      String message,
      DateTime createdDate,
      bool isRead,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$FinancialInsightCopyWithImpl<$Res, $Val extends FinancialInsight>
    implements $FinancialInsightCopyWith<$Res> {
  _$FinancialInsightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? severity = null,
    Object? title = null,
    Object? message = null,
    Object? createdDate = null,
    Object? isRead = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InsightType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as InsightSeverity,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdDate: null == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FinancialInsightImplCopyWith<$Res>
    implements $FinancialInsightCopyWith<$Res> {
  factory _$$FinancialInsightImplCopyWith(_$FinancialInsightImpl value,
          $Res Function(_$FinancialInsightImpl) then) =
      __$$FinancialInsightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      InsightType type,
      InsightSeverity severity,
      String title,
      String message,
      DateTime createdDate,
      bool isRead,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$FinancialInsightImplCopyWithImpl<$Res>
    extends _$FinancialInsightCopyWithImpl<$Res, _$FinancialInsightImpl>
    implements _$$FinancialInsightImplCopyWith<$Res> {
  __$$FinancialInsightImplCopyWithImpl(_$FinancialInsightImpl _value,
      $Res Function(_$FinancialInsightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? severity = null,
    Object? title = null,
    Object? message = null,
    Object? createdDate = null,
    Object? isRead = null,
    Object? metadata = freezed,
  }) {
    return _then(_$FinancialInsightImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InsightType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as InsightSeverity,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdDate: null == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$FinancialInsightImpl implements _FinancialInsight {
  const _$FinancialInsightImpl(
      {required this.id,
      required this.type,
      required this.severity,
      required this.title,
      required this.message,
      required this.createdDate,
      required this.isRead,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  /// Unique identifier for the insight
  @override
  final String id;

  /// Type of insight for categorization
  @override
  final InsightType type;

  /// Severity level indicating importance
  @override
  final InsightSeverity severity;

  /// Short descriptive title
  @override
  final String title;

  /// Detailed explanation message
  @override
  final String message;

  /// When the insight was created
  @override
  final DateTime createdDate;

  /// Whether the user has acknowledged/read this insight
  @override
  final bool isRead;

  /// Optional metadata for additional context
  final Map<String, dynamic>? _metadata;

  /// Optional metadata for additional context
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'FinancialInsight(id: $id, type: $type, severity: $severity, title: $title, message: $message, createdDate: $createdDate, isRead: $isRead, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialInsightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      severity,
      title,
      message,
      createdDate,
      isRead,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialInsightImplCopyWith<_$FinancialInsightImpl> get copyWith =>
      __$$FinancialInsightImplCopyWithImpl<_$FinancialInsightImpl>(
          this, _$identity);
}

abstract class _FinancialInsight implements FinancialInsight {
  const factory _FinancialInsight(
      {required final String id,
      required final InsightType type,
      required final InsightSeverity severity,
      required final String title,
      required final String message,
      required final DateTime createdDate,
      required final bool isRead,
      final Map<String, dynamic>? metadata}) = _$FinancialInsightImpl;

  @override

  /// Unique identifier for the insight
  String get id;
  @override

  /// Type of insight for categorization
  InsightType get type;
  @override

  /// Severity level indicating importance
  InsightSeverity get severity;
  @override

  /// Short descriptive title
  String get title;
  @override

  /// Detailed explanation message
  String get message;
  @override

  /// When the insight was created
  DateTime get createdDate;
  @override

  /// Whether the user has acknowledged/read this insight
  bool get isRead;
  @override

  /// Optional metadata for additional context
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$FinancialInsightImplCopyWith<_$FinancialInsightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
