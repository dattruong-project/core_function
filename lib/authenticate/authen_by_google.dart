import 'package:google_sign_in/google_sign_in.dart';

import '_mixin.dart';

class AuthenticateByGoogle with AuthMixin {
  AuthenticateByGoogle._();

  static final AuthenticateByGoogle _instance = AuthenticateByGoogle._();

  static AuthenticateByGoogle get instance => _instance;

  final GoogleSignIn _googleAuth = GoogleSignIn();

  @override
  Future<void> logOut() => _googleAuth.signOut();

  @override
  Future<GoogleSignInAccount?> authenticate() {
    return _googleAuth.signIn();
  }
}

