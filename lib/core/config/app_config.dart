import '../enums/environment.dart';

class AppConfig {
  final String baseUrl;
  final String appName;
  final bool enableLogging;
  final Duration apiTimeout;
  final String flavorName;
  final bool isDebugBannerEnabled;

  const AppConfig({
    required this.baseUrl,
    required this.appName,
    required this.enableLogging,
    required this.apiTimeout,
    required this.flavorName,
    required this.isDebugBannerEnabled,
  });

  factory AppConfig.from(Environment env) {
    switch (env) {
      case Environment.dev:
        return AppConfig(
          baseUrl: 'https://api-dev.example.com',
          appName: 'Smart Expense Tracker Dev',
          enableLogging: true,
          apiTimeout: const Duration(seconds: 30),
          flavorName: 'dev',
          isDebugBannerEnabled: true,
        );
      case Environment.staging:
        return AppConfig(
          baseUrl: 'https://api-staging.example.com',
          appName: 'Smart Expense Tracker Staging',
          enableLogging: true,
          apiTimeout: const Duration(seconds: 20),
          flavorName: 'staging',
          isDebugBannerEnabled: true,
        );
      case Environment.prod:
        return AppConfig(
          baseUrl: 'https://api.example.com',
          appName: 'Smart Expense Tracker',
          enableLogging: false,
          apiTimeout: const Duration(seconds: 15),
          flavorName: 'prod',
          isDebugBannerEnabled: false,
        );
    }
  }
}