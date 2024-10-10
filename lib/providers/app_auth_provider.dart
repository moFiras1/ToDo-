import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/database/model/user.dart';
import 'package:todo/database/model/user_dao.dart';

class AppAuthProvider extends ChangeNotifier {
  UserApp? databaseUser;
  User? firebaseAuthUser;

  Future<void> register(
      {required String email,
      required String password,
      required String fullName,
      required String userName}) async {
    var credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserApp user = UserApp(
      id: credential.user?.uid,
      fullName: fullName,
      userName: userName,
      email: email,
    );
    await UserDao.addUserToFirebase(user);
  }

  Future<void> login(String emailAddress, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);

    databaseUser = await UserDao.getUserFromFirebase(credential.user!.uid);
    firebaseAuthUser = credential.user;
  }

  void signOut() {
    databaseUser = null;
    FirebaseAuth.instance.signOut();
  }

  bool isLoggedInBefore() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> retriveUserFromFirebase() async {
    firebaseAuthUser = FirebaseAuth.instance.currentUser;
    databaseUser = await UserDao.getUserFromFirebase(firebaseAuthUser!.uid);
  }
}
