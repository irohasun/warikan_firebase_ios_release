import 'package:firebase_todo_app/After_login/add_payment/add_payment_dialog.dart';
import 'package:firebase_todo_app/Home.dart';
import 'package:firebase_todo_app/domain/payment_domain.dart';
import 'package:firebase_todo_app/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('支払い一覧')),
        automaticallyImplyLeading: false,
      ),
      body: null,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          width: 270,
          height: 35,
          child: Text(
            '合計金額:0円',
            style: TextStyle(
              fontSize: 23.0,
              fontFamily: '',
              color: Colors.white,
            ),
          ),
          color: Colors.orange,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Center(
                  child: Text('新規登録 または ログイン     してください！'),
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
          }),
    );
  }
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
