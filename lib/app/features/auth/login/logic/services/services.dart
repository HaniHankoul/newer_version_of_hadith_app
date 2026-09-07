import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginService {
  GoogleLoginService._();

  static final GoogleLoginService instance = GoogleLoginService._();

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _initialized = false;

  Future<void> _initialize() async {
    if (_initialized) return;

    await _googleSignIn.initialize(
      serverClientId:
          '714947697386-tbms98u50vck25r417o1dvgvttno29jt.apps.googleusercontent.com',
    );

    _initialized = true;
  }

  Future<String> signIn() async {
    await _initialize();

    final account = await _googleSignIn.authenticate();

    final idToken = account.authentication.idToken;

    if (idToken == null || idToken.isEmpty) {
      throw Exception('Google ID token was not returned');
    }

    return idToken;
  }

  Future<void> signOut() async {
    await _initialize();
    await _googleSignIn.signOut();
  }
}
