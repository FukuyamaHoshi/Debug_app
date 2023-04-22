import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../stores/store.dart';

class TimeModel with ChangeNotifier {
  bool isStopTime = false; // タイマーのストップフラグ

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

        Store.time++; // 加算
      },
    );
  }

  // タイマー終了
  void stopTimer() {
    isStopTime = true;
  }
}
