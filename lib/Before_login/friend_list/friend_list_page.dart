import 'package:firebase_todo_app/Home.dart';
import 'package:firebase_todo_app/login/login_page.dart';
import 'package:flutter/material.dart';

class FriendListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('友達一覧')),
          automaticallyImplyLeading: false,
        ),
        body: null,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.person_add),
            onPressed: () async {
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Center(
                    child: Text('ログインしてください！'),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: Text('OK')),
                  ],
                ),
              );
            }));
  }
}
