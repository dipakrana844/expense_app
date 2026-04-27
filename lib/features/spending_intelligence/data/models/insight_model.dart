import '../../domain/entities/insight.dart';

class InsightModel {
  final String id;

  final String type;

  final String severity;

  final String title;

  final String message;

  final DateTime createdDate;

  final bool isRead;

  final Map<String, dynamic>? metadata;

  InsightModel({
    required this.id,
    required this.type,
    required this.severity,
    required this.title,
    required this.message,
    required this.createdDate,
    required this.isRead,
    this.metadata,
  });

  factory InsightModel.fromEntity(Insight insight) {
    return InsightModel(
      id: insight.id,
      type: insight.type.name,
      severity: insight.severity.name,
      title: insight.title,
      message: insight.message,
      createdDate: insight.createdDate,
      isRead: insight.isRead,
      metadata: insight.metadata,
    );
  }

  Insight toEntity() {
    return Insight(
      id: id,
      type: InsightType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => InsightType.dailyInsight,
      ),
      severity: InsightSeverity.values.firstWhere(
        (e) => e.name == severity,
        orElse: () => InsightSeverity.info,
      ),
      title: title,
      message: message,
      createdDate: createdDate,
      isRead: isRead,
      metadata: metadata,
    );
  }
}
