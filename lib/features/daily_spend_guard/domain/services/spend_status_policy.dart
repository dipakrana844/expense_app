import 'package:smart_expense_tracker/features/daily_spend_guard/domain/entities/daily_spend_state_entity.dart';

class SpendStatusPolicy {
  const SpendStatusPolicy();

  SpendStatusEntity determineStatus({
    required double spent,
    required double limit,
  }) {
    if (limit <= 0) {
      return SpendStatusEntity.safe;
    }

    final percentage = spent / limit;
    if (percentage >= 1.0) {
      return SpendStatusEntity.exceeded;
    }
    if (percentage >= 0.8) {
      return SpendStatusEntity.caution;
    }
    return SpendStatusEntity.safe;
  }
}

