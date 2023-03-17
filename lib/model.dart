import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance; // Firebaseデータベース
  final String qc = 'questions'; // もんだいコレクション名前
  final int questionNum = 5; // 出題数

  int count = 0; // テスト変数
  List<int> nums = <int>[]; // データを取得するリスト

  // テスト関数
  void increment() {
    count++;
    // print(count);
    notifyListeners();
  }

// もんだいを取得する(テスト)
  void getQuestion() {
    final docRef = db.collection(qc);
    docRef.where("number", whereIn: [1, 2]).get().then(
          (res) => print(res.docs.toString()),
          onError: (e) => print("Error completing: $e"),
        );
  }

  // 取得する問題を５つ決定し、リストにする
  void getQuestionsNum() {
    while (true) {
      // 配列が出題数以上になれば終了
      if (nums.length >= questionNum) {
        break;
      }

      var r = Random().nextInt(5); // ランダムな数字生成
      final b = nums.any((int n) => n == r); // ランダムな文字が配列を一致しているか判定

      // 一致していなければ配列に追加
      if (!b) {
        nums.add(r);
      }
    }
  }
}
