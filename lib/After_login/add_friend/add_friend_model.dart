import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/domain/friend_domain.dart';
import 'package:firebase_todo_app/login/login_model.dart';
import 'package:flutter/cupertino.dart';

class AddFriendModel extends ChangeNotifier {
  String friendEvent = '';
  String friendName = '';
  bool isLoading = false;

  startLoading() {
    isLoading = true;
  }

  endLoading() {
    isLoading = false;
  }

  Future addFriendToFirebase() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final currentUserId = _auth.currentUser.uid;
    final userDocId = currentUserId;
    if (friendName.isEmpty) {
      throw ('名前を入力してください!');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userDocId)
        .collection('friends')
        .add(
      {
        'createdAt': Timestamp.now(),
        'name': friendName,
      },
    );
  }

  Future updateFriend(FriendDomain friend) async {
    final document =
        FirebaseFirestore.instance.collection('friends').doc(friend.documentID);
    await document.update(
      {
        'updateAt': Timestamp.now(),
        'name': friendName,
      },
    );
  }
}
