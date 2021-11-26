import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanSignUp.dart'as bean;
import 'package:kitchen/model/GetorderHistory.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';

class OrdersHistory extends StatefulWidget {
  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}


class _OrdersHistoryState extends State<OrdersHistory> {
  Future future;
  var kitchenId="";
  bean.BeanSignUp userBean;
  List<OrderHistory> orders=[];

  var booked="";
  var paid="";
  var cancelled="";
  var total_sales="";
  var projected_sales_tomorrow="";



  void getUser() async {
    userBean  = await Utils.getUser();
    kitchenId=userBean.data.kitchenid.toString();


    setState(() {

    });
  }
  @override
  void initState() {
    getUser();
    super.initState();
    Future.delayed(Duration.zero, () {
      future = getorderHistory(context);

    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 210,
                margin: EdgeInsets.only(left: 16,right: 16,top: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color(0xffF3F6FA)
                ),
                child: Column(
                  children: [
                    Row(
                      children: [

                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                booked,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16,top: 8),
                              child: Text(
                                "Booked",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: AppConstant.fontRegular),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                paid,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16,top: 8),
                              child: Text(
                                "Paid",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: AppConstant.fontRegular),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  cancelled,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16,top: 8),
                                child: Text(
                                  "Cancelled",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Image.asset(Res.ic_order_history,width: 100,height: 120,fit: BoxFit.cover,)
                        ),

                      ],
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            "Today's Sales",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: AppConstant.fontRegular),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            AppConstant.rupee+total_sales,
                            style: TextStyle(
                                color:AppConstant.lightGreen,
                                fontSize: 18,
                                fontFamily: AppConstant.fontBold),
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
                          child: Text(
                            "Project Sales for Tomorow",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: AppConstant.fontRegular),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            AppConstant.rupee+projected_sales_tomorrow,
                            style: TextStyle(
                                color:AppConstant.appColor,
                                fontSize: 18,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              orders.isEmpty?Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ):ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return getOrderList(orders[index]);
                },
                itemCount: orders.length,
              ),
            ],
          ),

          physics: BouncingScrollPhysics(),
        )
    );
  }

  Widget getOrderList(OrderHistory order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only( left:10,top: 10),
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
                        child:Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 1),
                              child: Text(
                                order.customerName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ),

                          ],
                        )
                    ),

                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    order.orderDate,
                    style: TextStyle(
                        color: Colors.black,
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
                      child: Text(
                        "Weekly Plan",
                        style: TextStyle(
                            color: Color(0xffA7A8BC),
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "Monthly Plan",
                        style: TextStyle(
                            color: Color(0xffA7A8BC),
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10,top: 6),
                      child: Image.asset(Res.ic_breakfast,width: 16,height: 16,)
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        order.weeklyPlan,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 16,top: 6),
                        child: Image.asset(Res.ic_dinner,width: 16,height: 16,)
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        order.monthlyPlan,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
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
                      padding: EdgeInsets.only(left: 16,top: 10),
                      child: Image.asset(
                        Res.ic_loc,
                        width: 20,
                        height: 20,
                        color: AppConstant.lightGreen,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, top: 10),
                      child: Text(
                        order.deliveryAddress,
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

              ],
            ),
          ],
        )
      ],
    );
  }

  Future<GetorderHistory> getorderHistory(BuildContext context) async {
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": kitchenId.toString(),
        "token": "123456789",
        "filter_fromdate": "",
        "filter_todate": "",
        "filter_order_number": ""

      });
      GetorderHistory bean = await ApiProvider().getOrderHistory(from);
      print(bean.data);
      if (bean.status == true) {
         booked=bean.data.booked.toString();
         paid=bean.data.paid.toString();
         cancelled=bean.data.cancelled.toString();
         total_sales=bean.data.totalSales;
         projected_sales_tomorrow=bean.data.projectedSalesTomorrow;

        orders=bean.data.orderHistory;



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


}
