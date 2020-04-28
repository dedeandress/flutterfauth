import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    Fimber.d("sign in user: $user");
    return user;
  }

  Future<bool> isLogged() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    return user != null;
  }

  Future<void> signOut() async {
    return _googleSignIn.signOut();
  }

  Future<FirebaseUser> getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    return user;
  }
}
