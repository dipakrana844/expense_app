import '../repository/repository.dart';
import '../entities/app_settings_entity.dart';
import 'package:smart_expense_tracker/core/domain/usecases/base_usecase.dart';

class GetSettingsUseCase extends BaseUseCase<AppSettingsEntity, NoParams> {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  @override
  UseCaseResult<AppSettingsEntity> call(NoParams params) async {
    final (settings, failure) = await repository.getSettings();
    if (failure != null) {
      return (null, failure);
    }
    // settings may be null if no settings stored (should not happen because repository returns defaults)
    return (settings, null);
  }
}
