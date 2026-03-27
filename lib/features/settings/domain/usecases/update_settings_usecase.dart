import '../repository/repository.dart';
import '../entities/app_settings_entity.dart';
import 'package:smart_expense_tracker/core/domain/usecases/base_usecase.dart';

class UpdateSettingsUseCase extends BaseUseCase<void, AppSettingsEntity> {
  final SettingsRepository repository;

  UpdateSettingsUseCase(this.repository);

  @override
  UseCaseResult<void> call(AppSettingsEntity params) async {
    final failure = await repository.saveSettings(params);
    return (null, failure);
  }
}
