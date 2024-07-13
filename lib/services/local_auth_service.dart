import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

typedef AuthResponse = bool;

class LocalAuthService {
  LocalAuthService();

  final LocalAuthentication _auth = LocalAuthentication();

  Future<AuthResponse> authenticate({
    String reason = 'Authentication Required',
  }) async {
    try {
      bool authenticated = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(),
      );

      return authenticated;
    } on PlatformException catch (e) {
      String errorMessage = switch (e.code) {
        auth_error.biometricOnlyNotSupported =>
          "'Biometric Only' not supported",
        auth_error.lockedOut => "Too many attempts",
        auth_error.notAvailable => "No hardware support",
        auth_error.notEnrolled => "Biometrics not setup",
        auth_error.otherOperatingSystem => "OS not supported",
        auth_error.passcodeNotSet => "Passcode not set",
        auth_error.permanentlyLockedOut => "Permanently locked out",
        String() => "An unexpected error occurred"
      };

      if (kDebugMode) {
        print(errorMessage);
      }

      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> isBiometricAvailable() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
