import 'package:firebase_todo_app/friend_list/friend_list_model.dart';
import 'package:flutter/material.dart';

class CheckListModel extends FriendListModel {
  List<MapEntry<String, String>> friendPaymentList = [];
  List<MapEntry<Text, Text>> checkList = [];
  int averagePayment = 0;
  int friendsNumber = 0;
  bool isLoading = false;

  startLoading() {
    isLoading = true;
  }

  endLoading() {
    isLoading = false;
  }

  //支払平均を算出する関数
  Future getAveragePayment() async {
    await super.sumAllPayments();
    final allPayment = int.parse(sumAllPayment);
    await getFriendNumber();
    final averagePayment = allPayment ~/ friendsNumber; //結果をintで返す
    this.averagePayment = averagePayment;
    notifyListeners();
  }

  Future getFriendNumber() async {
    await super.fetchFriends();
    this.friendsNumber = friends.length;
  }

  Future createFriendPaymentList() async {
    List<MapEntry<String, String>> friendPaymentList = [];
    await fetchFriends();
    await Future.forEach(friends, (friend) async {
      final value = await super.getFriendPayment(friend);
      friendPaymentList.add(MapEntry(friend.name, value.toString()));
    });
    this.friendPaymentList = friendPaymentList;
    notifyListeners();
  }

  //誰が誰にいくら支払うかのListを作成する関数
  Future createCheckList() async {
    startLoading();
    //一番多く払った人とその金額を変数に入れて保持する
    int maxPay = 0;
    String maxFriend = '';
    await createFriendPaymentList();
    print(friendPaymentList);
    Future.forEach(friendPaymentList, (mapEntry) {
      if (maxPay < int.parse(mapEntry.value)) {
        maxPay = int.parse(mapEntry.value);
        maxFriend = mapEntry.key;
      }
    });
    Future.forEach(this.friendPaymentList, (mapEntry) {
      if (int.parse(mapEntry.value) < averagePayment) {
        this.checkList.add(MapEntry(
            Text(
              maxFriend + '　👈　' + mapEntry.key,
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
                (this.averagePayment - int.parse(mapEntry.value)).toString() +
                    '円渡す',
                style: TextStyle(fontSize: 18.0))));
      } else if (int.parse(mapEntry.value) == maxPay) {
        this.checkList.add(MapEntry(Text(' '), Text(' ')));
      } else {
        this.checkList.add(MapEntry(
            Text(
              maxFriend + '　👉　' + mapEntry.key,
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
                (int.parse(mapEntry.value) - this.averagePayment).toString() +
                    '円渡す',
                style: TextStyle(fontSize: 18.0))));
      }
    });
    endLoading();
  }
}
