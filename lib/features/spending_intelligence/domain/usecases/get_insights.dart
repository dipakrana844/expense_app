import '../entities/insight.dart';
import '../repositories/spending_intelligence_repository.dart';

class GetInsights {
  final SpendingIntelligenceRepository repository;

  GetInsights(this.repository);

  Future<List<Insight>> call() {
    return repository.getInsights();
  }
}
