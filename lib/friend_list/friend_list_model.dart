import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo_app/domain/friend_domain.dart';
import 'package:firebase_todo_app/domain/payment_domain.dart';
import 'package:firebase_todo_app/login/login_model.dart';
import 'package:firebase_todo_app/payment_list/payment_list_model.dart';

class FriendListModel extends PaymentListModel {
  List<FriendDomain> friends = [];
  Map<String, String> friendPaymentMap = {};
  bool isLoading = false;
  String currentUserId = LoginModel().getCurrentUserId();

  startLoading() {
    isLoading = true;
  }

  endLoading() {
    isLoading = false;
  }

  //friendsの情報を取得
  Future fetchFriends() async {
    final documents = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('friends')
        .get();
    final friends = documents.docs.map((doc) => FriendDomain(doc)).toList();
    this.friends = friends;
    notifyListeners();
  }

  //friendとfriendに関連づいた支払いを削除
  Future deleteFriend(FriendDomain friend) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('friends')
        .doc(friend.documentID)
        .delete();
    await deleteFriendPayment(friend);
  }

  //friendの支払情報を削除
  Future deleteFriendPayment(FriendDomain friend) async {
    final payments1 = await fetchFriendPayment(friend);
    payments1.forEach((payment) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('payments')
          .doc(payment.documentID)
          .delete();
    });
  }

  Future allDelete() async {
    Future.forEach(friends, (friend) => deleteFriend(friend));
  }

  //friendの支払情報をリスト化
  Future<List<PaymentDomain>> fetchFriendPayment(FriendDomain friend) async {
    final documents = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('payments')
        .where('name', isEqualTo: friend.name)
        .get();
    final payments1 = documents.docs.map((doc) => PaymentDomain(doc)).toList();
    return payments1;
  }

  //友達一人当たりの支払金額を取得する
  Future<int> getFriendPayment(FriendDomain friend) async {
    int sumFriendPayment = 0;
    final payments1 = await fetchFriendPayment(friend);
    if (payments1.isEmpty) {
      sumFriendPayment = 0;
      return sumFriendPayment;
    } else {
      final payments2 = payments1.map((e) => (int.parse(e.money))).toList();
      final sumFriendPayment = payments2.reduce((a, b) => a + b);
      return sumFriendPayment;
    }
  }

  // {名前：支払合計額}のマップを作る
  Future createFriendPaymentMap() async {
    friendPaymentMap = {};
    startLoading();
    await fetchFriends();
    await Future.forEach(friends, (friend) async {
      final value = await getFriendPayment(friend);
      this.friendPaymentMap[friend.name] = value.toString();
    });
    this.friendPaymentMap = friendPaymentMap;
    notifyListeners();
    endLoading();
  }
}
