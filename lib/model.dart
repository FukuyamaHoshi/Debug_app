import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_app/question.dart';
import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance; // Firebaseデータベース
  final String qc = 'questions'; // もんだいコレクション名前
  final int questionCount = 5; // 出題数
  final List<String> ranks = [
    // 全てのランク
    'エントリー',
    'インターミディエイト',
    'アドバンスト',
    'エキスパート',
    'マスター',
    'グランドマスター'
  ];

  int total = 5; // すべての問題数(Firebase内の)
  int collectRate = 0; // 正答率
  int currentQuestion = 0; // 現在何問目か(0 ~ 4の配列)
  List<int> questionNums = <int>[]; // もんだい番号のリスト( ※10個まで Firebaseの仕様)
  List<Question> questions = <Question>[]; // もんだいのデータのリスト
  int collectNum = 0; // 正解したもんだい数
  int time = 0; // タイマー
  bool isStopTime = false; // タイマーのストップフラグ

  // 問題文
  String question = '';
  // コード
  String code = '';
  // 選択肢A
  String optionA = '';
  // 選択肢B
  String optionB = '';
  // 選択肢C
  String optionC = '';

  // ****************************************************
  // もんだいの設定
  // ****************************************************
  // 次のもんだいへ
  void nextQuestion() {
    currentQuestion++;
  }

  // 現在のもんだい数をリセット
  void resetQuestion() {
    questionNums = []; // 取得するもんだい番号
    currentQuestion = 0; // もんだいカウント
    questions = []; // Questionクラスの配列
    collectNum = 0; // 正解したもんだい数

    time = 0; // タイマー
  }

  // もんだいを設定する
  void setQuestion() {
    // 配列が空　か　問題数がさいだい問題数を超えている(一応)
    if (questions.isEmpty || currentQuestion > questionCount) {
      debugPrint("もんだいが取得できていない");
    } else {
      // 取得できている時、
      question = questions[currentQuestion].question;
      code = questions[currentQuestion].code;
      optionA = questions[currentQuestion].optionA;
      optionB = questions[currentQuestion].optionB;
      optionC = questions[currentQuestion].optionC;
    }
  }

  // 取得する問題を５つ(出題数)決定し、リストに追加
  void getQuestionsNum() {
    while (true) {
      // 配列が出題数以上になれば終了
      if (questionNums.length >= questionCount) {
        break;
      }

      var r = Random().nextInt(total); // ランダムな数字生成(データベースの問題数に応じて)
      final b = questionNums.any((int n) => n == r); // ランダムな文字が配列を一致しているか判定

      // 一致していなければ配列に追加
      if (!b) {
        questionNums.add(r);
      }
    }

    // デバッグ
    debugPrint(questionNums.toString());
  }

  // もんだいを取得し、Questionクラスを配列に格納
  Future<void> fetchQuestionsData() async {
    final docRef = db.collection(qc);
    // 取得した番号配列を指定( ここのawaitを書かないと処理を待ってくれない )
    await docRef.where("number", whereIn: questionNums).get().then(
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

        debugPrint('get Firebase data');
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

    questions.add(q);
  }

  // Firestore内の問題数を取得
  Future<void> fetchQuestionsSize() async {
    final docRef = db.collection(qc);
    await docRef.get().then(
      (res) {
        // ドキュメント数を取得
        total = res.size;
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }
  // ****************************************************

  // ****************************************************
  // 正解率
  // ****************************************************
  // 正解しているか確認する
  void checkCollect(int select) {
    if (questions.isEmpty) return; // 何もしない
    if (select > 2) return; // 何もしない(選択肢は0~2の間)

    // 正解していたらカウント
    if (select == questions[currentQuestion].answer) {
      collectNum++;
    }
  }

  // 正答率を計算する
  void calculateAccuracy() {
    int r = (collectNum / questionCount * 100).toInt();
    collectRate = r;
  }
  // ****************************************************

  // ****************************************************
  // タイマー
  // ****************************************************
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

        time++; // 加算
      },
    );
  }

  // タイマー終了
  void stopTimer() {
    isStopTime = true;
  }
  // ****************************************************

  // ****************************************************
  // ランク
  // ****************************************************
  // スコアを計算し、取得
  int getScore() {
    int rateScore = 0; // 正答率のスコア
    int timeScore = 0; // タイムのスコア

    // 正答率のスコアを設定
    if (collectRate > 0 && collectRate <= 20) {
      // 0%以上で、20%以下
      rateScore = 10;
    } else if (collectRate <= 40) {
      // 40%以下
      rateScore = 20;
    } else if (collectRate <= 60) {
      // 60%以下
      rateScore = 30;
    } else if (collectRate <= 80) {
      // 80%以下
      rateScore = 40;
    } else if (collectRate == 100) {
      // 100%
      rateScore = 50;
    }

    // タイムのスコアを設定
    if (time <= 10) {
      // 10秒以内
      timeScore = 50;
    } else if (time <= 20) {
      // 20秒以内
      timeScore = 40;
    } else if (time <= 40) {
      // 40秒以内
      timeScore = 30;
    } else if (time <= 50) {
      // 50秒以内
      timeScore = 20;
    } else if (time <= 60) {
      // 60秒(1分)以内
      timeScore = 10;
    }

    int score = rateScore + timeScore; // スコアを計算

    return score;
  }

  // ランクを設定し、取得
  String getRank(int score) {
    // スコアごとのランク
    if (score <= 20) {
      return ranks[0];
    } else if (score <= 40) {
      return ranks[1];
    } else if (score <= 70) {
      return ranks[2];
    } else if (score <= 90) {
      return ranks[3];
    } else if (score <= 99) {
      return ranks[4];
    } else {
      return ranks[5];
    }
  }
  // ****************************************************
}
