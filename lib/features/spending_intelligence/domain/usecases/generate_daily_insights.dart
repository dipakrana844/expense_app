import '../repositories/spending_intelligence_repository.dart';

class GenerateDailyInsights {
  final SpendingIntelligenceRepository repository;

  GenerateDailyInsights(this.repository);

  Future<void> call() async {
    return repository.generateDailyInsights();
  }
}
