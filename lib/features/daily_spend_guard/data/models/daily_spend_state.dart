import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'daily_spend_state.freezed.dart';
part 'daily_spend_state.g.dart';

/// Data Model: DailySpendState
///
/// Purpose: Represents the current daily spending state for real-time tracking
/// - Stores today's spending, daily limit, and remaining amount
/// - Maintains spend status (Safe/Caution/Exceeded)
/// - Tracks last update timestamp for freshness
///
/// Design Decision: Separate from domain entities to:
/// 1. Handle Hive persistence concerns
/// 2. Enable efficient local storage
/// 3. Support background processing requirements

@freezed
@HiveType(typeId: 5)
class DailySpendState with _$DailySpendState {
  const DailySpendState._();

  const factory DailySpendState({
    @HiveField(0) required double todaySpent,
    @HiveField(1) required double dailyLimit,
    @HiveField(2) required double remaining,
    @HiveField(3) required SpendStatus status,
    @HiveField(4) required DateTime lastUpdated,
  }) = _DailySpendState;

  /// Factory constructor for initial state
  factory DailySpendState.initial() {
    return DailySpendState(
      todaySpent: 0.0,
      dailyLimit: 0.0,
      remaining: 0.0,
      status: SpendStatus.safe,
      lastUpdated: DateTime.now(),
    );
  }

  /// Check if this state is for today
  bool get isForToday {
    final now = DateTime.now();
    return lastUpdated.year == now.year &&
        lastUpdated.month == now.month &&
        lastUpdated.day == now.day;
  }
}

/// Enum representing spending status states
@HiveType(typeId: 6)
enum SpendStatus {
  @HiveField(0)
  safe,

  @HiveField(1)
  caution,

  @HiveField(2)
  exceeded,
}