import 'package:debug_app/model.dart';
import 'package:debug_app/result_page.dart';
import 'package:debug_app/words.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'couse_page.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

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
          'スタートアップ',
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: fromCssColor('#ffffff'))),
        ),
        backgroundColor: fromCssColor('#D5BD9F'),
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
                    backgroundColor: fromCssColor('#121517'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
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
                    iconColor: fromCssColor('#ffffff'),
                    iconPadding: const EdgeInsets.all(10.0),
                    title: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'もんだいを終わりますか？',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: fromCssColor('#ffffff'))),
                      ),
                    ),
                    content: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        'もんだいの途中で終わると\n結果がでません。',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: fromCssColor('#ffffff'))),
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
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: fromCssColor('#ffffff'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'はい',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: fromCssColor('#373737'))),
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
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.white, width: 4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'いいえ',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: fromCssColor('#ffffff'))),
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
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: fromCssColor('#ffffff'))),
              ),
            ),
          )
        ],
      ),

      // 出題ボックス
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [fromCssColor('#D5BD9F'), fromCssColor('#C7DD7C')],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const [0.7, 1]),
        ),
        child: Stack(alignment: Alignment.center, children: [
          SizedBox(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 35,
                  height: double.infinity,
                  color: fromCssColor('#707070'),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                      width: 5,
                      color: fromCssColor('#31353E'),
                    )
                  ]),
                ),
                Container(
                  width: 35,
                  height: double.infinity,
                  color: fromCssColor('#707070'),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                      width: 5,
                      color: fromCssColor('#31353E'),
                    )
                  ]),
                ),
              ],
            ),
          ),
          Column(
            children: [
              if (screeHeight > 850) // SEの場合は表示しない(レスポンシブ対応)
                const Padding(padding: EdgeInsets.only(top: 20)),

              // もんだい文ボックス
              Container(
                width: 380,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        fromCssColor('#936C38'),
                        fromCssColor('#A88C66')
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0, 0.8]),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),

                  // もんだい分を表示
                  child: AutoSizeText(
                    // 取得したもんだい文を表示
                    model.question,
                    maxLines: 2,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: fromCssColor('#ffffff'))),
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
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'javascript',
                    style:
                        TextStyle(color: fromCssColor('#ffffff'), fontSize: 15),
                  ),
                ),
              ),

              // エディター
              Container(
                width: 420,
                height: 300,
                color: fromCssColor('#0F161F'),
                child: VsScrollbar(
                  isAlwaysShown: true,
                  style: VsScrollbarStyle(
                    radius: const Radius.circular(5),
                    thickness: 10.0,
                    color: fromCssColor('#ffffff'),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),

                      // コードを表示
                      child: TextHighlight(
                        text: model.code,
                        words: words,
                        textStyle: GoogleFonts.robotoMono(
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#ffffff'))),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  // 答えのサブタイトル
                  if (screeHeight > 850) // SEの場合は表示しない(レスポンシブ対応)
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'どれが答え？',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.normal,
                                color: fromCssColor('#ffffff'))),
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
                            color: fromCssColor('#936C38'),
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
                                color: fromCssColor('#A88C66'),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'A',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      color: fromCssColor('#ffffff'))),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 8.0)),

                          // 選択肢文ボックス
                          Container(
                            width: 330,
                            height: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: fromCssColor('#A88C66'),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),

                              // 選択肢Aを表示
                              child: AutoSizeText(
                                model.optionA,
                                maxLines: 2,
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        color: fromCssColor('#ffffff'))),
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
                            color: fromCssColor('#936C38'),
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
                                color: fromCssColor('#A88C66'),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'B',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      color: fromCssColor('#ffffff'))),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 8.0)),

                          // 選択肢文ボックス
                          Container(
                            width: 330,
                            height: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: fromCssColor('#A88C66'),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),

                              // 選択肢Bを表示
                              child: AutoSizeText(
                                model.optionB,
                                maxLines: 2,
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        color: fromCssColor('#ffffff'))),
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
                            color: fromCssColor('#936C38'),
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
                                color: fromCssColor('#A88C66'),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'C',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      color: fromCssColor('#ffffff'))),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 8.0)),

                          // 選択肢文ボックス
                          Container(
                            width: 330,
                            height: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: fromCssColor('#A88C66'),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),

                              // 選択肢Cを表示
                              child: AutoSizeText(
                                model.optionC,
                                maxLines: 2,
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        color: fromCssColor('#ffffff'))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  )
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
