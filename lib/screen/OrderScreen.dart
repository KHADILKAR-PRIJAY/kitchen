import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/Order/ActiveScreen.dart';
import 'package:kitchen/Order/OrdersHistory.dart';
import 'package:kitchen/Order/RequestScreen.dart';
import 'package:kitchen/Order/TrialRequestScreen.dart';
import 'package:kitchen/Order/UpcomingScreen.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/FilterScreen.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var isSelected = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        backgroundColor: AppConstant.appColor,
        key: _scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _scaffoldKey.currentState.openDrawer();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Image.asset(
                          Res.ic_menu,
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                      )),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Text(
                        "Orders",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                 /* InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FilterScreen()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 16, top: 16),
                      child: Image.asset(
                        Res.ic_filter,
                        width: 25,
                        height: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),*/
                ],
              ),
              height: 70,
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 10, top: 20, right: 10, bottom: 10),
                        width: double.infinity,
                        height: 55,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getItem(choices[index], index);
                          },
                          itemCount: choices.length,
                        ),
                      ),
                      Expanded(child: getPage())
                    ],
                  )),
            ),
          ],
        ));
  }

  Widget getItem(Choice choic, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = index;
        });
      },
      child: isSelected == index
          ? Container(
              height: 45,
              width: 120,
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: AppConstant.appColor,
                  borderRadius: BorderRadius.circular(6)),
              child: Center(
                child: Text(
                  choic.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: AppConstant.fontBold),
                ),
              ),
            )
          : Container(
              height: 45,
              width: 120,
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Color(0xffF3F6FA),
                  borderRadius: BorderRadius.circular(6)),
              child: Center(
                child: Text(
                  choic.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: AppConstant.fontBold),
                ),
              ),
            ),
    );
  }

  getPage() {
    if (isSelected == 0) {
      return RequestScreen();
    } else if (isSelected == 1) {
      return ActiveScreen();
    }
    else if (isSelected == 2) {
      return UpcomingScreen();
    } else if (isSelected == 3) {
      return OrdersHistory();
    }
    else if (isSelected == 4) {
      return TrialRequestScreen();
    }
  }
}

class Choice {
  Choice({this.title, this.image});

  String title;
  String image;
}

List<Choice> choices = <Choice>[
  Choice(title: 'Request'),
  Choice(title: 'Active'),
  Choice(title: 'Upcoming'),
  Choice(title: 'Order History'),
  Choice(title: 'Trial Request'),
];
