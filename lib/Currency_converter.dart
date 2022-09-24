import 'package:budget_app/Database/Database.dart';
import 'package:flutter/material.dart';
import 'package:money_converter/Currency.dart';
import 'package:money_converter/money_converter.dart';

class MyApp extends StatefulWidget {
  late String currency;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //def varebile

  String? usdToEgp;
  var current_currency;
  final DataBase _db = DataBase();

  @override
  void initState() {
    super.initState();
// add in initState
    getAmounts();
  }

// call function to convert
  void getAmounts() async {
    current_currency = widget.currency;
    var usdConvert = await MoneyConverter.convert(
        Currency(Currency.USD, amount: 1), Currency(current_currency));
    setState(() {
      current_currency = widget.currency;
      usdToEgp = usdConvert.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Money Convertor Example'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "1 USD = ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      "$usdToEgp $current_currency",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
