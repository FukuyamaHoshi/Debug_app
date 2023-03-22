import 'package:debug_app/model.dart';
import 'package:debug_app/result_page.dart';
import 'package:debug_app/words.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'couse_page.dart';
import 'package:highlight_text/highlight_text.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider model
    final Model model = Provider.of<Model>(context, listen: true);
    // スクリーンの高さ
    final double screeHeight = MediaQuery.of(context).size.height;

    // もんだい数に応じて画面推移
    void nextNavigation() {
      // 次のもんだいへ
      model.nextQuestion();

      // 現在の問題数に応じて処理
      if (model.currentQuestion < model.questionCount) {
        // もんだいを設定
        model.setQuestion();

        // もんだい画面へ
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const QuestionPage()));
      } else {
        model.stopTimer(); // タイマーを止める
        // 結果画面へ
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResultPage()));
      }
    }

    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: Text(
          'codegen',
          style: GoogleFonts.zenMaruGothic(
              textStyle: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: fromCssColor('#ffffff'))),
        ),
        backgroundColor: fromCssColor('#96D6AE'),
        elevation: 0,
        automaticallyImplyLeading: false, // もどるボタンを許可しない
        // おわるボタン設置
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                // ポップアップ
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: fromCssColor('#F4F2E4'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    icon: Container(
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 35,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    iconColor: fromCssColor('#77694A'),
                    iconPadding: const EdgeInsets.all(10.0),
                    title: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'もんだいを終わりますか？',
                        style: GoogleFonts.zenMaruGothic(
                            textStyle: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#4E3703'))),
                      ),
                    ),
                    content: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        'もんだいの途中で終わると\n結果がでません。',
                        style: GoogleFonts.zenMaruGothic(
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#77694A'))),
                      ),
                    ),
                    actions: [
                      // ボタン
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            // はいボタン
                            SizedBox(
                              height: 65,
                              width: 250,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.white, width: 4),
                                  backgroundColor: fromCssColor('#90CCC9'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: Text(
                                  'はい',
                                  style: GoogleFonts.zenMaruGothic(
                                      textStyle: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: fromCssColor('#ffffff'))),
                                ),
                                onPressed: () {
                                  // コース画面へ
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CousePage(),
                                      fullscreenDialog: true, // 下からのアニメーション
                                    ),
                                  );
                                  model.stopTimer(); // タイマーを止める
                                },
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 5.0)),

                            // いいえボタン
                            SizedBox(
                              height: 65,
                              width: 250,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      fromCssColor('#D9CCAB')),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50), //丸み具合
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'いいえ',
                                  style: GoogleFonts.zenMaruGothic(
                                      textStyle: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: fromCssColor('#4E3703'))),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 5.0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                'おわる',
                style: GoogleFonts.mPlusRounded1c(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: fromCssColor('#ffffff'))),
              ),
            ),
          )
        ],
      ),
      backgroundColor: fromCssColor('#F4F2E4'),

      // 出題ボックス
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 430,
            color: fromCssColor('#EAE3C9'),
            alignment: Alignment.topCenter,
            child: Column(children: [
              const Padding(padding: EdgeInsets.only(top: 10)),

              // もんだいテキスト
              Text(
                'もんだい',
                style: GoogleFonts.zenMaruGothic(
                    textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: fromCssColor('#4E3703'))),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),

              // もんだい文ボックス
              Container(
                color: Colors.red,
                child: Container(
                  width: 380,
                  height: 80,
                  color: fromCssColor('#F4F2E4'),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),

                    // もんだい分を表示
                    child: Text(
                      // 取得したもんだい文を表示
                      model.question,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#77694A'))),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),

              // エディターの上タブ
              Container(
                width: 420,
                height: 30,
                color: fromCssColor('#343541'),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'javascript',
                    style:
                        TextStyle(color: fromCssColor('#ffffff'), fontSize: 14),
                  ),
                ),
              ),

              // エディター
              Container(
                width: 420,
                height: 250,
                color: fromCssColor('#0F161F'),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),

                      // コードを表示
                      child: TextHighlight(
                        text: model.code,
                        words: words,
                        textStyle: GoogleFonts.robotoMono(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#ffffff'))),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),

          // 答えのサブタイトル
          if (screeHeight > 850) // SEの場合は表示しない(レスポンシブ対応)
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 20.0),
                child: Text(
                  'どれが答え？',
                  style: GoogleFonts.zenMaruGothic(
                      textStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: fromCssColor('#4E3703'))),
                ),
              ),
            ),
          const Padding(padding: EdgeInsets.only(top: 10.0)),

          // 選択肢A
          GestureDetector(
            onTap: () {
              model.checkCollect(0); // 正解しているかどうか
              nextNavigation();
            },
            child: Stack(alignment: Alignment.center, children: [
              // 外
              Container(
                width: 400,
                height: 85,
                decoration: BoxDecoration(
                    color: fromCssColor('#BCDF8A'),
                    borderRadius: BorderRadius.circular(5)),
              ),

              // 内
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // アルファベットボックス
                  Container(
                    width: 45,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: fromCssColor('#80C03A'),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'A',
                      style: GoogleFonts.zenMaruGothic(
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#BCDF8A'))),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 8.0)),

                  // 選択肢文ボックス
                  Container(
                    width: 330,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: fromCssColor('#F4F2E4'),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),

                      // 選択肢Aを表示
                      child: Text(
                        model.optionA,
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#4E3703'))),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
          const Padding(padding: EdgeInsets.only(top: 8.0)),

          // 選択肢B
          GestureDetector(
            onTap: () {
              model.checkCollect(1); // 正解しているかどうか
              nextNavigation();
            },
            child: Stack(alignment: Alignment.center, children: [
              // 外
              Container(
                width: 400,
                height: 85,
                decoration: BoxDecoration(
                    color: fromCssColor('#A2D0D3'),
                    borderRadius: BorderRadius.circular(5)),
              ),

              // 内
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // アルファベットボックス
                  Container(
                    width: 45,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: fromCssColor('#54A7AF'),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'B',
                      style: GoogleFonts.zenMaruGothic(
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#A2D0D3'))),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 8.0)),

                  // 選択肢文ボックス
                  Container(
                    width: 330,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: fromCssColor('#F4F2E4'),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),

                      // 選択肢Bを表示
                      child: Text(
                        model.optionB,
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#4E3703'))),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
          const Padding(padding: EdgeInsets.only(top: 8.0)),

          // 選択肢C
          GestureDetector(
            onTap: () {
              model.checkCollect(0); // 正解しているかどうか
              nextNavigation();
            },
            child: Stack(alignment: Alignment.center, children: [
              // 外
              Container(
                width: 400,
                height: 85,
                decoration: BoxDecoration(
                    color: fromCssColor('#DFA7A2'),
                    borderRadius: BorderRadius.circular(5)),
              ),

              // 内
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // アルファベットボックス
                  Container(
                    width: 45,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: fromCssColor('#C3615E'),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'C',
                      style: GoogleFonts.zenMaruGothic(
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#DFA7A2'))),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 8.0)),

                  // 選択肢文ボックス
                  Container(
                    width: 330,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: fromCssColor('#F4F2E4'),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),

                      // 選択肢Cを表示
                      child: Text(
                        model.optionC,
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#4E3703'))),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}
