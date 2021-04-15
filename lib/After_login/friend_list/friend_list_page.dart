import 'package:firebase_todo_app/After_login/add_friend/add_friend_page.dart';
import 'package:firebase_todo_app/After_login/add_friend/drawer_page.dart';
import 'package:firebase_todo_app/domain/friend_domain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'friend_list_model.dart';

class FriendListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FriendListModel>(
        create: (_) => FriendListModel()
          ..fetchFriends()
          ..createFriendPaymentMap(),
        child: Stack(
          children: [
            Scaffold(
                drawer: DrawerPage(),
                appBar: AppBar(
                  title: Center(child: Text('友達一覧')),
                  actions: <Widget>[
                    Consumer<FriendListModel>(builder: (context, model, child) {
                      return IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () async {
                          await allDelete(model, context);
                          await model.fetchFriends();
                        },
                      );
                    })
                  ],
                ),
                body:
                    Consumer<FriendListModel>(builder: (context, model, child) {
                  final friends = model.friends;
                  final friendPaymentMap = model.friendPaymentMap;
                  final listTiles = friends
                      .map((friend) => ListTile(
                          leading: Container(
                              width: 150,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(friend.name,
                                    style: TextStyle(fontSize: 20.0)),
                              )),
                          title: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text('${friendPaymentMap[friend.name]}円',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ))),
                          onLongPress: () {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                        title: Center(
                                          child:
                                              Text('${friend.name}さん を削除しますか？'),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel')),
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                deleteFriend(
                                                    model, context, friend);
                                              },
                                              child: Text('OK')),
                                        ]));
                          }))
                      .toList();
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: listTiles,
                  );
                }),
                floatingActionButton:
                    Consumer<FriendListModel>(builder: (context, model, child) {
                  return FloatingActionButton(
                      child: Icon(Icons.person_add),
                      onPressed: () async {
                        await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                AddFriendDialog());
                        await model.fetchFriends();
                        await model.createFriendPaymentMap();
                      });
                })),
            Consumer<FriendListModel>(
              builder: (context, model, child) {
                return model.isLoading
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SizedBox();
              },
            )
          ],
        ));
  }

  Future deleteFriend(
      FriendListModel model, BuildContext context, FriendDomain friend) async {
    try {
      await model.deleteFriend(friend);
      await model.fetchFriends();
      await _showDialog(context, '削除しました');
    } catch (e) {
      _showDialog(context, e.toString());
    }
  }

  Future allDelete(FriendListModel model, BuildContext context) async {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: Center(
                  child: Text('全て削除してよろしいですか？'),
                ),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                      child: Text('Cancel')),
                  FlatButton(
                      onPressed: () {
                        model.allDelete();
                        Navigator.pop(context, 'OK');
                      },
                      child: Text('OK')),
                ]));
  }

  _showDialog(BuildContext context, String title) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: Center(
                  child: Text(title),
                ),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: Text('OK')),
                ]));
  }
}
