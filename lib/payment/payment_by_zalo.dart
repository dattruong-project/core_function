import 'dart:developer';

import 'package:core_function/utils/channels.dart';

enum PaymentTransaction {
  failure, success
}

extension PaymentEnum on int {
  PaymentTransaction toPaymentEnum() {
    return this == 0 ? PaymentTransaction.failure : PaymentTransaction.success;
  }
}

class PaymentByZalo {
  PaymentByZalo._();

  static final PaymentByZalo _instance = PaymentByZalo._();

  static PaymentByZalo get instance => _instance;
  String _appId = '';
  String _env = '';
  String _macKey = '';

  Future<PaymentTransaction> pay(String amount) async {
    final int payment = await ChannelMethod.platform.invokeMethod(MethodName.payByZalo,
        {"app_id": int.parse(_appId), "env": _env, "mac_key": _macKey,"amount":amount});
    return payment.toPaymentEnum();
  }

  Future<void> init(String appId, String env, String macKey) async {
    _appId = appId;
    _env = env;
    _macKey = macKey;
  }
}
