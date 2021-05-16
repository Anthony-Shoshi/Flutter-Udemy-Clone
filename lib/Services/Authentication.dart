import 'package:UdemyClone/Services/PrefStorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final PrefStorage prefStorage = new PrefStorage();

  Future<String> googleSignIn() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final GoogleAuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(authCredential);
    final User user = userCredential.user;

    assert(user.displayName != null);
    assert(user.email != null);

    final User currentUser = _firebaseAuth.currentUser;
    assert(currentUser.uid == user.uid);

    prefStorage.storeUserInfo("name", user.displayName);
    prefStorage.storeUserInfo("email", user.email);

    return 'Error occured!';
  }

  User get user => _firebaseAuth.currentUser;

  Future<String> signOut() async {
    _googleSignIn.signOut();
    return "Error occured!";
  }
}
