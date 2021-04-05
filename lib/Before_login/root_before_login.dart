import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'check_money/check_list_page.dart';
import 'friend_list/friend_list_page.dart';
import 'payment_list/payment_list_page.dart';

class Root_Before_login extends StatefulWidget {
  Root_Before_login({Key key}) : super(key: key);

  @override
  _Root_Before_loginState createState() => _Root_Before_loginState();
}

class _Root_Before_loginState extends State<Root_Before_login> {
  int _selectedIndex = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

  //アイコン情報
  static const _footerIcons = [Icons.person, Icons.money, Icons.check];

  //アイコン情報
  static const _footerItemNames = ['友達一覧', '支払い一覧', '計算結果'];

  var _routes = [FriendListPage(), PaymentListPage(), CheckListPage()];

  @override
  void initState() {
    super.initState();
    _bottomNavigationBarItems.add(_UpdateActiveState(0));
    for (var i = 1; i < _footerItemNames.length; i++) {
      _bottomNavigationBarItems.add(_UpdateDeactiveState(i));
    }
  }

  //インデックスのアイテムをアクティベートする
  BottomNavigationBarItem _UpdateActiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.blue,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(color: Colors.blue),
        ));
  }

  /// インデックスのアイテムをディアクティベートする
  BottomNavigationBarItem _UpdateDeactiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black26,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black26,
          ),
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavigationBarItems[_selectedIndex] =
          _UpdateDeactiveState(_selectedIndex);
      _bottomNavigationBarItems[index] = _UpdateActiveState(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
