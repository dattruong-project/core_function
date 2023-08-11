import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:core_function/authenticate/_mixin.dart';
import 'package:core_function/utils/platform_details.dart';

class AuthenticateByAuth0 with AuthMixin {
  AuthenticateByAuth0._();

  static final AuthenticateByAuth0 _instance = AuthenticateByAuth0._();

  static AuthenticateByAuth0 get instance => _instance;

  factory AuthenticateByAuth0.init(
      {required String domain,
      required String clientId,
      LocalAuthentication? localAuthentication,
      CredentialsManager? credentialsManager}) {
    _instance.domain = domain;
    _instance.clientId = clientId;
    _instance.localAuthentication = localAuthentication;
    _instance.credentialsManager = credentialsManager;
    _instance.auth0Auth = PlatformDetails.instance.isMobile
        ? Auth0(_instance.domain, _instance.clientId)
        : Auth0Web(_instance.domain, _instance.clientId);
    return _instance;
  }

  late String domain;
  late String clientId;
  late LocalAuthentication? localAuthentication;
  late CredentialsManager? credentialsManager;
  late dynamic auth0Auth;

  @override
  Future<Credentials> authenticate(
      {final String? audience,
      final Set<String> scopes = const {
        'openid',
        'profile',
        'email',
        'offline_access'
      },
      final String? redirectUrl,
      final String? organizationId,
      final String? invitationUrl,
      final bool useEphemeralSession = false,
      final Map<String, String> parameters = const {},
      final IdTokenValidationConfig idTokenValidationConfig =
          const IdTokenValidationConfig(),
      final SafariViewController? safariViewController}) {
    return auth0Auth.webAuthentication().login(
        audience: audience,
        scopes: scopes,
        redirectUrl: redirectUrl,
        organizationId: organizationId,
        invitationUrl: invitationUrl,
        useEphemeralSession: useEphemeralSession,
        parameters: parameters,
        idTokenValidationConfig: idTokenValidationConfig,
        safariViewController: safariViewController);
  }

  @override
  Future<void> logOut({final String? returnTo}) {
    return auth0Auth.webAuthentication().logout(returnTo: returnTo);
  }
}
