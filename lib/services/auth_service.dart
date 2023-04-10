import 'package:chat_firebase/helpers/helper_function.dart';
import 'package:chat_firebase/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login
  Future loginUserWithEmailAndPassword(
      String email, 
      String password
  ) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
          email: email, 
          password: password
      )).user!;



      if(user!=null){
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //register
  Future registerUserWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
          email: email, 
          password: password
      )).user!;



      if(user!=null){
        //call our database service to update the user data
        await DatabaseService(user.uid).savingUserData(username, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //signout
  Future signout() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

  //rest pass
  Future restPass(String email) async{
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
    
  }

}
