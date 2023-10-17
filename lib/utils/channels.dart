import 'package:flutter/services.dart';

class ChannelMethod {
  static const platform = MethodChannel(MethodName.paymentChannel);
}

class MethodName {
  static const initializeZlConfig = 'zalo_init';
  static const payByZalo = 'zalo_pay';
  static const paymentChannel = 'com.tma.core_function/payment';
}
