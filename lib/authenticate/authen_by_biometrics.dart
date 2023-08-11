import 'package:core_function/authenticate/_mixin.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticateByBiometrics with AuthMixin{
  AuthenticateByBiometrics._();

  static final AuthenticateByBiometrics _instance = AuthenticateByBiometrics
      ._();

  static AuthenticateByBiometrics get instance => _instance;

  final LocalAuthentication _biometricsAuth = LocalAuthentication();

  Future<List<BiometricType>> getAvailableBiometrics() =>
      _biometricsAuth.getAvailableBiometrics();

  Future<bool> get canCheckBiometric => _biometricsAuth.canCheckBiometrics;

  @override
  Future<bool> logOut() => _biometricsAuth.stopAuthentication();

  @override
  Future<bool> authenticateWithParams(dynamic params,{
    AuthenticationOptions options = const AuthenticationOptions()}) async {
    return _biometricsAuth.authenticate(
        localizedReason: params as String, options: options);
  }

  Future<bool> isDeviceSupported() => _biometricsAuth.isDeviceSupported();

}