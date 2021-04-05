import 'package:flutter/material.dart';

class CheckListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('割り勘計算')),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    '合計金額：0円',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '合計人数：0人',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '一人当たり：0円',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
