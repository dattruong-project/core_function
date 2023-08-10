import 'dart:developer';
import 'dart:io';

import 'package:intl/intl.dart';

enum LogLevel { verbose, debug, info, warning, error }

class Logger {
  Logger._internal();
  static final _red = Platform.isAndroid ? '\u001b[31m' : '';
  static final _yellow = Platform.isAndroid ? '\u001b[33m' : '';
  static final _blue = Platform.isAndroid ? '\u001b[34m' : '';
  static final _magenta = Platform.isAndroid ? '\u001b[35m' : '';
  static final _cyan = Platform.isAndroid ? '\u001b[36m' : '';
  static final _reset = Platform.isAndroid ? '\u001b[0m' : '';

  static final _formatLogTime = DateFormat('yyyy-MM-dd hh:mm:ss');

  static void _log(String level, Object? object) => log('[${_formatLogTime.format(DateTime.now())}] $level $object');

  static void v(Object? object) => _log('$_yellow[Verbose]$_reset', object);

  static void d(Object? object) => _log('$_cyan[Debug]$_reset', object);

  static void i(Object? object) => _log('$_blue[Info]$_reset', object);

  static void w(Object? object) => _log('$_magenta[Warning]$_reset', object);

  static void e(Object? object) => _log('$_red[Error]$_reset', object);

}
