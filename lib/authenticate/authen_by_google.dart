import 'package:google_sign_in/google_sign_in.dart';

class AuthenticateByGoogle {
  AuthenticateByGoogle._();

  static final AuthenticateByGoogle _instance = AuthenticateByGoogle._();

  static AuthenticateByGoogle get instance => _instance;

  final GoogleSignIn _googleAuth = GoogleSignIn();

  Future<void> logOut() => _googleAuth.signOut();

  Future<GoogleSignInAccount?> authenticate() {
    return _googleAuth.signIn();
  }
}
