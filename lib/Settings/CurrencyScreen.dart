import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../Database/Database.dart';
import 'package:currency_picker/src/currency.dart';
import '../colours.dart';

class CurrencyScreen extends StatefulWidget {
  String id;
  String currency;
  CurrencyScreen({Key? key, required this.currency, required this.id}) : super(key: key);

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {

  final DataBase _db = DataBase();

  String localcurrency = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(color: Colors.white),),
        backgroundColor: primarycolor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Currency",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 14,),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(0,4),
                    blurRadius: 4,
                  )
                ],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  widget.currency,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Text(
              "Change Currency",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 14,),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(0,4),
                    blurRadius: 4,
                  )
                ],
                borderRadius: BorderRadius.circular(18),
              ),
              child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: Colors.red.withOpacity(0),
                    ),
                    onPressed: () {
                      showCurrencyPicker(
                        context: context,
                        showFlag: true,
                        showCurrencyName: true,
                        showCurrencyCode: true,
                        onSelect: (Currency currency) {
                          setState(()=> localcurrency = currency.code);
                          print('Select currency: ${currency.code}');
                        },
                      );
                    },
                    child: Text(
                      localcurrency == "" ? 'Select Currency' : localcurrency,
                      style: const TextStyle(color: Color.fromARGB(255, 80, 80, 80)),
                    ),
                  ),
            ),
            const SizedBox(height: 70,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primarycolor,),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),))
                    ),
                    onPressed: () async {
                      if (localcurrency != "") {
                        await _db.updateCurrency(widget.id, localcurrency);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Currency Updated Successfully')),
                        );
                      }
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.07,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          primarycolor,
                        ),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                // MaterialButton(
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard()));
                //   },
                //   height: MediaQuery.of(context).size.height * 0.07,
                //   minWidth: MediaQuery.of(context).size.width * 0.3,
                //
                //   color: primarycolor,
                //   splashColor: buttoncolor,
                //   child: Text("Cancel",
                //       style: TextStyle(
                //         fontSize: 18,
                //       )),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
