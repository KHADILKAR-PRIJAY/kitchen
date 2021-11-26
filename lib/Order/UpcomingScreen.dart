import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanSignUp.dart' as bean;
import 'package:kitchen/model/GetUpComingOrder.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:intl/intl.dart';

class UpcomingScreen extends StatefulWidget {
  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  bean.BeanSignUp userBean;
  Future future;

  List<Data> data=[];
  var currentDate="";
  var kitchenId="";
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
    super.initState();
    Future.delayed(Duration.zero, () {
      future = getUpComingOrder(context);

    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:data.isEmpty?Center(
                child: CircularProgressIndicator(),
              ): ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return getOrderList(data[index]);
                },
                itemCount: data.length,
              ),
            ),
          ],
        ));
  }

  Widget getOrderList(Data data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only( left:10,top: 30),
              child: Image.asset(
                Res.ic_people,
                width: 60,
                height: 60,
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          data.customerName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16, top: 6),
                            child: Text(
                              data.orderDate,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontRegular),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16, top: 10),
                            child: Text(
                              "Customized ",
                              style: TextStyle(
                                  color: AppConstant.appColor,
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16, top: 10),
                            child: Text(
                              "Lunch Menu ",
                              style: TextStyle(
                                  color: Color(0xffA7A8BC),
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontRegular),
                            ),
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
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    data.orderItems,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: AppConstant.fontBold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16, top: 10),
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
                                    data.deliveryAddress,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
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
                                  margin: EdgeInsets.only(left: 16, bottom: 10),
                                  height: 45,
                                  width: 190,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 13),
                                        child: Text(
                                          "Order in Preparation",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontFamily: AppConstant.fontBold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Image.asset(
                                          Res.ic_white_arrow,
                                          width: 16,
                                          height: 16,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 1,top: 16,right: 20),
                child: Image.asset(Res.ic_call,width: 50,height: 50,)
            ),
          ],
        ),

      ],
    );
  }

  Future<GetUpComingOrder> getUpComingOrder(BuildContext context) async {
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": kitchenId.toString(),
        "token": "123456789",
        "filter_fromdate": currentDate,
        "filter_todate": "",
        "filter_order_number": ""

      });

      GetUpComingOrder bean = await ApiProvider().getUpComingOrder(from);
      print(bean.data);

      if (bean.status == true) {
         data=bean.data;
          setState(() {

          });

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {

      print(exception);
    } catch (exception) {

    }

  }

  void getCurrentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    currentDate  = formatter.format(now);
    print(currentDate);

  }
}
