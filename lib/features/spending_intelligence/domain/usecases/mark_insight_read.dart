import '../repositories/spending_intelligence_repository.dart';

class MarkInsightRead {
  final SpendingIntelligenceRepository repository;

  MarkInsightRead(this.repository);

  Future<void> call(String id) {
    return repository.markAsRead(id);
  }
}
