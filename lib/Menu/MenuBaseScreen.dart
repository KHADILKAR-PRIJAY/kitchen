import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/Menu/BasePackagescreen.dart';
import 'package:kitchen/Menu/MenuDetailScreen.dart';
import 'package:kitchen/Menu/menu_bean.dart';
import 'package:kitchen/model/BeanAddLunch.dart';
import 'package:kitchen/model/BeanDinnerAdd.dart';
import 'package:kitchen/model/BeanGetLunch.dart';
import 'package:kitchen/model/BeanSaveMenu.dart';
import 'package:kitchen/model/BeanSignUp.dart' ;
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Log.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';

class MenuBaseScreen extends StatefulWidget {
  var flag;
  MenuBaseScreen(this.flag);

  @override
  _MenuBaseScreenState createState() => _MenuBaseScreenState(flag);
}

class _MenuBaseScreenState extends State<MenuBaseScreen>
    with SingleTickerProviderStateMixin {
  Breakfast breakfast;
  Lunch lunch;
  ProgressDialog _progressDialog;
  var isSelected = 1;
  TabController _controller;
  bool isReplaceOne = true;
  bool isReplaceTwo = false;
  bool isReplaceThree = false;
  bool isDinnerSouth = false;
  bool isDinnerNorth = false;

  bool isLunchSouth = false;
  bool isLunchNorth = false;


  File _image;
  File _imageDinner;
  File _imageLunch;
  var isSelectVeg=1;
  var isSelectCategory=1;
  var isDinnerCategory=1;
  var isSelectMenu = 1;
  var isSelectFood = 2;
  var isMealType = 1;
  var isSelectedNorth = 1;
  bool isMenu = true;
  bool saveMenuSelected = false;
  bool addMenu = false;
  var _isOnSubscription = false;
  var _isSounIndianMeal = false;
  var _isNorthIndianist = false;
  var _other = false;
  var _other2 = false;
  var addDefaultIcon = true;
  var addPack = false;
  var setMenuPackage = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var flag;
  Future _future;
  var nameBreakfast = TextEditingController();
  var priceBreakfast = TextEditingController();
  var priceLunch = TextEditingController();
  var nameLunch = TextEditingController();

  var priceDinner = TextEditingController();
  var nameDinner = TextEditingController();

  List<OtherIndian> other=[];


  var userId="";
  var kitchenID="";
  BeanSignUp userBean;
  _MenuBaseScreenState(this.flag);
  void getUser() async {
    userBean  = await Utils.getUser();
    kitchenID=userBean.data.kitchenid.toString();
    userId=userBean.data.userId.toString();

    setState(() {

    });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;

    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;

    });
  }
  _imgFromCameraLunch() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {

      _imageLunch=image;
    });
  }
  _imgFromGalleryDinner() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _imageDinner = image;

    });
  }
  _imgFromCameraDinner() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {

      _imageDinner=image;
    });
  }

  _imgFromGalleryLunch() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {

      _imageLunch=image;
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
    _progressDialog = new ProgressDialog(context);
    _controller = new TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMenuLunch();
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        key: _scaffoldKey,
        backgroundColor: AppConstant.appColor,
        body: Column(
          children: [
            visileMenuheader(),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  margin: EdgeInsets.only(top: 20),
                  child: MenuSelected()


              ),
            ),
          ],
        ));
  }

  replaceAddMenu() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    'Breakfast',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppConstant.fontBold),
                  ),
                )),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        'South Indian Meals',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: 20, top: 10),
                    child: CupertinoSwitch(
                      activeColor: Color(0xff7EDABF),
                      value: _isSounIndianMeal,
                      onChanged: (newValue) {
                        setState(() {
                          _isSounIndianMeal = newValue;
                          if (_isSounIndianMeal == true) {

                          } else {

                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        'North Indian Meals',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: 20, top: 10),
                    child: CupertinoSwitch(
                      activeColor: Color(0xff7EDABF),
                      value: _isNorthIndianist,
                      onChanged: (newValue) {
                        setState(() {
                          _isNorthIndianist = newValue;
                          if (_isNorthIndianist == true) {} else {}
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Row(
              children: [

                InkWell(
                  onTap: () {
                    setState(() {
                      isSelectVeg=1;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 110,
                    margin: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color: isSelectVeg==1?Color(0xffFFA451):Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Veg",
                        style: TextStyle(
                            color:isSelectVeg==1?Colors.white:Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelectVeg=2;

                    });
                  },
                  child: Container(
                    height: 40,
                    width: 110,
                    margin: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color: isSelectVeg==2?Color(0xffFFA451):Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Non-Veg",
                        style: TextStyle(
                            color:isSelectVeg==2?Colors.white:Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                )
              ],
            ),

            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: (){

                    _showPicker(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: _image==null?Image.asset(
                      Res.ic_poha,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ):ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _image,
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 30),
                      child: TextField(
                        controller: nameBreakfast,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "name"),
                      ),
                    )),
                Expanded(
                    child: Container(
                      width: 50,
                      margin: EdgeInsets.only(left: 10,
                          right: 16,
                          top: 30),
                      child: TextField(
                        controller: priceBreakfast,
                        keyboardType: TextInputType.number,
                        decoration:
                        InputDecoration(
                            hintText: AppConstant.rupee +"Price"),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 26,
            ),

            SizedBox(
              height: 10,
            ),

            Center(
              child: InkWell(
                onTap: (){

                  validationAddBreakfast();

                   },
                child: Container(
                  height: 40,

                  width: 150,
                  decoration: BoxDecoration(
                    color: AppConstant.appColor,
                      borderRadius: BorderRadius.circular(100
                    ),

                  ),
                  child:  Center(
                    child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text("Add Breakfast",style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Divider(
              height: 20,
              thickness: 5,
              color: Colors.grey.shade100,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 20),
              child: Text(
                'Lunch',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        'South Indian Meals',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: 20, top: 10),
                    child: CupertinoSwitch(
                      activeColor: Color(0xff7EDABF),
                      value: isLunchSouth,
                      onChanged: (newValue) {
                        setState(() {
                          isLunchSouth = newValue;
                          if (isLunchSouth == true) {} else {}
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        'North Indian Meals',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: 20, top: 10),
                    child: CupertinoSwitch(
                      activeColor: Color(0xff7EDABF),
                      value: isLunchNorth,
                      onChanged: (newValue) {
                        setState(() {
                          isLunchNorth = newValue;
                          if (isLunchNorth == true) {} else {}
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [

                InkWell(
                  onTap: () {
                    setState(() {
                      isSelectCategory=1;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 110,
                    margin: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color:isSelectCategory==1?Color(0xffFFA451):Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Rice",
                        style: TextStyle(
                            color:isSelectCategory==1?Colors.white:Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelectCategory=2;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 110,
                    margin: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color:isSelectCategory==2?Color(0xffFFA451):Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Dal",
                        style: TextStyle(
                            color:isSelectCategory==2?Colors.white:Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                )

              ],
            ),

            SizedBox(
              height: 16,
            ),
            Row(
              children: [

                InkWell(
                  onTap: () {
                    setState(() {
                      isSelectCategory=3;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 110,
                    margin: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color:isSelectCategory==3?Color(0xffFFA451):Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Bread",
                        style: TextStyle(
                            color:isSelectCategory==3?Colors.white:Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelectCategory=4;

                    });
                  },
                  child: Container(
                    height: 40,
                    width: 110,
                    margin: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color:isSelectCategory==4?Color(0xffFFA451):Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Others",
                        style: TextStyle(
                            color:isSelectCategory==4?Colors.white:Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                )

              ],
            ),

            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: (){
                    _showPickerLunch(context);
                   },
                  child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child:_imageLunch==null? Image.asset(
                      Res.ic_poha,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ):ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _imageLunch,
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 30),
                      child: TextField(
                        controller: nameLunch,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "name"),
                      ),
                    )),
                Expanded(
                    child: Container(
                      width: 50,
                      margin: EdgeInsets.only(left: 10,
                          right: 16,
                          top: 30),
                      child: TextField(
                        controller: priceLunch,
                        keyboardType: TextInputType.number,
                        decoration:
                        InputDecoration(
                            hintText: AppConstant.rupee +"Price"),
                      ),
                    ))
              ],
            ),
            Divider(
              height: 16,
              color: Colors.grey.shade400,
            ),
            Center(
              child: InkWell(
                onTap: (){
                 lunchValidation();
               },
                child: Container(
                  height: 40,

                  width: 150,
                  decoration: BoxDecoration(
                    color: AppConstant.appColor,
                    borderRadius: BorderRadius.circular(100
                    ),

                  ),
                  child:  Center(
                    child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text("Add Lunch",style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ),
            ),
            Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    'Dinner',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppConstant.fontBold),
                  ),
                )),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        'South Indian Meals',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: 20, top: 10),
                    child: CupertinoSwitch(
                      activeColor: Color(0xff7EDABF),
                      value: isDinnerSouth,
                      onChanged: (newValue) {
                        setState(() {
                          isDinnerSouth = newValue;
                          if (isDinnerSouth == true) {

                          } else {

                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        'North Indian Meals',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: 20, top: 10),
                    child: CupertinoSwitch(
                      activeColor: Color(0xff7EDABF),
                      value: isDinnerNorth,
                      onChanged: (newValue) {
                        setState(() {
                          isDinnerNorth = newValue;
                          if (isDinnerNorth == true) {} else {}
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Row(
              children: [

                InkWell(
                  onTap: () {
                    setState(() {
                      isDinnerCategory=1;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 110,
                    margin: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color: isDinnerCategory==1?Color(0xffFFA451):Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Veg",
                        style: TextStyle(
                            color:isDinnerCategory==1?Colors.white:Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isDinnerCategory=2;

                    });
                  },
                  child: Container(
                    height: 40,
                    width: 110,
                    margin: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color: isDinnerCategory==2?Color(0xffFFA451):Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Non-Veg",
                        style: TextStyle(
                            color:isDinnerCategory==2?Colors.white:Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                )
              ],
            ),

            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: (){
                    showPickerDinner(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: _imageDinner==null?Image.asset(
                      Res.ic_poha,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ):ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _imageDinner,
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 30),
                      child: TextField(
                        controller: nameDinner,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "name"),
                      ),
                    )),
                Expanded(
                    child: Container(
                      width: 50,
                      margin: EdgeInsets.only(left: 10,
                          right: 16,
                          top: 30),
                      child: TextField(
                        controller: priceDinner,
                        keyboardType: TextInputType.number,
                        decoration:
                        InputDecoration(
                            hintText: AppConstant.rupee +"Price"),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 26,
            ),

            SizedBox(
              height: 10,
            ),

            Center(
              child: InkWell(
                onTap: (){
                  addDinnerValidation();
                     },
                child: Container(
                  height: 40,

                  width: 150,
                  decoration: BoxDecoration(
                    color: AppConstant.appColor,
                    borderRadius: BorderRadius.circular(100
                    ),

                  ),
                  child:  Center(
                    child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text("Add Dinner",style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ),
            ),

            Divider(
              color: Colors.grey.shade400,
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                setState(() {

                  isReplaceThree = true;
                  isReplaceOne = false;
                  isReplaceTwo = false;


                });
              },
              child: Container(
                  margin: EdgeInsets.only(
                      left: 20, right: 20, top: 60, bottom: 15),
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xffFFA451),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Save Menu",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: AppConstant.fontBold),
                    ),
                  )),
            )
          ],
        ),
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  replaceDefaultScreen() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 60),
                          child: Image.asset(
                            Res.ic_default_menu,
                            width: 220,
                            height: 120,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      "No menu added yet",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "look's like you, haven't\n made your menu yet.",
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: AppConstant.fontRegular,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isReplaceTwo = true;
                          isReplaceOne = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Color(0xffFFA451),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2, color: Colors.grey.shade300)
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Add menu",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          physics: BouncingScrollPhysics(),
        ));
  }

  replaceSaveMenu() {
    return Column(
      children: [
        Container(
          height: 100,
          child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        child: Container(
                          child: TabBar(
                            unselectedLabelColor: Colors.black,
                            labelColor: Colors.black,
                            indicatorColor: AppConstant.appColor,
                            isScrollable: false,
                            controller: _controller,
                            tabs: [
                              Tab(text: 'BreakFast'),
                              Tab(text: 'Lunch & Dinner Meals'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ),
        Expanded(
          child: Container(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    breakfast != null ? breakfast.mealTypes.isEmpty
                        ? SizedBox()
                        : Wrap(
                      direction: Axis.vertical,
                      children: breakfast.mealTypes.entries.map((entry) {
                        return InkWell(
                            onTap: () {
                              setState(() {
                                breakfast.mealName = entry.key;
                              });
                            },
                            child: Padding(
                                padding: EdgeInsets.only(left: 16, top: 10),
                                child: Text(entry.key)

                            )
                        );
                      }).toList(),
                    ) : SizedBox(),

                    breakfast == null ? SizedBox() : Column(
                      children: breakfast.mealTypes[breakfast.mealName == null
                          ? ""
                          : breakfast.mealName].map((mealType) =>
                          Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Image.network(
                                  AppConstant.menuUrl + mealType.image,
                                  width: 55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                children: [

                                  Padding(
                                    child: Text(mealType.name),
                                 padding: EdgeInsets.only(left: 16,top: 16),
                                  ),

                                  Padding(
                                    child: Text(mealType.price),
                                    padding: EdgeInsets.only(left: 16,top: 16),
                                  )
                                ],
                              )
                            ],
                          )).toList(),
                    ),
                  ],
                ),

                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    'South Indian Meals',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                margin: EdgeInsets.only(right: 20, top: 10),
                                child: CupertinoSwitch(
                                  activeColor: Color(0xff7EDABF),
                                  value: _isOnSubscription,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _isOnSubscription = newValue;
                                      if (_isOnSubscription == true) {} else {}
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    'North Indian Meals',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                margin: EdgeInsets.only(right: 20, top: 10),
                                child: CupertinoSwitch(
                                  activeColor: Color(0xff7EDABF),
                                  value: _isNorthIndianist,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _isNorthIndianist = newValue;
                                      if (_isNorthIndianist == true) {} else {}
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),

                        Column(
                          children: [
                     /*     ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getLiveOffer(result[index]);
                          },
                          itemCount: result.length,
                        )*/
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  getPage() {
    if (isReplaceOne == true) {
      return replaceAddMenu();
    } else if (isReplaceTwo == true) {
      return replaceAddMenu();
    } else if (isReplaceThree == true) {
      return replaceSaveMenu();
    }
  }


  getItem() {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Image.asset(
                Res.ic_veg,
                width: 15,
                height: 16,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
                child: Text("veg", style: TextStyle(
                    color: Colors.grey, fontFamily: AppConstant.fontRegular))),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                "inStock",
                style: TextStyle(
                    color: Colors.grey, fontFamily: AppConstant.fontRegular),
              ),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return getListFood();
          },
          itemCount: 2,
        )
      ],
    );
  }

  getListFood() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MenuDetailScreen()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Image.asset(
                    Res.ic_idle,
                    width: 55,
                    height: 55,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          child: Text(
                            "Poha",
                            style: TextStyle(
                                fontFamily: AppConstant.fontBold,
                                color: Colors.black),
                          ),
                          padding: EdgeInsets.only(left: 16),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(AppConstant.rupee + "124",
                              style: TextStyle(
                                  fontFamily: AppConstant.fontBold,
                                  color: Color(0xff7EDABF))),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: 20, top: 10),
                    child: CupertinoSwitch(
                      activeColor: Color(0xff7EDABF),
                      value: _isSounIndianMeal,
                      onChanged: (newValue) {
                        setState(() {
                          _isSounIndianMeal = newValue;
                          if (_isSounIndianMeal == true) {} else {}
                        });
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  getLunchDinner() {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Image.asset(
                Res.ic_veg,
                width: 15,
                height: 16,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text("Vegetable",
                style: TextStyle(
                    color: AppConstant.appColor,
                    fontFamily: AppConstant.fontRegular)),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return getListFood();
          },
          itemCount: 2,
        )
      ],
    );
  }

  MenuSelected() {
    if (isSelected == 1) {
      return getPage();
    } else {
      return BasePackagescreen();
    }
  }

  visileMenuheader() {
    if (flag == 0) {
      return Column(
        children: [
          Container(
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
                  child: Image.asset(
                    Res.ic_menu,
                    width: 30,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Image.asset(
                  Res.ic_chef,
                  width: 65,
                  height: 65,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 50),
                      child: Text(
                        "Name oF Kitchen",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        "Finest multi-cusine",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            height: 150,
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white)),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          isReplaceOne = true;
                          isSelected = 1;
                          print(isSelected);
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 180,
                        decoration: BoxDecoration(
                            color: isSelected == 1
                                ? Colors.white
                                : Color(0xffFFA451),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                bottomLeft: Radius.circular(100))),
                        child: Center(
                          child: Text(
                            "Menu",
                            style: TextStyle(
                                color: isSelected == 1
                                    ? Colors.black
                                    : Colors.white,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                      )),
                ),
                Expanded(
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          isSelected = 2;
                          print(isSelected);
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 180,
                        decoration: BoxDecoration(
                            color: isSelected == 2
                                ? Colors.white
                                : Color(0xffFFA451),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(100),
                                bottomRight: Radius.circular(100))),
                        child: Center(
                          child: Text(
                            "Packages",
                            style: TextStyle(
                                color: isSelected == 2
                                    ? Colors.black
                                    : Colors.white,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      );
    }
    else {
      return Container();
    }
  }

  void getMenu() async
  {
    _progressDialog = new ProgressDialog(context);
    _progressDialog.show();
    var map = FormData.fromMap({"token": "123456789",
      "user_id": "2"
    });
    MenuBean menuBean = await ApiProvider().getMenu(map);
    _progressDialog.dismiss();
    if (menuBean.status) {
      Log.info(menuBean.data.southindian.breakfast.mealName);
      setState(() {
        this.breakfast = menuBean.data.southindian.breakfast;
        this.lunch = menuBean.data.southindian.lunch;
      });
    }
    else {
      Utils.showToast(menuBean.message);
    }
  }

  void validationAddBreakfast() {
    if(nameBreakfast.text.isEmpty){
      Utils.showToast("Please add breakfast name");
    }else if(priceBreakfast.text.isEmpty){
      Utils.showToast("Please add breakfast price");
    }else if(_image==null){
      Utils.showToast("Please add breakfast image");
    }else{
      addBreakfast();
    }

  }

  Future<BeanSaveMenu> addBreakfast() async {
    _progressDialog.show();
    try {

      FormData from = FormData.fromMap({
        "kitchen_id": kitchenID,
        "token": "123456789",
        "category": isSelectVeg==1?"Veg":"Non-Veg",
        "cuisinetype": _isSounIndianMeal==true?"0":_isNorthIndianist==true?"1":"2",
        "itemname[]": nameBreakfast.text.toString(),
        "price[]": priceBreakfast.text.toString(),
        "item_image1": await MultipartFile.fromFile(_image.path,filename: _image.path),
      });
      print(from);
      BeanSaveMenu bean = await ApiProvider().beanSaveMenu(from);
      print(bean.data);
      _progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);

        setState(() {

          nameBreakfast.text="";
          priceBreakfast.text="";
          _image=null;
        });

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    }

  }
   _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


  _showPickerLunch(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGalleryLunch();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCameraLunch();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }




  void lunchValidation() {
    if(nameLunch.text.isEmpty){
      Utils.showToast("Please add lunch name");
    }else if(priceLunch.text.isEmpty){
      Utils.showToast("Please add lunch price");
    }else if(_imageLunch==null){
      Utils.showToast("Please add lunch image");
    }else{
      addLunch();
    }
  }

  Future<BeanLunchAdd> addLunch() async {
    _progressDialog.show();
    try {


      FormData from = FormData.fromMap({
        "kitchen_id": kitchenID,
        "token": "123456789",
        "category": isSelectCategory==1?"Rice":isSelectCategory==2?"Dal":isSelectCategory==3?"Bread":isSelectCategory==4?"Others":"",
        "cuisinetype": isLunchSouth==true?"0":isLunchNorth==true?"1":"2",
        "itemname[]": nameLunch.text.toString(),
        "price[]": priceLunch.text.toString(),
        "item_image1": await MultipartFile.fromFile(_imageLunch.path,filename: _imageLunch.path),
      });


      print(from);
      BeanLunchAdd bean = await ApiProvider().beanLunchAdd(from);
      print(bean.data);
      _progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);

        setState(() {
          nameLunch.text="";
          priceLunch.text="";
          _imageLunch=null;


        });

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    }


  }

  void addDinnerValidation() {

    if(nameDinner.text.isEmpty){
      Utils.showToast("Please add dinner name");
    }else if(priceDinner.text.isEmpty){
      Utils.showToast("Please add dinner price");
    }else if(_imageDinner==null){
      Utils.showToast("Please add dinner image");
    }else{
      addDinner();
    }
  }

  Future<BeanDinnerAdd> addDinner() async {

    _progressDialog.show();
    try {


      FormData from = FormData.fromMap({
        "kitchen_id": kitchenID,
        "token": "123456789",
        "category": isDinnerCategory==1?"Veg":isDinnerCategory==2?"Non-Veg":"",
        "cuisinetype": isDinnerSouth==true?"0":isDinnerNorth==true?"1":"2",
        "itemname[]": nameDinner.text.toString(),
        "price[]": priceDinner.text.toString(),
        "item_image1": await MultipartFile.fromFile(_imageDinner.path,filename: _imageDinner.path),
      });


      print(from);
      BeanDinnerAdd bean = await ApiProvider().beanDinnerAdd(from);
      print(bean.data);
      _progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);

        setState(() {
          nameDinner.text="";
          priceDinner.text="";
          _imageDinner=null;


        });

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    }
  }

  showPickerDinner(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGalleryDinner();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCameraDinner();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<BeanGetLunch> getMenuLunch() async {
    _progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": kitchenID,
        "token": "123456789",
      });
      print(from);
      BeanGetLunch bean = await ApiProvider().beanGetLunch(from);
      print(bean.data);
      _progressDialog.dismiss();
      if (bean.status == true) {
        

        other.add(bean.data.otherIndian);
        setState(() {



        });

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    }

  }




}