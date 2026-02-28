enum SpendStatusEntity {
  safe,
  caution,
  exceeded,
}

class DailySpendStateEntity {
  final double todaySpent;
  final double dailyLimit;
  final double remaining;
  final SpendStatusEntity status;
  final DateTime lastUpdated;

  const DailySpendStateEntity({
    required this.todaySpent,
    required this.dailyLimit,
    required this.remaining,
    required this.status,
    required this.lastUpdated,
  });

  factory DailySpendStateEntity.initial() {
    return DailySpendStateEntity(
      todaySpent: 0.0,
      dailyLimit: 0.0,
      remaining: 0.0,
      status: SpendStatusEntity.safe,
      lastUpdated: DateTime.now(),
    );
  }

  bool get isForToday {
    final now = DateTime.now();
    return lastUpdated.year == now.year &&
        lastUpdated.month == now.month &&
        lastUpdated.day == now.day;
  }

  DailySpendStateEntity copyWith({
    double? todaySpent,
    double? dailyLimit,
    double? remaining,
    SpendStatusEntity? status,
    DateTime? lastUpdated,
  }) {
    return DailySpendStateEntity(
      todaySpent: todaySpent ?? this.todaySpent,
      dailyLimit: dailyLimit ?? this.dailyLimit,
      remaining: remaining ?? this.remaining,
      status: status ?? this.status,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

