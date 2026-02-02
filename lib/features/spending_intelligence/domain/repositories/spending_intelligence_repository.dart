import '../entities/insight.dart';

abstract class SpendingIntelligenceRepository {
  /// Generates insights based on current data and saves them locally
  Future<void> generateDailyInsights();

  /// Retrieves stored insights
  Future<List<Insight>> getInsights();

  /// Marks an insight as read
  Future<void> markAsRead(String id);

  /// Clears all insights (debug/reset)
  Future<void> clearAllInsights();
}
