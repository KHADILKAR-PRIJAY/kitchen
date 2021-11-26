import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanGetDashboard.dart' as res;
import 'package:kitchen/model/BeanSignUp.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BeanSignUp userBean;
  var name="";
  var menu="";
  var kitchenId="";
  var active_orders="";
  var upcoming_orders="";
  var pending_orders="";
  var completed_orders="";
  var active_deliveries="";
  var ready="";
  var preparing="";
  var out_for_delivery="";
  var loss="";
  var profit="";
  List<res.Data> data=[];

  ProgressDialog progressDialog;


  void getUser() async {
    userBean  = await Utils.getUser();
    name=userBean.data.kitchenname;
    menu=userBean.data.menuFile;
    kitchenId=userBean.data.kitchenid.toString();
    setState(() {

    });
  }

  @override
  void initState() {
    getUser();
    super.initState();

    Future.delayed(Duration.zero, () {

      getDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog=ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        backgroundColor: AppConstant.appColor,
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 120),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(38),
                      topLeft: Radius.circular(38))),
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(12),
                          height: 100,
                          width: 98,
                          decoration: BoxDecoration(
                              color: Color(0xffFFF700), shape: BoxShape.circle),
                          child: Center(
                            child: Container(
                              width: 90,
                              height: 100,
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(menu),
                                backgroundColor: Colors.transparent,

                              ),
                            )
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Name of Kitchen",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: AppConstant.fontBold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                  color: Color(0xffA7A8BC),
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontRegular),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              margin: EdgeInsets.only(left: 16, top: 16),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              child: Container(
                                height: 110,
                                width: 70,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      active_orders.toString(),
                                      style: TextStyle(
                                          color: Color(0xffBEE8FF),
                                          fontSize: 30,
                                          fontFamily: AppConstant.fontBold),
                                    ),
                                    Text(
                                      "Active\nOrders",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: AppConstant.fontRegular),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              margin: EdgeInsets.only(left: 16, top: 16),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              child: Container(
                                height: 110,
                                width: 70,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      upcoming_orders.toString(),
                                      style: TextStyle(
                                          color: Color(0xffFEDF7C),
                                          fontSize: 30,
                                          fontFamily: AppConstant.fontBold),
                                    ),
                                    Text(
                                      "Upcoming\n   Orders",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: AppConstant.fontRegular),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              margin: EdgeInsets.only(left: 16, top: 16),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              child: Container(
                                height: 110,
                                width: 70,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      pending_orders.toString(),
                                      style: TextStyle(
                                          color: Color(0xffFCA896),
                                          fontSize: 30,
                                          fontFamily: AppConstant.fontBold),
                                    ),
                                    Text(
                                      "Pending\nOrders",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: AppConstant.fontRegular),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              margin: EdgeInsets.only(left: 16, top: 16),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Container(
                                height: 110,
                                width: 70,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      completed_orders.toString(),
                                      style: TextStyle(
                                          color: Color(0xffBEE8FF),
                                          fontSize: 30,
                                          fontFamily: AppConstant.fontBold),
                                    ),
                                    Text(
                                      "Completed\n   Orders",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: AppConstant.fontRegular),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16, top: 16),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            Res.ic_pan,
                            width: 120,
                            height: 120,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Text(
                              "Active\nDeliveries",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              active_deliveries.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Image.asset(
                              Res.ic_back,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10, top: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xffBEE8FF),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: Text(
                                  "Preparing "+preparing.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xff7EDABF),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: Text(
                                  "Ready "+ready.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xffFEDF7C),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                  child: Text(
                                "Out for Delivery "+out_for_delivery.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontFamily: AppConstant.fontRegular),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 26),
                      child: Text(
                        "Earning Reports",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 26),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 1, top: 16),
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Color(0xffF3F6FA),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: CircularPercentIndicator(
                                  radius: 100.0,
                                  lineWidth: 10.0,
                                  percent: 0.5,
                                  center: Text(
                                    profit+"%"+"\nProfit",
                                    style: TextStyle(
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                  backgroundColor: Colors.white,
                                  progressColor: Color(0xff7EDABF),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 11, top: 16),
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Color(0xffF3F6FA),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: CircularPercentIndicator(
                                  radius: 100.0,
                                  lineWidth: 10.0,
                                  percent: 0.2,
                                  center: Text(
                                    loss+"%"+"\nLoss",
                                    style: TextStyle(
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                  backgroundColor: Colors.white,
                                  progressColor: Color(0xffFCA896),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 26),
                      child: Text(
                        "Sales Overview",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 16),
                      height: 270,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Image.asset(Res.ic_graph),
                      )),
                    ),
                  ],
                ),
                physics: BouncingScrollPhysics(),
              ),
            ),
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
                  Expanded(
                    child: Text(
                      "Dashboard",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: AppConstant.fontBold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Image.asset(
                      Res.ic_notification,
                      width: 25,
                      height: 25,
                    ),
                  )
                ],
              ),
              height: 150,
            ),
          ],
        )
        /*    appBar: AppBar(
          elevation: 0,
            backgroundColor: Colors.orange,
            leading:Row(
              children: [
                IconButton(
                  icon: ImageIcon(
                    AssetImage(
                      'assets/images/ic_menu.png',
                    ),
                    color: Colors.white,
                  ), onPressed: () {
                  setState(() {
                    _scaffoldKey.currentState.openDrawer();
                  });
                },
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text("Dashboard",style: TextStyle(color: Colors.white,fontSize: 30,fontFamily: AppConstant.fontBold),),
                  ),
                ),
                Image.asset(Res.ic_back)

              ],
            )
        )*/
        );
  }

  Future<res.BeanGetDashboard> getDashboard() async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": kitchenId,
        "token": "123456789"
      });
      res.BeanGetDashboard bean = await ApiProvider().beanGetDashboard(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {

        if(bean.data!=null){
           active_orders=bean.data.activeOrders.toString();
           upcoming_orders=bean.data.upcomingOrders.toString();
           pending_orders=bean.data.pendingOrders.toString();
           completed_orders=bean.data.completedOrders.toString();
           active_deliveries=bean.data.activeDeliveries.toString();
           ready=bean.data.ready.toString();
           preparing=bean.data.preparing.toString();
           out_for_delivery=bean.data.outForDelivery.toString();
           loss=bean.data.loss.toString();
           profit=bean.data.profit.toString();
         }

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
