import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> exitDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.red,
        title: const Text(
          'Exit',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontFamily: 'ProximaNova',
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text(
                'Are you sure you want to exit?',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'ProximaNova',
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Yes',
              style: TextStyle(
                fontSize: 15.5,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontFamily: 'ProximaNova',
              ),
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          TextButton(
            child: const Text(
              'No',
              style: TextStyle(
                fontSize: 15.5,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontFamily: 'ProximaNova',
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
