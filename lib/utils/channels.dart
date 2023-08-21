import 'package:flutter/services.dart';

class ChannelMethod {
  static const platform = MethodChannel('com.tma.payment');
}

class MethodName {
  static const initializeZlConfig = 'zalo_init';
  static const payByZalo = 'zalo_pay';
}
