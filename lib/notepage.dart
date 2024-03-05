import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quick_tile/database/database_helper.dart';
import 'package:quick_tile/database/database_model.dart';
import 'package:quick_tile/service/notification_service.dart';

class NoteListPage extends StatefulWidget {
  NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff2c3e50),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: FutureBuilder(
            future: DatabaseHelper.instance.getmyData(),
            builder: (BuildContext context,
                AsyncSnapshot<List<DatabaseModel>> snapshot) {
              return snapshot.hasData
                  ? ListView.separated(
                      // physics: BouncingScrollPhysics(),
                      separatorBuilder: (_, i) {
                        return SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        final myindex = index + 1;
                        final customer = snapshot.data![index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "$myindex. ${customer.title}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: screenWidth * 0.035,
                                          ),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                FreeNotificationService()
                                                    .showNotification(
                                                  title: customer.title,
                                                );
                                              },
                                              child: Icon(Icons.restore_page)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              int? myid = customer.id;

                                              setState(() {
                                                DatabaseHelper.instance
                                                    .deleteData(myid!);
                                                DatabaseHelper.instance
                                                    .getmyData();
                                              });
                                            },
                                            child: Icon(
                                              CupertinoIcons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
