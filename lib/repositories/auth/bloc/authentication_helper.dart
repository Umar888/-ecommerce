import 'package:ecommerce/repositories/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  Future<UserModel> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().catchError((onError){
        return UserModel(status: false, message: "Google login failed");
      });

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
      if(googleAuth != null ) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );


        if(credential != null){
          // Once signed in, return the UserCredential
          UserCredential userCredential =  await FirebaseAuth.instance.signInWithCredential(credential);

          if(user != null) {
            return UserModel(
                status: true,
                message: "Google login successful",
                name: userCredential.user!.displayName,
                email: userCredential.user!.email,
                uid: userCredential.user!.uid);
          }
          else{
            return UserModel(status: false, message: "Google login failed");
          }
        }
        else{
          return UserModel(status: false, message: "Google login failed");
        }
      }
      else{
        return UserModel(status: false, message: "Google login failed");
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return UserModel(status: false, message: "Google login failed");
    }
  }


  //SIGN UP METHOD
  Future<String> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "";
    } on FirebaseAuthException catch (e) {
      return e.message??"Registration failed";
    }
  }

  //SIGN IN METHOD
  Future<String> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "";
    } on FirebaseAuthException catch (e) {
      return e.message??"Login failed";
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}