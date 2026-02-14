import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class SecurityService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      return canAuthenticate;
    } catch (e) {
      return false;
    }
  }

  Future<bool> authenticate({String? localizedReason}) async {
    try {
      // Check if biometric authentication is available
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) {
        return false;
      }
      
      // In local_auth 3.0.0:
      // - AuthenticationOptions is removed.
      // - stickyAuth is replaced by persistAcrossBackgrounding.
      // - biometricOnly is a parameter of authenticate.
      return await _auth.authenticate(
        localizedReason: localizedReason ?? 'Please authenticate to access Smart Expense Tracker',
        persistAcrossBackgrounding: true,
        // options parameter is removed in 3.0.0 according to breaking changes
      );
    } on PlatformException catch (e) {
      // Log the specific error for debugging
      print('Authentication failed: ${e.message}');
      return false;
    } catch (e) {
      // Handle any other exceptions
      print('Unexpected authentication error: $e');
      return false;
    }
  }
}
