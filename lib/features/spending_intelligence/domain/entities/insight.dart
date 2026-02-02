import 'package:freezed_annotation/freezed_annotation.dart';

part 'insight.freezed.dart';

enum InsightType { anomaly, dailyInsight, budgetPrediction, categoryDominance }

enum InsightSeverity {
  info, // Green/Blue - Good news or neutral
  warning, // Orange - Caution
  critical, // Red - Alert
}

@freezed
class Insight with _$Insight {
  const factory Insight({
    required String id,
    required InsightType type,
    required InsightSeverity severity,
    required String title,
    required String message,
    required DateTime createdDate,
    @Default(false) bool isRead,
    Map<String, dynamic>? metadata,
  }) = _Insight;
}
