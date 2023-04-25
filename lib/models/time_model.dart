import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../stores/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeModel with ChangeNotifier {
  bool _isStopTime = false; // タイマーのストップフラグ
  int _count = 0; // 加算するタイマー
  String playTime = "--"; // プレイ時間(mm:ss)
  String fastTime = "--"; // 最速時間(mm:ss)
  String averageTime = '--'; // 平均時間(mm:ss)

  // タイマー開始
  void startTimer() {
    _isStopTime = false; // タイマー終了フラグを切り替える

    Timer.periodic(
      // 第一引数：繰り返す間隔の時間を設定
      const Duration(seconds: 1),
      (Timer timer) {
        //タイマー終了処理
        if (_isStopTime) {
          timer.cancel();
          return;
        }

        _count++; // 加算
      },
    );
  }

  // タイマー終了
  void stopTimer() {
    _isStopTime = true;

    Store.time = _intToTimeFormat(_count); // タイマーに値を入れる
    _setPlayTime(_count); // 合計プレイ時間を永続化
    _setFastTime(_count); // 最速時間を永続化
    _setAverageTime(_count); // 平均時間を永続化
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

  // ****************************************************
  // データ永続化
  // ****************************************************
  // プレイ時間をセットする
  Future<void> _setPlayTime(int c) async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); // インスタンス
    int? t = prefs.getInt("play_time"); // プレイ時間を取得
    // 永続化処理
    if (t == null) {
      // 初回時
      prefs.setInt("play_time", c);
    } else {
      // 初回以上
      t += c; // 取得した時間と合計する
      prefs.setInt("play_time", t);
    }
  }

  // プレイ時間を取得する
  Future<void> getPlayTime() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); // インスタンス
    int? t = prefs.getInt("play_time"); // プレイ時間を取得
    // データ取得
    if (t != null) {
      // 初回以降
      playTime = _intToTimeFormat(t);
    }

    notifyListeners(); // UI更新
  }

  // 最速時間をセットする
  Future<void> _setFastTime(int c) async {
    int correntCount =
        Store.corrects.where((bool c) => c == true).length; // 正解数
    if (correntCount < Store.questionCount) return; // 全問正解以外はカウントしない

    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); // インスタンス
    int? f = prefs.getInt("fast_time"); // 最速時間を取得
    // 永続化処理
    if (f == null) {
      // 初回時
      prefs.setInt("fast_time", c);
    } else {
      // 初回以上
      if (c < f) prefs.setInt("fast_time", c); // 引数の方が小さい場合
    }
  }

  // 最速時間を取得する
  Future<void> getFastTime() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); // インスタンス
    int? f = prefs.getInt("fast_time"); // プレイ時間を取得
    // データ取得
    if (f != null) {
      // 初回以降
      fastTime = _intToTimeFormat(f);
    }

    notifyListeners(); // UI更新
  }

  // 平均時間をセットする
  Future<void> _setAverageTime(int c) async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); // インスタンス
    int? f = prefs.getInt("average_time"); // 平均時間を取得
    // 永続化処理
    if (f == null) {
      // 初回時
      prefs.setInt("average_time", c);
    } else {
      // 初回以降
      int average = ((f + c) / 2).floor(); // 平均タイム
      prefs.setInt("average_time", average);
    }
  }

  // 平均時間を取得する
  Future<void> getAverageTime() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); // インスタンス
    int? a = prefs.getInt("average_time"); // 平均時間を取得
    // データ取得
    if (a != null) {
      // 初回以降
      averageTime = _intToTimeFormat(a);
    }

    notifyListeners(); // UI更新
  }
}
