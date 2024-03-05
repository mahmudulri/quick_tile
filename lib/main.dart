import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_tile/homepage.dart';
import 'package:quick_tile/service/notification_service.dart';
import 'package:quick_tile/welcome.dart';
import 'package:clipboard/clipboard.dart';

// Future<void> main(List<String> arguments) async {
//   WidgetsFlutterBinding.ensureInitialized();

//   FreeNotificationService().initNotification();
//   PremiumNotificationService().initNotification();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key, this.msg});
//   final String? msg;
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(
//         accountType: 'free',
//       ),
//     );
//   }
// }

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clipboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController field = TextEditingController();
  String pasteValue = '';

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      FlutterClipboard.paste().then((value) {
        setState(() {
          field.text = value;
          pasteValue = value;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  pasteValue,
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
