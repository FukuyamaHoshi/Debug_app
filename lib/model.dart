import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_app/question.dart';
import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance; // Firebaseデータベース
  final String qc = 'questions'; // もんだいコレクション名前
  final int maxCount = 5; // 出題数

  int count = 0; // 現在何問目か(0 ~ 4の配列)
  List<int> nums = <int>[]; // もんだい番号のリスト( ※10個まで Firebaseの仕様)
  List<Question> ques = <Question>[]; // もんだいのデータのリスト

  // 問題文
  String question =
      '1, 以下のJavaScriptコードを実行すると、コンソールに「false」と表示されます。バグを修正して、コンソールに「true」と表示されるようにしてください。';
  // コード
  String code = 'var x = 10;\nx = x + 10;\nconsole.log(x);';
  // 選択肢A
  String optionA = 'typeof演算子で、nullの型はオブジェクトであるため、バグが発生しています。';
  // 選択肢B
  String optionB = 'typeof演算子で、nullの型はオブジェクトであるため、バグが発生しています。';
  // 選択肢C
  String optionC = 'typeof演算子で、nullの型はオブジェクトであるため、バグが発生しています。';

  // 次のもんだいへ
  void nextQuestion() {
    count++;
  }

  // もんだいを設定する
  void setQuestion() {
    // 配列が空　か　問題数がさいだい問題数を超えている(一応)
    if (ques.isEmpty || count > maxCount) {
      debugPrint("もんだいが取得できていない");
    } else {
      // 取得できている時、
      question = ques[count].question;
      code = ques[count].code;
      optionA = ques[count].optionA;
      optionB = ques[count].optionB;
      optionC = ques[count].optionC;

      // ↓↓↓画面が切り替わり、更新されるから不要
      //notifyListeners();
    }
  }

  // 取得する問題を５つ(出題数)決定し、リストに追加
  void getQuestionsNum() {
    while (true) {
      // 配列が出題数以上になれば終了
      if (nums.length >= maxCount) {
        break;
      }

      var r = Random().nextInt(5); // ランダムな数字生成
      final b = nums.any((int n) => n == r); // ランダムな文字が配列を一致しているか判定

      // 一致していなければ配列に追加
      if (!b) {
        nums.add(r);
      }
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
