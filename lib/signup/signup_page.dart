import 'package:firebase_todo_app/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signup_model.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return ChangeNotifierProvider<SignUpModel>(
        create: (_) => SignUpModel(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text('新規登録'),
          ),
          body: Consumer<SignUpModel>(builder: (context, model, child) {
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
                      '登録する',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      try {
                        await model.signUp();
                        await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Center(
                              child: Text('登録完了しました！'),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
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
