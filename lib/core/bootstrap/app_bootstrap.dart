import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';
import '../enums/environment.dart';
import '../../main.dart';

Future<void> bootstrap(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.from(env);

  await setupDependencies(config);

  runApp(
    ProviderScope(
      child: MyApp(config: config),
    ),
  );
}

Future<void> setupDependencies(AppConfig config) async {
  // Initialize services that depend on config
  // Register dependencies in container
}