import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_app/question.dart';
import 'package:debug_app/words.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:provider/provider.dart';

class Model with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance; // Firebaseデータベース
  final String qc = 'questions'; // もんだいコレクション名前
  final int questionCount = 3; // 出題数
  final List<String> ranks = [
    // 全てのランク
    'ペリドット・ニュービー ',
    'アメジスト・アマチュア',
    'ガーネット・プロ',
    'トルマリン・エキスパート',
    'サファイア・エリート',
    'ルビー・マスター',
    'エメラルド・プリンス',
    'ダイヤモンド・キング'
  ];

  int total = 3; // すべての問題数(Firebase内の)
  int collectRate = 0; // 正答率
  int currentQuestionNum = 0; // 現在何問目か(0 ~ 4の配列)
  List<int> questionNums = <int>[]; // もんだい番号のリスト( ※10個まで Firebaseの仕様)
  List<Question> questions = <Question>[]; // もんだいのデータのリスト
  int collectNum = 0; // 正解したもんだい数
  int time = 0; // タイマー
  bool isStopTime = false; // タイマーのストップフラグ
  String brankA = ''; // 穴埋めAのテキスト
  String brankB = ''; // 穴埋めBのテキスト
  List<String> brankColors = ['#EAEAEA', '#34424D']; // 穴埋めの色
  List<String> brankOutlineColors = ['#EAEAEA', '#C7C7C7']; // 穴埋めのアウトラインの色
  List<double?> blankWidths = [65, null]; // 穴埋めの幅
  int isBrankAInt = 0; // 0が空白、1が内容がある(穴埋めの)
  int isBrankBInt = 0; // 0が空白、1が内容がある(穴埋めの)
  bool isBrankAScorp = true; // どちらの穴埋めにテキストが入るか

  // 問題文
  String question = '';
  // コード
  String code = '';
  // コードのwidget配列
  List<Widget> codeWidgets = [];
  // 選択肢A
  String optionA = '';
  // 選択肢B
  String optionB = '';
  // 選択肢C
  String optionC = '';
  // 選択肢D
  String optionD = '';

  // ****************************************************
  // もんだいの設定
  // ****************************************************
  // 次のもんだいへ
  void nextQuestion() {
    currentQuestionNum++;
  }

  // 現在のもんだい数をリセット
  void resetQuestion() {
    questionNums = []; // 取得するもんだい番号
    currentQuestionNum = 0; // もんだいカウント
    questions = []; // Questionクラスの配列
    collectNum = 0; // 正解したもんだい数

    time = 0; // タイマー
  }

  // もんだいを設定する
  void setQuestion() {
    // 配列が空　か　問題数が出題数を超えている(一応)
    if (questions.isEmpty || currentQuestionNum > questionCount) {
      debugPrint("もんだいが取得できていない");
    } else {
      // 取得できている時、
      question = questions[currentQuestionNum].question;
      code = questions[currentQuestionNum].code;
      optionA = questions[currentQuestionNum].optionA;
      optionB = questions[currentQuestionNum].optionB;
      optionC = questions[currentQuestionNum].optionC;
      optionD = questions[currentQuestionNum].optionD;
    }
  }

  // 取得する問題を５つ(出題数)決定し、リストに追加
  void getQuestionsNum() {
    while (true) {
      // 出題数がFirebase内の問題より少なかったら終了
      if (questionCount < total) break;

      // 配列が出題数以上になれば終了
      if (questionNums.length >= questionCount) break;

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
          Question q = Question(
              doc.data()['question'],
              doc.data()['code'],
              doc.data()['optionA'],
              doc.data()['optionB'],
              doc.data()['optionC'],
              doc.data()['optionD'],
              doc.data()['answerA'],
              doc.data()['answerB'],
              doc.data()['number']);
          questions.add(q);
        }

        debugPrint('get Firebase data');
      },
      onError: (e) {
        debugPrint("Error completing: $e");
      },
    );
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

  // コードをWidgetへ変換
  void comvertCodeToWidget() {
    List<List<String>> codes = []; // コード配列
    int brankCount = 1; // ブランクカウンター
    codeWidgets = []; // 空にする
    brankA = ''; // 空にする
    brankB = ''; // 空にする
    isBrankAInt = 0; // リセット
    isBrankBInt = 0; // リセット
    isBrankAScorp = true; // リセット

    // 改行するコードを分割する(nnn)
    List<String> nSplits = questions[currentQuestionNum].code.split("nnn");

    // 穴抜きとコードを分割する(|||)
    for (int i = 0; i < nSplits.length; i++) {
      codes.add(nSplits[i].split("|||")); // |||で分割し、穴埋めのところは***が残るだけ
    }

    // codesをwidgetに変換
    for (int i = 0; i < codes.length; i++) {
      List<Widget> widgetArray = [];
      for (int v = 0; v < codes[i].length; v++) {
        String contentCodes = codes[i][v].trim(); // ２次元配列のテキスト(前後の空白の削除)

        // 1つ目の***の場合(穴埋め１)
        if (contentCodes == "***" && brankCount == 1) {
          Widget c = DragTarget(
            builder: (context, accepted, rejected) {
              return Padding(
                padding: const EdgeInsets.only(left: 3, right: 3),
                child: Container(
                  alignment: Alignment.center,
                  width: blankWidths[isBrankAInt],
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: fromCssColor(brankOutlineColors[isBrankAInt])),
                    borderRadius: BorderRadius.circular(5),
                    color: fromCssColor(brankColors[isBrankAInt]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      context.watch<Model>().brankA,
                      maxLines: 1,
                      style: GoogleFonts.robotoMono(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#B6C5CA'))),
                    ),
                  ),
                ),
              );
            },
            onAccept: (String data) {
              brankA = data; // データをテキストへ
              isBrankAInt = 1; // 穴埋めの色と幅を変更
              isBrankAScorp = false; // スコープをBlankBへ
            },
          );
          brankCount++; // 穴埋めをカウント

          widgetArray.add(c);
        }

        // 2つ目の***の場合(穴埋め１)
        else if (contentCodes == "***" && brankCount == 2) {
          Widget c = DragTarget(
            builder: (context, accepted, rejected) {
              return Padding(
                padding: const EdgeInsets.only(left: 3, right: 3),
                child: Container(
                  alignment: Alignment.center,
                  width: blankWidths[isBrankBInt],
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: fromCssColor(brankOutlineColors[isBrankBInt])),
                    borderRadius: BorderRadius.circular(5),
                    color: fromCssColor(brankColors[isBrankBInt]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      context.watch<Model>().brankB,
                      maxLines: 1,
                      style: GoogleFonts.robotoMono(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#B6C5CA'))),
                    ),
                  ),
                ),
              );
            },
            onAccept: (String data) {
              brankB = data; // データをテキストへ
              isBrankBInt = 1; // 穴埋めの色と幅を変更
              isBrankAScorp = true; // スコープをBlankAへ
            },
          );
          brankCount++; // 穴埋めをカウント

          widgetArray.add(c);
        } else {
          // 文字がある場合(コード)
          Widget t = TextHighlight(
            text: contentCodes,
            words: words,
            textStyle: GoogleFonts.robotoMono(
                textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: fromCssColor('#ffffff'))),
          );

          widgetArray.add(t);
        }
      }

      // Rowへ変換
      Widget r = Padding(
        padding: const EdgeInsets.only(top: 3, left: 10),
        child: Row(
          children: widgetArray,
        ),
      );

      // 最終的な配列を作成
      codeWidgets.add(r);
    }
  }

  // 選択肢を穴埋めに入力する
  void enterTextInBlank(String t) {
    if (isBrankAScorp) {
      // １つ目の穴埋め
      brankA = t;
      isBrankAInt = 1; // 穴埋めの色を変更
    } else {
      // ２つ目の穴埋め
      brankB = t;
      isBrankBInt = 1; // 穴埋めの色を変更
    }

    isBrankAScorp = !isBrankAScorp; // フラグ切り替え

    notifyListeners(); // UIを更新する
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
    //if (select == questions[currentQuestionNum].answer) {
    //  collectNum++;
    //}
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
    int rateScore = 0; // 正答率のスコア(70点)
    int timeScore = 0; // タイムのスコア(30点)

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
      rateScore = 50;
    } else if (collectRate == 100) {
      // 100%
      rateScore = 70;
    }

    // タイムのスコアを設定(正答率が80%以上で)
    if (collectRate >= 80) {
      if (time <= 10) {
        // 10秒以内
        timeScore = 30;
      } else if (time <= 20) {
        // 20秒以内
        timeScore = 20;
      } else if (time <= 40) {
        // 40秒以内
        timeScore = 15;
      } else if (time <= 60) {
        // 60秒(1分)以内
        timeScore = 10;
      }
    }

    int score = rateScore + timeScore; // スコアを計算

    return score;
  }

  // ランクを設定し、取得
  String getRank(int score) {
    // スコアごとのランク
    if (score <= 19) {
      return ranks[0];
    } else if (score <= 29) {
      return ranks[1];
    } else if (score <= 49) {
      return ranks[2];
    } else if (score <= 69) {
      return ranks[3];
    } else if (score <= 79) {
      return ranks[4];
    } else if (score <= 89) {
      return ranks[5];
    } else if (score <= 99) {
      return ranks[6];
    } else {
      return ranks[7];
    }
  }
  // ****************************************************
}
