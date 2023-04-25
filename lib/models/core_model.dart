import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_app/question.dart';
import 'package:debug_app/stores/store.dart';
import 'package:debug_app/words.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreModel with ChangeNotifier {
  // Firebase
  final FirebaseFirestore db = FirebaseFirestore.instance; // Firebaseデータベース
  final String qc = 'questions'; // もんだいコレクション名前
  // 問題設定
  int currentQuestionNum = 0; // 現在何問目か(0 ~ 4の配列)
  List<int> questionNums = <int>[]; // もんだい番号のリスト( ※10個まで Firebaseの仕様)
  // 穴埋め設定
  String blankA = ''; // 穴埋めAのテキスト
  String blankB = ''; // 穴埋めBのテキスト
  final List<String> _blankColors = ['#EAEAEA', '#34424D']; // 穴埋めの色
  final List<String> _blankOutlineColors = [
    '#EAEAEA',
    '#C7C7C7'
  ]; // 穴埋めのアウトラインの色
  final List<double?> _blankWidths = [65, null]; // 穴埋めの幅
  int isBlankAInt = 0; // 0が空白、1が内容がある(穴埋めの)
  int isBlankBInt = 0; // 0が空白、1が内容がある(穴埋めの)
  bool isBlankAScorp = true; // どちらの穴埋めにテキストが入るか
  // 表示するデータ
  String question = ''; // 問題文
  String code = ''; // コード
  String optionA = ''; // 選択肢A
  String optionB = ''; // 選択肢B
  String optionC = ''; // 選択肢C
  String optionD = ''; // 選択肢D
  // 永続化するデータ
  String playNumber = ""; // プレイ数

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
    Store.questions = []; // Questionクラスの配列
    Store.corrects = []; // 正誤配列
  }

  // もんだいを設定する
  void setQuestion() {
    // 配列が空　か　問題数が出題数を超えている(一応)
    if (Store.questions.isEmpty || currentQuestionNum > Store.questionCount) {
      debugPrint("もんだいが取得できていない");
    } else {
      // 取得できている時、
      question = Store.questions[currentQuestionNum].question;
      code = Store.questions[currentQuestionNum].code;
      optionA = Store.questions[currentQuestionNum].optionA;
      optionB = Store.questions[currentQuestionNum].optionB;
      optionC = Store.questions[currentQuestionNum].optionC;
      optionD = Store.questions[currentQuestionNum].optionD;
    }
  }

  // ****************************************************
  // データの取得
  // ****************************************************
  // 取得する問題を５つ(出題数)決定し、リストに追加
  void getQuestionsNum() {
    while (true) {
      // 出題数がFirebase内の問題より少なかったら終了
      if (Store.questionCount < Store.total) break;

      // 配列が出題数以上になれば終了
      if (questionNums.length >= Store.questionCount) break;

      var r = Random().nextInt(Store.total); // ランダムな数字生成(データベースの問題数に応じて)
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
          Store.questions.add(q);
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
        Store.total = res.size;
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }

  // ****************************************************
  // エディターの設定
  // ****************************************************
  // コードをWidgetへ変換(答えを表示したい時はquestionsの番号を入力)
  List<Widget> setCodeWidget([int? num]) {
    List<List<String>> codes = []; // コード配列
    int brankCount = 1; // ブランクカウンター
    List<Widget> codeWidgets = []; // コードのwidget配列
    blankA = ''; // 空にする
    blankB = ''; // 空にする
    isBlankAInt = 0; // リセット
    isBlankBInt = 0; // リセット
    isBlankAScorp = true; // リセット

    // 改行するコードを分割する(nnn)
    List<String> nSplits = Store
        // ignore: prefer_if_null_operators
        .questions[num == null ? currentQuestionNum : num]
        .code
        .split("nnn");

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
                  width: _blankWidths[num == null ? isBlankAInt : 1],
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: fromCssColor(_blankOutlineColors[
                            num == null ? isBlankAInt : 1])),
                    borderRadius: BorderRadius.circular(5),
                    color: fromCssColor(
                        _blankColors[num == null ? isBlankAInt : 1]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      num == null
                          ? context.select((CoreModel m) => m.blankA)
                          : Store.questions[num].answerA,
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
              blankA = data; // データをテキストへ
              isBlankAInt = 1; // 穴埋めの色と幅を変更
              isBlankAScorp = false; // スコープをBlankBへ
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
                  width: _blankWidths[num == null ? isBlankBInt : 1],
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: fromCssColor(_blankOutlineColors[
                            num == null ? isBlankBInt : 1])),
                    borderRadius: BorderRadius.circular(5),
                    color: fromCssColor(
                        _blankColors[num == null ? isBlankBInt : 1]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      num == null
                          ? context.select((CoreModel m) => m.blankB)
                          : Store.questions[num].answerB,
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
              blankB = data; // データをテキストへ
              isBlankBInt = 1; // 穴埋めの色と幅を変更
              isBlankAScorp = true; // スコープをBlankAへ
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

    return codeWidgets;
  }

  // 選択肢を穴埋めに入力する
  void enterTextInBlank(String t) {
    if (isBlankAScorp) {
      // １つ目の穴埋め
      blankA = t;
      isBlankAInt = 1; // 穴埋めの色を変更
    } else {
      // ２つ目の穴埋め
      blankB = t;
      isBlankBInt = 1; // 穴埋めの色を変更
    }

    isBlankAScorp = !isBlankAScorp; // フラグ切り替え

    notifyListeners(); // UIを更新する
  }

  // ****************************************************
  // 正誤判定
  // ****************************************************
  // 正誤判定し配列に結果を追加する
  void addCorrects() {
    if (Store.questions.isEmpty) return; // 何もしない

    // 正解判定
    if (Store.questions[currentQuestionNum].answerA == blankA &&
        Store.questions[currentQuestionNum].answerB == blankB) {
      // 正解
      Store.corrects.add(true);
    } else {
      // 不正解
      Store.corrects.add(false);
    }
  }

  // 正解率を設定する
  void setCorrectRate() {
    int correctNum = Store.corrects.where((bool c) => c == true).length; // 正解数
    int questionNum = Store.questionCount; // 出題数

    Store.correctRate = "$correctNum/$questionNum"; // セット
  }

  // 正誤アイコンを設定する
  Icon setCorrectIcon(int num) {
    if (Store.corrects[num] == true) {
      // 正解
      return Icon(
        Icons.check,
        color: fromCssColor('#49DB49'),
        size: 40,
      );
    }
    // 不正解
    return Icon(
      Icons.close,
      color: fromCssColor('#F04565'),
      size: 40,
    );
  }

  // ****************************************************
  // データ永続化
  // ****************************************************
  // プレイ数をセットする
  Future<void> setPlayNumber() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); // インスタンス
    int? n = prefs.getInt("play_number"); // プレイ数を取得
    // 永続化処理
    if (n == null) {
      // 初回時
      prefs.setInt("play_number", 1);
    } else {
      // 初回以上
      n++; // 回数増やす
      prefs.setInt("play_number", n);
    }
  }

  // プレイ数を取得する
  Future<void> getPlayNumber() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); // インスタンス
    int? n = prefs.getInt("play_number"); // プレイ数を取得
    // 永続化処理
    if (n == null) {
      // 初回時
      playNumber = "0";
    } else {
      // 初回以上
      playNumber = "$n";
    }

    notifyListeners(); // UI更新
  }
}
