import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/BeanSignUp.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/PrefManager.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';

class LoginSignUpScreen extends StatefulWidget {
    @override
    _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen>
    with SingleTickerProviderStateMixin {
    TabController _controller;
    var password_controller = TextEditingController();
    var Kitchen_Name = TextEditingController();
    var Kitchen_Address = TextEditingController();
    var City = TextEditingController();
    var LicenseNo = TextEditingController();
    var ExpiryDate = TextEditingController();
    var Email = TextEditingController();
    var PanCard = TextEditingController();
    var GstRegister = TextEditingController();
    var kitchenId = TextEditingController();
    var password = TextEditingController();
    ProgressDialog _progressDialog;
    final KitchenId = TextEditingController();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    bool selected = false;
    File _image;
    File _uploadimage;
    var type = "";
    var menuFile = "";
    var document = "";
    var date = "";

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
    _uploadImgFromCamera() async {
        File uploadimage = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);
        setState(() {

            _uploadimage = uploadimage;
        });
    }
    _uploadimgFromGallery() async {
        File uploadimage = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
        setState(() {
            _uploadimage = uploadimage;
        });
    }
    @override
    void initState() {
        super.initState();
        setState(() {
            selected = !selected;
        });
        _controller = new TabController(length: 2, vsync: this);
    }

