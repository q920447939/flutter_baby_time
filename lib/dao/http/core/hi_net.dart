import 'dart:developer';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../handle/token_manager/token_manager.dart';
import '../../../main.dart';
import '../../../widget/smart_dialog/smart_dialog_helper.dart';
import '../request/base_request.dart';
import 'dio_hi_net_adapter.dart';
import 'hi_error.dart';
import 'hi_net_response.dart';

class HiNet {
  static late HiNet _instance = HiNet._();

  HiNet._() {
    // no access to _instance here
  }

  static HiNet getInstance() {
    return _instance;
  }

  Future<dynamic> fire(BaseRequest baseRequest,
      {bool showLoading = true}) async {
    HiNetResponse? response;
    try {
      if (showLoading) {
        dialogLoading(displayTime: const Duration(seconds: 1));
      }
      response = await send(baseRequest);
      if (showLoading) {
        SmartDialog.dismiss(); // 移除await
      }
      if (200 == response.statusCode) {
        var result = response.data;
        if (null != result['code']) {
          var code = result['code'];
          if (code == 441 ||
              code == 442 ||
              code == 42100010 ||
              code == 50007 ||
              code == 50008) {
            loginOut();
            await SmartDialog.showNotify(
                msg: '登录已过期,请重新登录！', notifyType: NotifyType.failure);
            return;
          }
          if (code != 0) {
            dialogFailure(result['msg']);
            return null;
          }
        }
        return response.data['data'];
      } else {
        await SmartDialog.showNotify(
            msg: '服务器正忙,请稍后再试！', notifyType: NotifyType.failure);
      }
    } catch (e) {
      await SmartDialog.showNotify(
          msg: '网络异常,请稍后再试！', notifyType: NotifyType.failure);
      return null;
    }
  }

  Future<HiNetResponse> send<T>(BaseRequest baseRequest) async {
    if (baseRequest.needToken()) {
      //baseRequest.addHead("token", SP.getString('token') ?? '');
      baseRequest.addHead("token", '84d76b59-5972-4344-8151-685d449c0f37');
    }
    return await DioHiNetAdapter().send(baseRequest);
  }
}
