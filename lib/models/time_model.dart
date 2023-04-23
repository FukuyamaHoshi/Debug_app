import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../stores/store.dart';

class TimeModel with ChangeNotifier {
  bool isStopTime = false; // タイマーのストップフラグ
  int _count = 0; // 加算するタイマー

  // タイマー開始
  void startTimer() {
    isStopTime = false; // タイマー終了フラグを切り替える

    Timer.periodic(
      // 第一引数：繰り返す間隔の時間を設定
      const Duration(seconds: 1),
      (Timer timer) {
        //タイマー終了処理
        if (isStopTime) {
          timer.cancel();
          return;
        }

        _count++; // 加算
      },
    );
  }

  // タイマー終了
  void stopTimer() {
    isStopTime = true;

    Store.time = _intToTimeFormat(_count); // タイマーに値を入れる
    _count = 0; // リセット
  }

  // int(秒数)をhh:mm:ssへ変換する
  String _intToTimeFormat(int i) {
    int h, m, s; // 時、分、秒
    // ~/は余りの商の部分
    h = i ~/ 3600; // 時
    m = ((i - h * 3600)) ~/ 60; // 分
    s = i - (h * 3600) - (m * 60); // 秒
    // 一桁だったら先頭に0を追加
    String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();
    String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

    return "$minuteLeft:$secondsLeft";
  }
}