    @override
    Widget build(BuildContext context) {
        _progressDialog = ProgressDialog(context);
        FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        return Scaffold(
            body: Column(
                children: [
                    new Container(
                        height: 180,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/ic_bg_login.png"),
                                fit: BoxFit.cover,
                            ),
                        ),
                    ),
                    SizedBox(
                        height: 10,
                    ),
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
                                                        indicatorColor: Colors.black,
                                                        isScrollable: true,
                                                        controller: _controller,
                                                        tabs: [
                                                            Tab(child: Text("Login")),
                                                            Tab(child: Text("SignUp")),
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
                                    Stack(
                                        children: [
                                            SingleChildScrollView(
                                                physics: BouncingScrollPhysics(),
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                        Padding(
                                                            child: Text(
                                                                "Welcome Back",
                                                                style: TextStyle(
                                                                    fontSize: 30,
                                                                    color: Colors.black,
                                                                    fontFamily: AppConstant.fontRegular),
                                                            ),
                                                            padding: EdgeInsets.only(left: 16, top: 20),
                                                        ),
                                                        Padding(
                                                            child: Text(
                                                                "User",
                                                                style: TextStyle(
                                                                    fontSize: 30,
                                                                    color: Colors.black,
                                                                    fontFamily: AppConstant.fontBold),
                                                            ),
                                                            padding: EdgeInsets.only(left: 16, top: 10),
                                                        ),
                                                        SizedBox(
                                                            height: 30,
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets.only(
                                                                left: 16, top: 20, right: 16),
                                                            child: TextFormField(
                                                                controller: kitchenId,
                                                                decoration: InputDecoration(
                                                                    labelText: "Enter Kitchen ID",
                                                                    fillColor: Colors.grey,
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color: Colors.grey, width: 2.0),
                                                                        borderRadius:
                                                                        BorderRadius.circular(25.0),
                                                                    ),
                                                                ),
                                                            )),
                                                        SizedBox(
                                                            height: 30,
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets.only(
                                                                left: 16, right: 16, top: 16, bottom: 86),
                                                            child: TextField(
                                                                controller: password,
                                                                keyboardType: TextInputType.text,
                                                                decoration: InputDecoration(
                                                                    labelText: "Password",
                                                                    fillColor: Colors.grey,
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color: Colors.grey, width: 2.0),
                                                                        borderRadius: BorderRadius.circular(25.0),
                                                                    ),
                                                                ),
                                                            ),
                                                        ),
                                                    ],
                                                )),
                                            Container(
                                                child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                        Expanded(
                                                            child: Align(
                                                                alignment: Alignment.bottomLeft,
                                                                child: InkWell(
                                                                    onTap: (){
                                                                      Navigator.pushNamed(context, '/forgot');
                                                                    },
                                                                  child: Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                          Padding(
                                                                              padding:
                                                                              EdgeInsets.only(bottom: 16, left: 16),
                                                                              child: Text(
                                                                                  "Forgot password?",
                                                                                  style: TextStyle(
                                                                                      color: Colors.black,
                                                                                      fontFamily:
                                                                                      AppConstant.fontRegular),
                                                                              ),
                                                                          ),
                                                                      ],
                                                                  ),
                                                                ),
                                                            ),
                                                        ),
                                                        Align(
                                                            alignment: Alignment.bottomLeft,
                                                            child: GestureDetector(
                                                                onTap: () {

                                                                    validationLogin();
                                                                },
                                                                child: Container(
                                                                    height: 55,
                                                                    width: 90,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(0xffFFA451),
                                                                        borderRadius: BorderRadius.circular(13)),
                                                                    margin:
                                                                    EdgeInsets.only(bottom: 16, right: 16),
                                                                    child: Align(
                                                                        alignment: Alignment.bottomRight,
                                                                        child: Center(
                                                                            child: Image.asset(Res.ic_back,
                                                                                width: 20, height: 20),
                                                                        )),
                                                                ),
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            )
                                        ],
                                    ),
                                    Container(
                                        child: Stack(
                                            children: [
                                                SingleChildScrollView(
                                                    physics: BouncingScrollPhysics(),
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                            Padding(
                                                                child: Text(
                                                                    "Welcome Back",
                                                                    style: TextStyle(
                                                                        fontSize: 30,
                                                                        color: Colors.black,
                                                                        fontFamily: AppConstant.fontRegular),
                                                                ),
                                                                padding: EdgeInsets.only(left: 16, top: 20),
                                                            ),
                                                            Padding(
                                                                child: Text(
                                                                    "User",
                                                                    style: TextStyle(
                                                                        fontSize: 30,
                                                                        color: Colors.black,
                                                                        fontFamily: AppConstant.fontBold),
                                                                ),
                                                                padding: EdgeInsets.only(left: 16, top: 10),
                                                            ),
                                                            SizedBox(
                                                                height: 30,
                                                            ),
                                                            Padding(
                                                                child: Text(
                                                                    "Enter you basic details here",
                                                                    style: TextStyle(
                                                                        fontSize: 16,
                                                                        color: Colors.black,
                                                                        fontFamily: AppConstant.fontBold),
                                                                ),
                                                                padding: EdgeInsets.only(left: 16, top: 10),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: 16, top: 20, right: 16),
                                                                child: TextFormField(
                                                                    controller: Kitchen_Name,
                                                                    decoration: InputDecoration(
                                                                        labelText: "Kitchen Name",
                                                                        fillColor: Colors.grey,
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(
                                                                                color: Colors.grey, width: 2.0),
                                                                            borderRadius: BorderRadius.circular(25.0),
                                                                        ),
                                                                    ),
                                                                )),
                                                            Padding(
                                                                padding:
                                                                EdgeInsets.only(left: 16, right: 16, top: 16),
                                                                child: TextField(
                                                                    controller: Kitchen_Address,
                                                                    keyboardType: TextInputType.text,
                                                                    decoration: InputDecoration(
                                                                        labelText: "Kitchen Address",
                                                                        fillColor: Colors.grey,
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(
                                                                                color: Colors.grey, width: 2.0),
                                                                            borderRadius: BorderRadius.circular(25.0),
                                                                        ),
                                                                    ),
                                                                ),
                                                            ),
                                                            Padding(
                                                                padding:
                                                                EdgeInsets.only(left: 16, right: 16, top: 16),
                                                                child: TextField(
                                                                    controller: City,
                                                                    keyboardType: TextInputType.text,
                                                                    decoration: InputDecoration(
                                                                        labelText: "City",
                                                                        fillColor: Colors.grey,
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(
                                                                                color: Colors.grey, width: 2.0),
                                                                            borderRadius: BorderRadius.circular(25.0),
                                                                        ),
                                                                    ),
                                                                ),
                                                            ),
                                                            Padding(
                                                                child: Text(
                                                                    "Enter you business details here",
                                                                    style: TextStyle(
                                                                        fontSize: 16,
                                                                        color: Colors.black,
                                                                        fontFamily: AppConstant.fontBold),
                                                                ),
                                                                padding: EdgeInsets.only(left: 16, top: 10),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: 16, top: 20, right: 16),
                                                                child: TextFormField(
                                                                    controller: LicenseNo,
                                                                    keyboardType: TextInputType.number,
                                                                    decoration: InputDecoration(
                                                                        labelText: "FSSAI Licence Number",
                                                                        fillColor: Colors.grey,
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(
                                                                                color: Colors.grey, width: 2.0),
                                                                            borderRadius: BorderRadius.circular(25.0),
                                                                        ),
                                                                    ),
                                                                )),
                                                            SizedBox(
                                                                height: 6,
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: 16, top: 20, right: 16),
                                                                child: InkWell(

                                                                    onTap: () async {
                                                                        var result = await showDatePicker(
                                                                            context: context,
                                                                            initialDate: DateTime.now(),
                                                                            firstDate: DateTime(2020),
                                                                            lastDate: DateTime(2022));
                                                                        print('$result');
                                                                        setState(() {
                                                                            date = result.year.toString()+"-"+  result.month.toString()+"-"+result.day.toString();
                                                                        });
                                                                    },
                                                                    child: Text(date == "" ? "Expiry Date Date" : date),)
                                                            ),
                                                            SizedBox(
                                                                height: 16,
                                                            ),
                                                            Container(
                                                                margin: EdgeInsets.only(left: 16,right: 16),
                                                              child: Divider(

                                                                  color: Colors.grey,
                                                              ),
                                                            ),

                                                            Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: 16, top: 20, right: 16),
                                                                child: TextFormField(
                                                                    controller: Email,
                                                                    decoration: InputDecoration(
                                                                        labelText: "Email",
                                                                        fillColor: Colors.grey,
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(
                                                                                color: Colors.grey, width: 2.0),
                                                                            borderRadius: BorderRadius.circular(25.0),
                                                                        ),
                                                                    ),
                                                                )),

                                                            Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: 16, top: 20, right: 16),
                                                                child: TextFormField(
                                                                    controller: PanCard,
                                                                    decoration: InputDecoration(
                                                                        labelText: "Pan Card",
                                                                        fillColor: Colors.grey,
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(
                                                                                color: Colors.grey, width: 2.0),
                                                                            borderRadius: BorderRadius.circular(25.0),
                                                                        ),
                                                                    ),
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: 16, top: 20, right: 16),
                                                                child: TextFormField(
                                                                    controller: GstRegister,
                                                                    decoration: InputDecoration(
                                                                        labelText: "Gst Registration",
                                                                        fillColor: Colors.grey,
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(
                                                                                color: Colors.grey, width: 2.0),
                                                                            borderRadius: BorderRadius.circular(25.0),
                                                                        ),
                                                                    ),
                                                                )),
                                                            SizedBox(
                                                                height: 10,
                                                            ),
                                                            Row(
                                                                children: [
                                                                    Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left: 16, top: 20, right: 16),
                                                                        child: Text(
                                                                            "Upload Documents",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontFamily: AppConstant.fontRegular,
                                                                                fontSize: 16),
                                                                        )),
                                                                    Expanded(
                                                                        child: InkWell(
                                                                            onTap: () {
                                                                                _uploadProfile(context);
                                                                            },
                                                                            child: Container(
                                                                                margin: EdgeInsets.only(
                                                                                    left: 16, top: 20, right: 16),
                                                                                height: 45,
                                                                                width: 100,
                                                                                color: Color(0xffF6F6F6),
                                                                                child: Center(
                                                                                    child: Text(
                                                                                        "Upload",
                                                                                        style: TextStyle(
                                                                                            color: Colors.black,
                                                                                            fontFamily:
                                                                                            AppConstant.fontRegular),
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Container(
                                                                        width: 50,
                                                                        alignment: Alignment.center,
                                                                        child: Container(
                                                                            margin: EdgeInsets.only(top: 10,right: 16),
                                                                            height: 50,
                                                                            width: double.infinity,
                                                                            child: _uploadimage == null
                                                                                ? Container(
                                                                                child: Image.network(document,
                                                                                    width: double.infinity,
                                                                                    height: 150,
                                                                                    fit: BoxFit.cover,
                                                                                ),
                                                                            )
                                                                                : Container(
                                                                                color: Color(0xffF9F9F9),
                                                                                child: Image.file(
                                                                                    _uploadimage,
                                                                                    width: double.infinity,
                                                                                    height: 150,
                                                                                    fit: BoxFit.cover,
                                                                                ),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                ],
                                                            ),
                                                            Row(
                                                                children: [
                                                                    Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left: 16, top: 20, right: 16),
                                                                        child: Text(
                                                                            "Upload Menu",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontFamily: AppConstant.fontRegular,
                                                                                fontSize: 16),
                                                                        )),
                                                                    Expanded(
                                                                        child: InkWell(
                                                                            onTap: () {
                                                                                _showPicker(context);
                                                                            },
                                                                            child: Container(
                                                                                margin: EdgeInsets.only(
                                                                                    left: 60, top: 20, right: 50),
                                                                                height: 45,
                                                                                width: 100,
                                                                                color: Color(0xffF6F6F6),
                                                                                child: Center(
                                                                                    child: Text(
                                                                                        "Upload",
                                                                                        style: TextStyle(
                                                                                            color: Colors.black,
                                                                                            fontFamily:
                                                                                            AppConstant.fontRegular),
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Container(
                                                                        width: 50,
                                                                        alignment: Alignment.center,
                                                                        child: Container(
                                                                            margin: EdgeInsets.only(top: 10,right: 16),
                                                                            height: 50,
                                                                            width: double.infinity,
                                                                            child: _image == null
                                                                                ? Container(
                                                                                child: Image.network(menuFile,
                                                                                    width: double.infinity,
                                                                                    height: 150,
                                                                                    fit: BoxFit.cover,
                                                                                ),
                                                                            )
                                                                                : Container(
                                                                                color: Color(0xffF9F9F9),
                                                                                child: Image.file(
                                                                                    _image,
                                                                                    width: double.infinity,
                                                                                    height: 150,
                                                                                    fit: BoxFit.cover,
                                                                                ),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                ],
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: 16, top: 20, right: 16, bottom: 50),
                                                                child: Text(
                                                                    "(you can upload  your menu in PNG,JPEG or PDF Format)",
                                                                    style: TextStyle(
                                                                        color: Colors.grey,
                                                                        fontFamily: AppConstant.fontRegular,
                                                                        fontSize: 12),
                                                                )),
                                                        ],
                                                    ),
                                                ),
                                                Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                            validation();
                                                        },
                                                        child: Container(
                                                            height: 55,
                                                            width: 90,
                                                            decoration: BoxDecoration(
                                                                color: Color(0xffFFA451),
                                                                borderRadius: BorderRadius.circular(13)),
                                                            margin: EdgeInsets.only(bottom: 16, right: 16),
                                                            child: Align(
                                                                alignment: Alignment.bottomRight,
                                                                child: Center(
                                                                    child: Image.asset(Res.ic_back,
                                                                        width: 20, height: 20),
                                                                )),
                                                        ),
                                                    ),
                                                ),
                                            ],
                                        )),
                                ],
                            ),
                        ),
                    ),
                ],
            ),
        );
    }

    void showDetailsVerifyDialog(
        String kitchenName,
        String kitchenAddress,
        String city,
        String licence,
        String expDate,
        String panCard,
        String gst,
        String email) {
        showDialog(
            context: context,
            builder: (_) => Center(
                // Aligns the container to center
                child: GestureDetector(
                    onTap: () {},
                    child: Wrap(
                        children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                ), // A simplified version of dialog.
                                width: 270.0,
                                height: 280.0,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        SizedBox(
                                            height: 16,
                                        ),
                                        Align(
                                            alignment: Alignment.topCenter,
                                            child: Image.asset(
                                                Res.ic_verify,
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.cover,
                                            ),
                                        ),
                                        SizedBox(
                                            height: 10,
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16, top: 20, right: 16),
                                                child: Text(
                                                    "Details verified",
                                                    style: TextStyle(
                                                        decoration: TextDecoration.none,
                                                        color: Colors.black,
                                                        fontFamily: AppConstant.fontBold,
                                                        fontSize: 18),
                                                )),
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16, top: 20, right: 16),
                                                child: Text(
                                                    "Now You can add your kitchen and start",
                                                    style: TextStyle(
                                                        decoration: TextDecoration.none,
                                                        color: Colors.grey,
                                                        fontFamily: AppConstant.fontRegular,
                                                        fontSize: 12),
                                                )),
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16, top: 5, right: 16),
                                                child: Text(
                                                    "your business!",
                                                    style: TextStyle(
                                                        decoration: TextDecoration.none,
                                                        color: Colors.grey,
                                                        fontFamily: AppConstant.fontRegular,
                                                        fontSize: 12),
                                                )),
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: GestureDetector(
                                                onTap: () {
                                                    Navigator.pop(context);
                                                    SingupUser(kitchenName, kitchenAddress, city,
                                                        licence, expDate, panCard, gst, email);
                                                },
                                                child: Container(
                                                    height: 40,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        color: Color(0xffFFA451),
                                                        borderRadius: BorderRadius.circular(13)),
                                                    margin: EdgeInsets.only(top: 25),
                                                    child: Center(
                                                        child: Text(
                                                            "Ok",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontFamily: AppConstant.fontBold,
                                                                fontSize: 12,
                                                                decoration: TextDecoration.none,
                                                            ),
                                                        )),
                                                ),
                                            ),
                                        ),
                                    ],
                                )),
                        ],
                    ),
                )));
    }

    void validation() {
        var kitchenName = Kitchen_Name.text.toString();
        var kitchenAddress = Kitchen_Address.text.toString();
        var city = City.text.toString();
        var licence = LicenseNo.text.toString();
        var expDate = ExpiryDate.text.toString();
        var panCard = PanCard.text.toString();
        var gst = GstRegister.text.toString();
        var email = Email.text.toString();
        RegExp regexEmail = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
        if (kitchenName.isEmpty) {
            Utils.showToast("Enter Kitchen Name");
        } else if (kitchenAddress.isEmpty) {
            Utils.showToast("Enter Kitchen Address");
        } else if (city.isEmpty) {
            Utils.showToast("Enter City ");
        } else if (licence.isEmpty) {
            Utils.showToast("Enter licence no ");
        } else if (date.isEmpty) {
            Utils.showToast("Enter Exp Date ");
        } else if (email.isEmpty) {
            Utils.showToast("Enter Email ");
        } else if (!regexEmail.hasMatch(email)) {
            Utils.showToast("please enter valid email");
        } else if (panCard.isEmpty) {
            Utils.showToast("Enter Pan Card ");
        } else if (gst.isEmpty) {
            Utils.showToast("Enter Gst Registration ");
        }else if (_image==null) {
            Utils.showToast(" Menu is empty");
        }else if (_uploadimage==null) {
            Utils.showToast("Document is empty");
        } else {
            showDetailsVerifyDialog(kitchenName, kitchenAddress, city, licence, expDate, panCard, gst, email);

        }
    }

    Future<BeanSignUp> SingupUser(String kitchenName, String kitchenAddress, String city, String licence, String expDate, String panCard, String gst,String email) async {
        _progressDialog.show();
        try {
            FormData data = FormData.fromMap({
                "token": "123456789",
                "kitchenname": kitchenName,
                "address": kitchenAddress,
                "stateid": "",
                "cityid": city,
                "pincode": "",
                "contactpersonname": '1',
                "contactpersonrole": '123',
                "mobilenumber": "",
                "kitchenscontactnumber": "",
                "email": email,
                "FSSAILicenceNo": licence,
                "expirydate": date.toString(),
                "pancard": panCard,
                "gstnumber": gst,
                "menufile": await MultipartFile.fromFile(_image.path,filename: _image.path),
                "documents": await MultipartFile.fromFile(_uploadimage.path,filename: _uploadimage.path),
            });
            BeanSignUp bean = await ApiProvider().registerUser(data);
            print(bean.data);
            _progressDialog.dismiss();
            if (bean.status ==true) {
                PrefManager.putBool(AppConstant.session, true);
                PrefManager.putString(AppConstant.user, jsonEncode(bean));
                Utils.showToast(bean.message);
                Navigator.pushReplacementNamed(context, '/homebase');
            } else {
                Utils.showToast(bean.message);
            }
        } on HttpException catch (exception) {
            _progressDialog.dismiss();
        } catch (exception) {
            _progressDialog.dismiss();
        }
    }

    void _showPicker(context) {
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


    void _uploadProfile(context) {
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
                                        _uploadimgFromGallery();
                                        Navigator.of(context).pop();
                                    }),
                                new ListTile(
                                    leading: new Icon(Icons.photo_camera),
                                    title: new Text('Camera'),
                                    onTap: () {
                                        _uploadImgFromCamera();
                                        Navigator.of(context).pop();
                                    },
                                ),
                            ],
                        ),
                    ),
                );
            });
    }

    void validationLogin() {
        var id = kitchenId.text.toString();
        var pass = password.text.toString();
        if(id.isEmpty){
            Utils.showToast("Please enter kitchen id");
        }else if(pass.isEmpty){
            Utils.showToast("Please enter  password");
        }else{
            loginUser(id,pass);
        }

    }

    Future<BeanLogin> loginUser(String kitchenId, String password) async {
        _progressDialog.show();
        try {
            FormData data = FormData.fromMap({
                "kitchen_id": kitchenId,
                "token": "123456789",
                "password": password,
            });
            BeanLogin bean = await ApiProvider().loginUser(data);
            print(bean.data);
            _progressDialog.dismiss();
            if (bean.status ==true) {
                PrefManager.putBool(AppConstant.session, true);
                PrefManager.putString(AppConstant.user, jsonEncode(bean));
                Utils.showToast(bean.message);
                Navigator.pushReplacementNamed(context, '/homebase');
            } else {
                Utils.showToast(bean.message);
            }
        } on HttpException catch (exception) {
            _progressDialog.dismiss();
        } catch (exception) {

            _progressDialog.dismiss();
        }
    }


}
