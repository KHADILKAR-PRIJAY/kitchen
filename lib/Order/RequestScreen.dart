import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanGetOrderRequest.dart';
import 'package:kitchen/model/BeanOrderAccepted.dart';
import 'package:kitchen/model/BeanSignUp.dart' as bean;
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';

import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';
import 'package:intl/intl.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}



class _RequestScreenState extends State<RequestScreen> {
  ProgressDialog progressDialog;
  Future future;
  bean.BeanSignUp userBean;
  var kitchenId="";
  var currentDate="";

  void getUser() async {
    userBean  = await Utils.getUser();
    kitchenId=userBean.data.kitchenid.toString();

    setState(() {

    });
  }
  @override
  void initState() {
    getUser();
    getCurrentDate();
    Future.delayed(Duration.zero, () {
      future = getOrderRequest(context);

    });
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    progressDialog=ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<BeanGetOrderRequest>(
                  future: future,
                  builder: (context, projectSnap) {
                    print(projectSnap);
                    if (projectSnap.connectionState == ConnectionState.done) {
                      var result;
                      if (projectSnap.data != null) {
                        result = projectSnap.data.data;
                        if (result != null) {
                          print(result.length);
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getOrderList(result[index]);
                            },
                            itemCount: result.length,
                          );
                        }
                      }
                    }
                    return Container(
                        child: Center(
                          child: Text(
                            "No Request Found",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily:
                                AppConstant.fontBold),
                          ),
                        ));
                  }),
            ),
          ],
        ));
  }

  Widget getOrderList(Data result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 10),
              child: Image.asset(
                Res.ic_people,
                width: 60,
                height: 60,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        result.customerName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 75, top: 10),
                      child: Text(
                        AppConstant.rupee +  result.totalBill,
                        style: TextStyle(
                            color: AppConstant.lightGreen,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    result.orderDate,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 10),
                      child: Text(
                        "Weekly plan",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 10),
                      child: Text(
                        "Monthly Plan",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Image.asset(
                        Res.ic_breakfast,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        result.weeklyPlan,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Image.asset(
                        Res.ic_dinner,
                        width: 20,
                        height: 25,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        result.monthlyPlan,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1,
                ),
                Divider(
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 1,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16,top: 10),
                      child: Image.asset(
                        Res.ic_loc,
                        width: 20,
                        height: 20,
                        color: AppConstant.lightGreen,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, top: 10),
                        child: Text(
                          result.deliveryAddress,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: AppConstant.fontRegular),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 110,
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "REJECT",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                      orderAccepted(result.orderId);

                        },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, bottom: 10),
                        height: 50,
                        width: 110,
                        decoration: BoxDecoration(
                            color: AppConstant.appColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "ACCEPT",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  Future<BeanGetOrderRequest> getOrderRequest(BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": kitchenId,
        "token": "123456789",
        "filter_fromdate": currentDate,
        "filter_todate": "",
        "filter_order_number": ""
      });
      BeanGetOrderRequest bean = await ApiProvider().getOrderRequest(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {

        setState(() {

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

  void getCurrentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    currentDate  = formatter.format(now);
    print(currentDate);

  }


  Future<BeanOrderAccepted> orderAccepted(String orderId) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": kitchenId,
        "token": "123456789",
        "order_id": orderId,
      });
      BeanOrderAccepted bean = await ApiProvider().ordeAccept(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        getOrderRequest(context);
        setState(() {

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
