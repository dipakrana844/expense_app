import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/domain/entities/daily_spend_state_entity.dart';

part 'daily_spend_state.freezed.dart';

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
abstract class DailySpendState with _$DailySpendState {
  const DailySpendState._();

  const factory DailySpendState({
    required double todaySpent,
    required double dailyLimit,
    required double remaining,
    required SpendStatus status,
    required DateTime lastUpdated,
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
enum SpendStatus { safe, caution, exceeded }

extension DailySpendStateMapper on DailySpendState {
  DailySpendStateEntity toEntity() {
    return DailySpendStateEntity(
      todaySpent: todaySpent,
      dailyLimit: dailyLimit,
      remaining: remaining,
      status: status.toEntity(),
      lastUpdated: lastUpdated,
    );
  }
}

extension DailySpendStateEntityMapper on DailySpendStateEntity {
  DailySpendState toModel() {
    return DailySpendState(
      todaySpent: todaySpent,
      dailyLimit: dailyLimit,
      remaining: remaining,
      status: status.toModel(),
      lastUpdated: lastUpdated,
    );
  }
}

extension SpendStatusMapper on SpendStatus {
  SpendStatusEntity toEntity() {
    switch (this) {
      case SpendStatus.safe:
        return SpendStatusEntity.safe;
      case SpendStatus.caution:
        return SpendStatusEntity.caution;
      case SpendStatus.exceeded:
        return SpendStatusEntity.exceeded;
    }
  }
}

extension SpendStatusEntityMapper on SpendStatusEntity {
  SpendStatus toModel() {
    switch (this) {
      case SpendStatusEntity.safe:
        return SpendStatus.safe;
      case SpendStatusEntity.caution:
        return SpendStatus.caution;
      case SpendStatusEntity.exceeded:
        return SpendStatus.exceeded;
    }
  }
}
