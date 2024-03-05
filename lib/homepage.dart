import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_tile/database/database_helper.dart';
import 'package:quick_tile/database/database_model.dart';
import 'package:quick_tile/notepage.dart';
import 'package:quick_tile/service/notification_service.dart';

class HomePage extends StatelessWidget {
  String accountType;
  HomePage({super.key, required this.accountType});

  final TextEditingController titleController = TextEditingController();

  Random random = Random();

  String userType = "free";

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff2c3e50),
          // image: DecorationImage(
          //   image: AssetImage("assets/images/back.jpg"),
          //   fit: BoxFit.cover,
          // ),
        ),
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.050,
            vertical: screenHeight * 0.010,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 250,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     print(accountType);
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5),
                  //       color: Colors.green,
                  //     ),
                  //     child: Padding(
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //       child: Text(
                  //         "Buy Premium",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w600,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  InkWell(
                    onTap: () {
                      Get.to(() => NoteListPage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.list,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                height: 60,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: titleController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.red,
                      ),
                      border: InputBorder.none,
                      hintText: "Type your Note",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      if (accountType.toString() == "free") {
                        FreeNotificationService().showNotification(
                          title: titleController.text,
                        );
                      } else {
                        PremiumNotificationService().showNotification(
                          title: titleController.text,
                        );
                      }

                      final customer = DatabaseModel(
                        id: random.nextInt(100),
                        title: titleController.text,
                      );
                      titleController.clear();
                      await DatabaseHelper.instance.addData(customer);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
