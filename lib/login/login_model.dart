import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  String currentUserId = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getCurrentUserId() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final currentUserId = _auth.currentUser.uid;
    return currentUserId;
  }

  Future login() async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
      this.currentUserId = _auth.currentUser.uid;
    } catch (e) {
      if (mail.isEmpty) {
        print('メールアドレスを入力してください');
        throw ('メールアドレスを入力してください');
      }
      if (password.isEmpty) {
        print('パスワードを入力してください');
        throw ('パスワードを入力してください');
      }
      if (e.code == 'user-not-found') {
        print("ユーザーが見つかりません");
        throw ("ユーザーが見つかりません");
      } else if (e.code == 'wrong-password') {
        print("パスワードが間違っています");
        throw ('パスワードが間違っています');
      }
    }
  }

  Future logout() async {
    await _auth.signOut();
  }
}
