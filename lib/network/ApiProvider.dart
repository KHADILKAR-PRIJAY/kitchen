import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kitchen/Menu/menu_bean.dart';
import 'package:kitchen/model/AddOffer.dart';
import 'package:kitchen/model/BeanAddAccount.dart';
import 'package:kitchen/model/BeanAddLunch.dart';
import 'package:kitchen/model/BeanAddPackage.dart';
import 'package:kitchen/model/BeanDinnerAdd.dart';
import 'package:kitchen/model/BeanForgotPassword.dart';
import 'package:kitchen/model/BeanGetDashboard.dart';
import 'package:kitchen/model/BeanGetLunch.dart';
import 'package:kitchen/model/BeanGetOrderRequest.dart';
import 'package:kitchen/model/BeanGetPackages.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/BeanOrderAccepted.dart';
import 'package:kitchen/model/BeanPayment.dart';
import 'package:kitchen/model/BeanSaveMenu.dart';
import 'package:kitchen/model/BeanSendMessage.dart';
import 'package:kitchen/model/BeanSignUp.dart';
import 'package:kitchen/model/BeanUpdateSetting.dart';
import 'package:kitchen/model/GetAccountDetail.dart';
import 'package:kitchen/model/GetActiveOrder.dart';
import 'package:kitchen/model/GetArchieveOffer.dart';
import 'package:kitchen/model/GetChat.dart';
import 'package:kitchen/model/GetFeedback.dart';
import 'package:kitchen/model/GetLiveOffer.dart';
import 'package:kitchen/model/GetMenu.dart';
import 'package:kitchen/model/GetOrderTrialRequest.dart';
import 'package:kitchen/model/GetPayment.dart';
import 'package:kitchen/model/GetUpComingOrder.dart';
import 'package:kitchen/model/GetorderHistory.dart';
import 'package:kitchen/model/UpdateMenuDetails.dart';
import 'package:kitchen/network/EndPoints.dart';
import 'package:kitchen/utils/DioLogger.dart';

class ApiProvider {
  static const _baseUrl = "https://nohungkitchen.notionprojects.tech/api/kitchen/";
  static const String TAG = "ApiProvider";

  Dio _dio;
  DioError _dioError;

  ApiProvider() {
    BaseOptions dioOptions = BaseOptions()..baseUrl = ApiProvider._baseUrl;
    _dio = Dio(dioOptions);
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.headers = {
        'Content-Type':'multipart/form-data',
      };
      DioLogger.onSend(TAG, options);
      return options;
    }, onResponse: (Response response) {
      DioLogger.onSuccess(TAG, response);
      return response;
    }, onError: (DioError error) {
      DioLogger.onError(TAG, error);
      return error;
    }));
  }


  Future registerUser(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.register, data: params);
      return BeanSignUp.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future loginUser(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.login, data: params);
      return BeanLogin.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<BeanPayment> beanPayment(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.withdraw_payment, data: params);
      return BeanPayment.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<BeanAddAccount> beanAddAccount(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.add_account_details, data: params);
      return BeanAddAccount.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<BeanSaveMenu> beanSaveMenu(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.add_breakfast_menu, data: params);
      return BeanSaveMenu.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<BeanLunchAdd> beanLunchAdd(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.add_lunch_menu, data: params);
      return BeanLunchAdd.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanDinnerAdd> beanDinnerAdd(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.add_dinner_menu, data: params);
      return BeanDinnerAdd.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanForgotPassword> forgotPassword(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.forgot_password, data: params);
      return BeanForgotPassword.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanGetLunch> beanGetLunch(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_lunch_menu, data: params);
      return BeanGetLunch.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getArchieveOffer(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_archive_offer, data: params);
      return GetArchieveOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<BeanGetDashboard> beanGetDashboard(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_dashboard_detail, data: params);
      return BeanGetDashboard.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getFeedback(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_feedback, data: params);
      return GetFeedback.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future getMenu(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_menu, data: params);
      return MenuBean.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<BeanGetOrderRequest> getOrderRequest(FormData params) async {
    try {

      Response response = await _dio.post(EndPoints.get_orders_requests, data: params);
      return BeanGetOrderRequest.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<GetUpComingOrder> getUpComingOrder(FormData params) async {
    try {

      Response response = await _dio.post(EndPoints.get_upcoming_orders, data: params);
      return GetUpComingOrder.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<GetActiveOrder> getActiveOrder(FormData params) async {
    try {

      Response response = await _dio.post(EndPoints.get_active_orders, data: params);
      return GetActiveOrder.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<GetorderHistory> getOrderHistory(FormData params) async {
    try {

      Response response = await _dio.post(EndPoints.get_order_history, data: params);
      return GetorderHistory.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<GetOrderTrialRequest> geTrialRequest(FormData params) async {
    try {

      Response response = await _dio.post(EndPoints.get_orders_trial_requests, data: params);
      return GetOrderTrialRequest.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<BeanOrderAccepted> ordeAccept(FormData params) async {
    try {

      Response response = await _dio.post(EndPoints.accept_order, data: params);
      return BeanOrderAccepted.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<GetPayment> getPay(FormData params) async {
    try {

      Response response = await _dio.post(EndPoints.get_transaction, data: params);
      return GetPayment.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<BeanSendMessage> sendMessage(FormData params) async {
    try {

      Response response = await _dio.post(EndPoints.send_message, data: params);
      return BeanSendMessage.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<GetChat> getChat(FormData params) async {
    try {

      Response response = await _dio.post(EndPoints.get_chat, data: params);
      return GetChat.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future updateSetting(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.update_settings, data: params);
      return BeanUpdateSetting.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future updateMenuSetting(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.update_account_detail, data: params);
      return UpdateMenuDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getLiveOffers(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_live_offer, data: params);
      return GetLiveOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getPackages(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_package, data: params);
      return BeanGetPackages.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future addPackage(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.add_package, data: params);
      return BeanAddPackage.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }


  Future getAccountDetails(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_account_detail, data: params);
      return GetAccountDetails.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }


  Future addOffer(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.add_offer, data: params);
      return AddOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  void throwIfNoSuccess(String response) {
    throw new HttpException(response);
  }

}