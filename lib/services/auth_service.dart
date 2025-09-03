import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> login(String email, String password) async{
    try{
      if(password.isNotEmpty && email.isNotEmpty){
        return await _auth.signInWithEmailAndPassword(email: email, password: password);
      }
    } catch (e){
      throw FirebaseAuthException(code: "Invalid Credentials");
    }
    return null;
  }

  Future<UserCredential?> register(String email, String password) async{
    try{
      if(password.isNotEmpty && email.isNotEmpty){
        return await _auth.createUserWithEmailAndPassword(email: email, password: password);
      }
    }catch (e){
      throw FirebaseAuthException(code: "There is an error on register");
    }
    return null;
  }

  Future<void> logout() async {
    try{
      await _auth.signOut();
    }catch(e){
      throw FirebaseAuthException(code: "error on logout");
    }
  }
}