// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:stack_trace/stack_trace.dart';

class Log {

  static bool canLog = true;

  Log._();

  Log.info(String content) {
    _log(content, mode: _LogMode.info);
  }

  Log.error(String content) {
    _log(content, mode: _LogMode.error);
  }

  Log.debug(String content) {
    _log(content, mode: _LogMode.debug);
  }

  Log.warning(String content) {
    _log(content, mode: _LogMode.warning);
  }

  _getTrace() {
    try {
      Chain chain = Chain.forTrace(StackTrace.current);
      final frames = chain.toTrace().frames;
      final frame = frames[3];
      return frame.toString();
    } catch (e) {
      return "__**__";
    }
  }

  _log(String content, {_LogMode mode = _LogMode.info}) {

    if(!Log.canLog) return;

    String prefix = '';
    switch(mode) {
      case _LogMode.info:
        prefix = '🌕INFO: ';
        break;
      case _LogMode.error:
        prefix = '❌ERROR: ';
        break;
      case _LogMode.warning:
        prefix = '❗WARNING: ';
        break;
      case _LogMode.debug:
        prefix = '🎾DEBUG : ';
        break;
    }

    String suffix = _getTrace();

    debugPrint(prefix + content + "\nLOG调用位置：" + suffix);
  }

}

enum _LogMode {
  info,
  error,
  warning,
  debug
}