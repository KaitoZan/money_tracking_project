// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, unused_import, must_be_immutable
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracking_project/models/money.dart';
import 'package:money_tracking_project/models/user.dart';
import 'package:money_tracking_project/services/call_api.dart';
import 'package:money_tracking_project/utils/env.dart';

class MainView extends StatefulWidget {
  User? user;
  Money? money;
  MainView({super.key, required this.user});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Money>? moneyData;
  double totalBalance = 0.0;

  Future<void> callGetAllStatementByUserId(Money money) async {
    final data = await CallAPI.callgetAllMoneyByuserId(money);
    setState(() {
      moneyData = data;
      final totalIncome = data.where((item) => item.moneyType == '1').fold(
          0.0, (sum, item) => sum + (double.tryParse(item.moneyInOut!) ?? 0.0));
      final totalExpense = data.where((item) => item.moneyType == '2').fold(
          0.0, (sum, item) => sum + (double.tryParse(item.moneyInOut!) ?? 0.0));
      totalBalance = totalIncome - totalExpense;
    });
  }

  @override
  void initState() {
    super.initState();
    Money money = Money(userId: widget.user!.userId);
    callGetAllStatementByUserId(money);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 74, 179, 172),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 100.0),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 55, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 100,
                  ),
                  child: Text(
                    '${widget.user!.userFullName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '${Env.hostName}/moneytrackingAPI/picupload/user/${widget.user!.userImage}',
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 150,
              left: 25,
              right: 25,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  color: Color(0xFF107C78),
                  borderRadius: BorderRadius.circular(
                    27,
                  )),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 165,
                ),
                child: Text(
                  'ยอดเงินคงเหลือ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: moneyData == null || totalBalance == 0
                    ? Text(
                        '0.00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      )
                    : Text(
                        NumberFormat('#,###.00').format(totalBalance),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 6,
                  right: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        left: 50,
                      ),
                      child: ImageIcon(
                          AssetImage(
                            'assets/icons/income.png',
                          ),
                          color: Colors.white,
                          size: MediaQuery.of(context).size.height * 0.029),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        left: 10,
                      ),
                      child: Text(
                        'ยอดเงินเข้ารวม',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        left: 65,
                      ),
                      child: Text(
                        'ยอดเงินออกรวม',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        left: 10,
                      ),
                      child: ImageIcon(
                          AssetImage(
                            'assets/icons/outcome.png',
                          ),
                          color: Colors.white,
                          size: MediaQuery.of(context).size.height * 0.029),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    moneyData == null
                        ? CircularProgressIndicator()
                        : moneyData == null ||
                                moneyData!
                                        .where((item) => item.moneyType == '1')
                                        .fold(
                                            0.0,
                                            (sum, item) =>
                                                sum +
                                                double.parse(
                                                    item.moneyInOut!)) ==
                                    0
                            ? Text(
                                '0.00',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              )
                            : Text(
                                NumberFormat('#,###.00').format(
                                  moneyData!
                                      .where((item) => item.moneyType == '1')
                                      .fold(
                                          0.0,
                                          (sum, item) =>
                                              sum +
                                              double.parse(item.moneyInOut!)),
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 120,
                      ),
                    ),
                    moneyData == null ||
                            moneyData!
                                    .where((item) => item.moneyType == '2')
                                    .fold(
                                        0.0,
                                        (sum, item) =>
                                            sum +
                                            double.parse(item.moneyInOut!)) ==
                                0
                        ? Text(
                            '0.00',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )
                        : Text(
                            NumberFormat('#,###.00').format(
                              moneyData!
                                  .where((item) => item.moneyType == '2')
                                  .fold(
                                      0.0,
                                      (sum, item) =>
                                          sum + double.parse(item.moneyInOut!)),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 395, bottom: 50),
                child: Text(
                  'เงินเข้า/เงินออก',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                  child: moneyData == null || moneyData!.isEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              'ไม่มีรายการเงินเข้า/เงินออก',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            Positioned.fill(
                              child: ListView.builder(
                                itemCount: moneyData!.length,
                                itemBuilder: (context, index) {
                                  final transaction = moneyData![index];
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: ListTile(
                                      tileColor: transaction.moneyType == '1'
                                          ? Colors.green[50]
                                          : Colors.red[50],
                                      leading: Icon(
                                        transaction.moneyType == '1'
                                            ? Icons.arrow_downward
                                            : Icons.arrow_upward,
                                        color: transaction.moneyType == '1'
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      title: Text(transaction.moneyDetail ??
                                          'No Detail'),
                                      subtitle: Text(transaction.moneyDate ??
                                          'Unknown Date'),
                                      trailing: Text(
                                        transaction.moneyInOut == null ||
                                                double.parse(transaction
                                                        .moneyInOut!) ==
                                                    0
                                            ? '0.00'
                                            : NumberFormat('#,###.00').format(
                                                double.parse(
                                                    transaction.moneyInOut!)),
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: transaction.moneyType == '1'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ))
            ],
          ),
        ],
      ),
    );
  }
}
