import 'package:hive/hive.dart';
import '../../domain/entities/insight.dart';

part 'insight_model.g.dart';

@HiveType(typeId: 2)
class InsightModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String severity;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final String message;

  @HiveField(5)
  final DateTime createdDate;

  @HiveField(6)
  final bool isRead;

  @HiveField(7)
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
