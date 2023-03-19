import 'dart:async';
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
  int collect = 0; // 正解したもんだい数
  int time = 0; // タイマー
  bool isStopTime = false; // タイマーのストップフラグ

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

  // 現在のもんだい数をリセット
  void resetQuestion() {
    nums = []; // 取得するもんだい番号
    count = 0; // もんだいカウント
    ques = []; // Questionクラスの配列
    collect = 0; // 正解したもんだい数
    time = 0; // タイマー
    isStopTime = false; // タイマーストップフラグ
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
  Future<void> getQuestionsData() async {
    final docRef = db.collection(qc);
    // 取得した番号配列を指定( ここのawaitを書かないと処理を待ってくれない )
    await docRef.where("number", whereIn: nums).get().then(
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
        // for (var q in ques) {
        //   debugPrint(q.answer.toString());
        // }
        debugPrint('Firebase呼ばれた');
      },
      onError: (e) {
        debugPrint("Error completing: $e");
      },
    );
  }

  // もんだいの配列にデータ追加
  void addQuestions(int a, String code, int num, String oA, String oB,
      String oC, String que) {
    Question q = Question(a, code, num, oA, oB, oC, que);

    ques.add(q);
  }

  // 正解しているか確認する
  void checkCollect(int select) {
    if (ques.isEmpty) return; // 何もしない
    if (select > 2) return; // 何もしない(選択肢は0~2の間)

    // 正解していたらカウント
    if (select == ques[count].answer) {
      collect++;
    }
  }

  // 正答率を計算し、取得する
  int getCollectRate() {
    int rate = (collect / maxCount * 100).toInt();
    return rate;
  }

  // タイマー開始
  void startTimer() {
    Timer.periodic(
      // 第一引数：繰り返す間隔の時間を設定
      const Duration(seconds: 1),
      (Timer timer) {
        // タイマー終了処理
        if (isStopTime) {
          timer.cancel();
          return;
        }

        time++; // 加算
      },
    );
  }

  // タイマー終了
  void stopTimer() {
    isStopTime = true;
  }
}
