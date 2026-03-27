import '../repository/repository.dart';
import 'package:smart_expense_tracker/core/domain/usecases/base_usecase.dart';

class ResetSettingsUseCase extends BaseUseCase<void, NoParams> {
  final SettingsRepository repository;

  ResetSettingsUseCase(this.repository);

  @override
  UseCaseResult<void> call(NoParams params) async {
    final failure = await repository.resetToDefaults();
    return (null, failure);
  }
}
