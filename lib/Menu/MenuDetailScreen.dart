import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/Menu/BasePackagescreen.dart';
import 'package:kitchen/Menu/KitchenDetailScreen.dart';
import 'package:kitchen/Menu/MenuBaseScreen.dart';
import 'package:kitchen/model/GetAccountDetail.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/AccountScreen.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class MenuDetailScreen extends StatefulWidget {
  @override
  _MenuDetailScreenState createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var flag = 1;
  Future future;
  var name="";
  var email="";
  var address="";
  var time="";
  var document="";
  var menu="";
  var days="";
  var rating=0.0;
  List<String> meals = [];
  ProgressDialog progressDialog;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      future = getAccountDetails(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog=ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Image.network(AppConstant.document+document, height: 180, fit: BoxFit.cover, width: double.infinity,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(top: 80, left: 10),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                        child:
                        Image.network(AppConstant.menuUrl+menu,width: 100,height: 150,fit: BoxFit.cover,))

                        )),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _scaffoldKey.currentState.openDrawer();
                            });
                          },
                          child: Image.asset(
                            Res.ic_menu,
                            width: 25,
                            height: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: InkWell(
                          onTap: () {

                            editScreen();
                          },
                          child: Image.asset(
                            Res.ic_edit,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Name of Kitchen",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: AppConstant.fontBold),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: RatingBarIndicator(
                      rating: rating,
                      itemCount: 5,
                      itemSize: 20.0,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  address,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: AppConstant.fontRegular),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "Open Now-",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      time,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  )

                ],

              ),
              Container(
                height: 130,
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(color: Color(0xffF3F6FA)),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "Lorem ipsum dolar is smet Lorem ipsum dolar is smet  Lorem ipsum dolar is smet  Lorem ipsum dolar is smet  Lorem ipsum dolar is smet  Lorem ipsum dolar is smet  Lorem ipsum dolar is smet",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstant.fontRegular,
                        fontSize: 12),
                  ),
                )),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BasePackagescreen()),
                        );
                      },
                      child: Container(
                          height: 110,
                          width: 150,
                          margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                          decoration: BoxDecoration(color: Color(0xffF3F6FA)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Image.asset(
                                  Res.ic_packages_default,
                                  width: 60,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 16),
                                child: Text(
                                  "PACKAGES",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MenuBaseScreen(0)),
                        );
                      },
                      child: Container(
                          height: 110,
                          width: 150,
                          margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                          decoration: BoxDecoration(color: Color(0xffF3F6FA)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Image.asset(
                                  Res.ic_menu_detail,
                                  width: 60,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 16),
                                child: Text(
                                  "MENU",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AccountScreen()),
                        );
                      },
                      child: Container(
                          height: 110,
                          width: 150,
                          margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                          decoration: BoxDecoration(color: Color(0xffF3F6FA)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Image.asset(
                                  Res.ic_other_info,
                                  width: 60,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 16),
                                child: Text(
                                  "OTHER INFO",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                  height: 150,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                  decoration: BoxDecoration(color: Color(0xffF3F6FA)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 10, top: 10),
                        child: Text(
                          "Type of Meals",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppConstant.fontBold,
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getListFood(meals[index]);
                          },
                          itemCount: meals.length,
                        ),
                      )
                    ],
                  )),
            ],
          ),
          physics: BouncingScrollPhysics(),
        ));
  }

  Widget getListFood(String meal) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          decoration: BoxDecoration(
              color: AppConstant.appColor,
              borderRadius: BorderRadius.circular(100)),
          width: 40,
          height: 40,
          child: Center(
            child: Image.asset(
              Res.ic_breakfast,
              width: 30,
              height: 30,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 10, top: 10),
          child: Text(
            meal.replaceAll('"[','').replaceAll(']"', ''),
            style: TextStyle(
                color: Colors.black,
                fontFamily: AppConstant.fontRegular,
                fontSize: 14),
          ),
        ),
      ],
    );
  }

  Future<GetAccountDetails> getAccountDetails(BuildContext context) async {
    var user = await Utils.getUser();
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "user_id": user.data.userId.toString(),
        "token": "123456789"
      });
      GetAccountDetails bean = await ApiProvider().getAccountDetails(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {

          name=bean.data.kitchenName;
          address=bean.data.address;
          email=bean.data.email;
          menu=bean.data.menufile;
          document=bean.data.documentfile;
          var days=bean.data.openDays.toString().replaceAll('"', '');
          time=bean.data.toTime+" : "+bean.data.fromTime+days;
          meals.add(bean.data.typeOfMeals);
          if(bean.data.totalrating!=null){
            rating = double.parse(bean.data.totalrating);
          }

        });
        return bean;
      } else {
        Utils.showToast(bean.message);
      }
      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }


  editScreen() async {
    var data = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => KitchenDetailScreen()));
    if (data != null) {
      future = getAccountDetails(context);
    }
  }
}

class Choice {
  Choice({this.title, this.image});

  String title;
  String image;
}

List<Choice> choices = <Choice>[
  Choice(title: 'breakfast', image: Res.ic_breakfast),
  Choice(title: 'Lunch', image: Res.ic_dinner),
  Choice(title: 'Dinner', image: Res.ic_dinner),
  Choice(title: 'Veg', image: Res.ic_veg),
  Choice(title: 'Non-Veg', image: Res.ic_chiken),
];
