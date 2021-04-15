import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../After_login/root_after_login.dart';
import 'login_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return ChangeNotifierProvider<LoginModel>(
        create: (_) => LoginModel(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueAccent,
            title: Text('ログイン'),
          ),
          body: Consumer<LoginModel>(builder: (context, model, child) {
            return Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'example@gmail.com'),
                  controller: emailController,
                  onChanged: (text) {
                    model.mail = text;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'password'),
                  obscureText: true,
                  controller: passwordController,
                  onChanged: (text) {
                    model.password = text;
                  },
                ),
                RaisedButton(
                    color: Colors.blueAccent,
                    child: Text(
                      'ログイン',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      try {
                        await model.login();
                        await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Center(
                              child: Text('ログイン完了しました！'),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () async {
                                    await Future.delayed(Duration(seconds: 1));
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Root_After_Login(),
                                      ),
                                    );
                                  },
                                  child: Text('OK')),
                            ],
                          ),
                        );
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
              ],
            );
          }),
        ));
  }
}
