import 'package:firebase_todo_app/login/login_model.dart';
import 'package:firebase_todo_app/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
        create: (_) => LoginModel(),
        builder: (context, snapshot) {
          return Consumer<LoginModel>(builder: (context, model, child) {
            return Drawer(
              child: ListView(children: [
                UserAccountsDrawerHeader(
                  // accountName: Text("User Name"),
                  // accountEmail: Text("User Email"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://pbs.twimg.com/profile_images/885510796691689473/rR9aWvBQ_400x400.jpg"),
                  ),
                ),
                ListTile(
                    title: Text("ログアウト"),
                    onTap: () async {
                      try {
                        await model.logout();
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      } catch (e) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Center(
                              child: Text(e.toString()),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: Text('OK')),
                            ],
                          ),
                        );
                      }
                    })
              ]),
            );
          });
        });
  }
}
