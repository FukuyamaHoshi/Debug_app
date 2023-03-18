import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_app/question.dart';
import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance; // Firebaseデータベース
  final String qc = 'questions'; // もんだいコレクション名前
  final int questionNum = 5; // 出題数

  int count = 0; // テスト変数
  List<int> nums = <int>[]; // もんだい番号のリスト( ※10個まで Firebaseの仕様)
  List<Question> ques = <Question>[]; // もんだいのデータのリスト

  // テスト関数
  void increment() {
    count++;
    // print(count);
    notifyListeners();
  }

  // 取得する問題を５つ(出題数)決定し、リストに追加
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

      notifyListeners();
    }

    // デバッグ
    debugPrint(nums.toString());
  }

  // もんだいを取得し、Questionクラスを配列に格納
  void getQuestionsData() {
    final docRef = db.collection(qc);
    // 取得した番号配列を指定
    docRef.where("number", whereIn: nums).get().then(
      // データ操作
      (res) {
        for (var doc in res.docs) {
          addQuestions(
              doc.data()['answer'],
              doc.data()['code'],
              doc.data()['number'],
              doc.data()['optionA'],
              doc.data()['optionB'],
              doc.data()['optionC'],
              doc.data()['question']);
        }

        // デバッグ
        for (var q in ques) {
          debugPrint(q.answer);
        }

        notifyListeners();
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }

  // もんだいの配列にデータ追加
  void addQuestions(String a, String code, int num, String oA, String oB,
      String oC, String que) {
    Question q = Question(a, code, num, oA, oB, oC, que);

    ques.add(q);
  }
}
