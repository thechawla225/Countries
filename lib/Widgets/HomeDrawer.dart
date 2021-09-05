import 'package:countries/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'ExitDialog.dart';

Widget homeDrawer(BuildContext context) {
  return Drawer(
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              child: Center(
                child: Text(
                  "Welcome !",
                  style: TextStyle(
                      fontFamily: 'ProximaNova',
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.red),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.house_rounded,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                        fontFamily: 'ProximaNova',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                return exitDialog(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Exit",
                    style: TextStyle(
                        fontFamily: 'ProximaNova',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.red),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
