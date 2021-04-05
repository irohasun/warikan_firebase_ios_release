import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo_app/domain/friend_domain.dart';
import 'package:firebase_todo_app/domain/payment_domain.dart';
import 'package:firebase_todo_app/login/login_model.dart';
import 'package:flutter/cupertino.dart';

class AddPaymentModel extends ChangeNotifier {
  String paymentEvent = '';
  String paymentName = '';
  String paymentMoney = '';
  bool isLoading = false;
  List<String> paymentNames = [];
  String currentUserId = LoginModel().getCurrentUserId();

  startLoading() {
    isLoading = true;
  }

  endLoading() {
    isLoading = false;
  }

  Future fetchPaymentNames() async {
    final documents = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('friends')
        .get();
    final friends1 = documents.docs.map((doc) => FriendDomain(doc)).toList();
    final friends2 = friends1.map((doc) => doc.name).toList();
    this.paymentNames = friends2;
    notifyListeners();
  }

  Future addPaymentToFirebase() async {
    if (paymentName.isEmpty) {
      throw ('名前を入力してください!');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('payments')
        .add(
      {
        'createdAt': Timestamp.now(),
        'name': paymentName,
        'money': paymentMoney,
        'event': paymentEvent,
      },
    );
  }

  Future updatepayment(PaymentDomain payment) async {
    final document = FirebaseFirestore.instance
        .collection('payments')
        .doc(payment.documentID);
    await document.update(
      {
        'updateAt': Timestamp.now(),
        'name': paymentName,
        'money': paymentMoney,
        'event': paymentEvent,
      },
    );
  }

  Future updateFriendPayment(FriendDomain friend) async {
    final document =
        FirebaseFirestore.instance.collection('friends').doc(friend.documentID);
    await document.update(
      {'updateAt': Timestamp.now(), 'payment': paymentMoney},
    );
  }
}
