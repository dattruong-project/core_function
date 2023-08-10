import 'package:local_auth/local_auth.dart';

class AuthenticateByBiometrics {
  AuthenticateByBiometrics._();

  static final AuthenticateByBiometrics _instance = AuthenticateByBiometrics
      ._();

  static AuthenticateByBiometrics get instance => _instance;

  final LocalAuthentication _biometricsAuth = LocalAuthentication();

  Future<bool> logOut() => _biometricsAuth.stopAuthentication();

  Future<bool> isDeviceSupported() => _biometricsAuth.isDeviceSupported();

  Future<List<BiometricType>> getAvailableBiometrics() =>
      _biometricsAuth.getAvailableBiometrics();

  Future<bool> get canCheckBiometric => _biometricsAuth.canCheckBiometrics;

  Future<bool> authenticate({required String localizedReason,
    AuthenticationOptions options = const AuthenticationOptions()}) async {
    return _biometricsAuth.authenticate(
        localizedReason: localizedReason, options: options);
  }

}