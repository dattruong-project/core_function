import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthenticateByFacebook {
  AuthenticateByFacebook._();

  static final AuthenticateByFacebook _instance = AuthenticateByFacebook._();

  static AuthenticateByFacebook get instance => _instance;

  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  Future<void> logOut() => _facebookAuth.logOut();

  Future<void> webAndDesktopInitialize({
    required String appId,
    required bool cookie,
    required bool xfbml,
    required String version,
  }) {
    return _facebookAuth.webAndDesktopInitialize(
      appId: appId,
      cookie: cookie,
      xfbml: xfbml,
      version: version,
    );
  }

  Future<LoginResult> authenticate({
    List<String> permissions = const ['email', 'public_profile'],
    LoginBehavior loginBehavior = LoginBehavior.nativeWithFallback,
  }) async {
    return _facebookAuth.login(
        permissions: permissions, loginBehavior: loginBehavior);
  }
}
