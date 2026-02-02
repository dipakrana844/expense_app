import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/insight_model.dart';

class SpendingIntelligenceLocalDataSource {
  late Box<InsightModel> _insightsBox;
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      // Ensure Hive is initialized (safe to call multiple times if handled right,
      // but usually done in main/background service)

      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(InsightModelAdapter());
      }

      _insightsBox = await Hive.openBox<InsightModel>(
        AppConstants.insightsBoxName,
      );

      _isInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize Insights Hive box: $e');
      rethrow;
    }
  }

  Future<void> saveInsights(List<InsightModel> insights) async {
    _ensureInitialized();
    try {
      for (var insight in insights) {
        await _insightsBox.put(insight.id, insight);
      }
    } catch (e) {
      throw Exception('Failed to save insights: $e');
    }
  }

  Future<void> markAsRead(String id) async {
    _ensureInitialized();
    final insight = _insightsBox.get(id);
    if (insight != null) {
      final updated = InsightModel(
        id: insight.id,
        type: insight.type,
        severity: insight.severity,
        title: insight.title,
        message: insight.message,
        createdDate: insight.createdDate,
        isRead: true,
        metadata: insight.metadata,
      );
      await _insightsBox.put(id, updated);
    }
  }

  List<InsightModel> getInsights() {
    _ensureInitialized();
    final insights = _insightsBox.values.toList();
    // Sort by Date Descending (Newest first)
    insights.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    return insights;
  }

  /// Get unread insights count
  int getUnreadCount() {
    _ensureInitialized();
    return _insightsBox.values.where((e) => !e.isRead).length;
  }

  Future<void> clearAll() async {
    _ensureInitialized();
    await _insightsBox.clear();
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception(
        'SpendingIntelligenceLocalDataSource not initialized. Call init() first.',
      );
    }
  }
}
