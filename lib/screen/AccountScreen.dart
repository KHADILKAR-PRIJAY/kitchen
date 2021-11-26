import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/Menu/BasePackagescreen.dart';
import 'package:kitchen/Menu/MenuDetailScreen.dart';
import 'package:kitchen/model/BeanSignUp.dart';
import 'package:kitchen/model/BeanUpdateSetting.dart';
import 'package:kitchen/model/GetAccountDetail.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BeanSignUp userBean;

  ProgressDialog progressDialog;
  var name="";
  var email="";
  var address="";
  var number="";
  var password="";
  var name_controller = TextEditingController();
  var password_controller = TextEditingController();
  var address_controller = TextEditingController();
  var email_controller = TextEditingController();
  var number_controller = TextEditingController();
  void getUser() async {
    userBean  = await Utils.getUser();
   name=userBean.data.kitchenname;
    email=userBean.data.email;
    address=userBean.data.address;
    password=userBean.data.password;
    setState(() {

    });
  }
  Future future;

  @override
  void initState() {
    getUser();
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
        backgroundColor:Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppConstant.appColor,
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
                      child:Padding(
                        padding: EdgeInsets.only(top: 20),
                        child:  Image.asset(
                          Res.ic_menu,
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                      )
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16,top: 20),
                      child: Text(
                        "SETTINGS",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ],
                ),
                height: 100,
              ),

              Container(
                height: 150,
                width: double.infinity,
                child:  Image.asset(Res.ic_gallery,fit: BoxFit.cover,),
              ),

              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Image.asset(Res.ic_contact,width: 18,height: 18,),
                        ),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: TextField(
                              controller: name_controller,
                              style: TextStyle(fontFamily: AppConstant.fontRegular,fontSize: 14,color: Colors.black),
                              decoration: InputDecoration.collapsed(
                                hintText: name,
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                    SizedBox(
                      height: 55,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Image.asset(Res.ic_loc,width: 18,height: 18,),
                        ),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: TextField(
                              controller: address_controller,
                              style: TextStyle(fontFamily: AppConstant.fontRegular,fontSize: 14,color: Colors.black),
                              decoration: InputDecoration.collapsed(
                                hintText: address,
                              ),
                            ),
                          ),
                        )

                      ],
                    ),


                    SizedBox(
                      height: 55,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Image.asset(Res.ic_messag,width: 18,height: 18,),
                        ),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: TextField(
                              controller: email_controller,
                              style: TextStyle(fontFamily: AppConstant.fontRegular,fontSize: 14,color: Colors.black),
                              decoration: InputDecoration.collapsed(
                                hintText: email,
                              ),
                            ),
                          ),
                        )

                      ],
                    ),

                    SizedBox(
                      height: 55,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Image.asset(Res.ic_phn,width: 18,height: 18,),
                        ),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: TextField(
                              controller: number_controller,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontFamily: AppConstant.fontRegular,fontSize: 14,color: Colors.black),
                              decoration: InputDecoration.collapsed(
                                hintText: number==""?"Number":number,
                              ),
                            ),
                          ),
                        )

                      ],
                    ),

                    SizedBox(
                      height: 55,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Image.asset(Res.ic_pass,width: 18,height: 18,),
                        ),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: TextField(
                              controller: password_controller,
                              obscureText: true,
                              style: TextStyle(fontFamily: AppConstant.fontRegular,fontSize: 16,color: Colors.black),
                              decoration: InputDecoration.collapsed(
                                hintText: password==""?"Password":password,
                              ),
                            ),
                          ),
                        )

                      ],
                    ),

                    SizedBox(
                      height: 150,
                    ),
                    InkWell(
                      onTap: (){

                        updateAccount();
                      },
                      child: Container(
                        height: 55,
                        margin: EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 16),
                        decoration: BoxDecoration(
                            color: AppConstant.appColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Save",style: TextStyle(fontSize: 16,fontFamily: AppConstant.fontBold,color: Colors.white),),
                        ),
                      ),
                    )
                  ],
                )

              ),

            ],
          ),

          physics: BouncingScrollPhysics(),
        )
    );
  }

  Future<BeanUpdateSetting> updateAccount() async {
    var name=name_controller.text.toString();
    var address=address_controller.text.toString();
    var email=email_controller.text.toString();
    var number=number_controller.text.toString();
    var password=password_controller.text.toString();
    progressDialog.show();
    try {
      FormData data = FormData.fromMap({
        "token": "123456789",
        "user_id": "2",
        "kitchen_name": name.toString(),
        "address": address.toString(),
        "email": email.toString(),
        "mobile_number": number,
        "password": password,
      });
      BeanUpdateSetting  bean = await ApiProvider().updateSetting(data);
       print(bean.data);
       progressDialog.dismiss();
      if (bean.status ==true) {
        Utils.showToast(bean.message);
        Navigator.pop(context);
      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss();
    } catch (exception) {

      progressDialog.dismiss();
    }
  }


  Future<GetAccountDetails> getAccountDetails(BuildContext context) async {
    progressDialog.show();
    try {

      FormData from = FormData.fromMap({
        "user_id": "2",
        "token": "123456789"
      });
      GetAccountDetails bean = await ApiProvider().getAccountDetails(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          if(bean.data!=null){
            name=bean.data.kitchenName;
            address=bean.data.address;
            email=bean.data.email;
            number=bean.data.mobileNumber;
            password=bean.data.password;
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
  }
