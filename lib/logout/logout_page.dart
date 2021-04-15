import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: SamplePage(),
    ),
  );
}

class SamplePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Drawer'),
        ),
        drawer: Drawer(
          child: Column(children: [
            UserAccountsDrawerHeader(
              accountName: Text("User Name"),
              accountEmail: Text("User Email"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "https://pbs.twimg.com/profile_images/885510796691689473/rR9aWvBQ_400x400.jpg"),
              ),
            ),
            ListTile(
              title: Text("Lログアウト"),
            )
          ]),
        ));
  }
}
