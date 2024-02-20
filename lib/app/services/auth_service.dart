import 'package:bio/app/data/models/student_model.dart';
import 'package:bio/app/services/user_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<void> signUp(Student stdn, String email, String password) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set(stdn.toMap());
    await UserDataService.saveUserDataToLocal(stdn.toMap());
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot> getUserData(String userToken) async {
    try {
      return await FirebaseFirestore.instance.collection('users').doc(userToken).get();
    } catch (e) {
      rethrow;
    }
  }
}
