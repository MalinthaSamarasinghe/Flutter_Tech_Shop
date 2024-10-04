import 'package:flutter/material.dart';

class Alerts {
  static Alerts alert = Alerts();
  static Alerts getInstance() => alert;

  /// twoButton
  twoButtonAlert(BuildContext context, {required String title, required String msg, required String btnNoText, required String btnYesText, required Function functionNo, required Function functionYes}) {
    return showDialog(
      context: context,
      /// Disable dismiss on outside tap
      barrierDismissible: false,
      builder: (BuildContext context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                functionNo();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Text(btnNoText, style: const TextStyle(color: Colors.black)),
              ),
            ),
            TextButton(
              onPressed: () async {
                functionYes();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Text(btnYesText, style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
