import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_tile/homepage.dart';

class WelcomPage extends StatelessWidget {
  WelcomPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => HomePage(
                      accountType: 'free',
                    ));
              },
              child: Text("Free Account"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => HomePage(
                      accountType: 'premium',
                    ));
              },
              child: Text("Premium Account"),
            ),
          ],
        ),
      ),
    );
  }
}
