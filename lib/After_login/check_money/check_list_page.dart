import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'check_list_model.dart';

class CheckListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckListModel>(
      create: (_) => CheckListModel()
        ..sumAllPayments()
        ..getAveragePayment()
        ..createFriendPaymentList()
        ..createCheckList(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Center(child: Text('割り勘計算')),
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Consumer<CheckListModel>(builder: (context, model, child) {
                final allPayment = model.sumAllPayment;
                final friendsNumber = model.friendsNumber;
                final averagePayment = model.averagePayment;
                final listTiles = model.checkList
                    .map((check) => ListTile(
                          leading: Container(
                              width: 300,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: check.key)),
                          trailing: check.value,
                        ))
                    .toList();
                return Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            '合計金額：${allPayment}円',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '合計人数：${friendsNumber}人',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '一人当たり：${averagePayment}円',
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
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: listTiles,
                    ),
                  ],
                );
              }),
            ),
          ),
          Consumer<CheckListModel>(builder: (context, model, child) {
            return model.isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox();
          })
        ],
      ),
    );
  }
}
