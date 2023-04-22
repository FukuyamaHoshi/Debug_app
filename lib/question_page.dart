import 'package:debug_app/model.dart';
import 'package:debug_app/result_page.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'couse_page.dart';
import 'package:auto_size_text/auto_size_text.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider model
    final Model model = Provider.of<Model>(context, listen: true);
    // スクリーンの高さ(850以上かどうか)
    //final double screeHeight = MediaQuery.of(context).size.height;

    // もんだい数に応じて画面推移
    void nextNavigation() {
      // 正誤判定
      model.addCollects();
      // 次のもんだいへ
      model.nextQuestion();

      // 現在の問題数に応じて処理
      if (model.currentQuestionNum < model.questionCount) {
        // もんだいを設定
        model.setQuestion();
        // codeをセット
        model.comvertCodeToWidget();

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
          'れんしゅう場',
          style: GoogleFonts.notoSans(
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: fromCssColor('#ffffff'))),
        ),
        backgroundColor: fromCssColor('#1D252B'),
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
                    backgroundColor: fromCssColor('#E8EFF5'),
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
                    iconColor: fromCssColor('#191D33'),
                    iconPadding: const EdgeInsets.all(10.0),
                    title: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'れんしゅう場を終わりますか？',
                        style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#191D33'))),
                      ),
                    ),
                    content: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        'れんしゅう場の途中で終わると\n結果が反映されません。',
                        style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: fromCssColor('#191D33'))),
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
                                  backgroundColor: fromCssColor('#EC6517'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'はい',
                                  style: GoogleFonts.notoSans(
                                      textStyle: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
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
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'いいえ',
                                  style: GoogleFonts.notoSans(
                                      textStyle: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: fromCssColor('#191D33'))),
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
                'もどる',
                style: GoogleFonts.notoSans(
                    textStyle: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: fromCssColor('#ffffff'))),
              ),
            ),
          )
        ],
      ),
      backgroundColor: fromCssColor('#E8EFF5'),

      body: Column(
        children: [
          // プログレスインジケーター
          Container(
            color: Colors.black,
            width: double.infinity,
            height: 66,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // 1つ目(丸)
              model.createIndicatorCircle(0),
              const Padding(padding: EdgeInsets.only(right: 5)),
              // 1つ目(線)
              model.createIndicatorLine(0),
              const Padding(padding: EdgeInsets.only(right: 5)),
              // 2つ目(丸)
              model.createIndicatorCircle(1),
              const Padding(padding: EdgeInsets.only(right: 5)),
              // 2つ目(線)
              model.createIndicatorLine(1),
              const Padding(padding: EdgeInsets.only(right: 5)),
              // 3つ目(丸)
              model.createIndicatorCircle(2),
            ]),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),

          // もんだい文ボックス
          Container(
            width: 400,
            height: 87,
            decoration: BoxDecoration(
              border: Border.all(color: fromCssColor('#DBEBEC')),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),

              // もんだい分を表示
              child: AutoSizeText(
                // 取得したもんだい文を表示
                model.question,
                maxLines: 2,
                style: GoogleFonts.notoSans(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: fromCssColor('#191D33'))),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),

          // エディターの上タブ
          Container(
            width: 400,
            height: 30,
            color: fromCssColor('#46515C'),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                '<> javascript',
                style: GoogleFonts.robotoMono(
                    textStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: fromCssColor('#ffffff'))),
              ),
            ),
          ),

          // エディター
          Container(
            width: 400,
            height: 300,
            color: fromCssColor('#313B45'),
            child: Column(
              children: model.codeWidgets,
            ),
          ),

          const Padding(padding: EdgeInsets.only(top: 20)),

          // 選択肢ボックス
          Container(
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(color: fromCssColor('#DBEBEC')),
              borderRadius: BorderRadius.circular(5),
              color: fromCssColor('#1D252B'),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      // 選択肢A
                      Draggable(
                        data: model.optionA,
                        feedback: Opacity(
                          opacity: 0.5,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: fromCssColor('#C7C7C7')),
                              borderRadius: BorderRadius.circular(5),
                              color: fromCssColor('#34424D'),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: AutoSizeText(
                                model.optionA,
                                maxLines: 1,
                                style: GoogleFonts.robotoMono(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: fromCssColor('#B6C5CA'))),
                              ),
                            ),
                          ),
                        ),
                        childWhenDragging: Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: fromCssColor('#EAEAEA'),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // タップ時の処理
                            model.enterTextInBlank(model.optionA);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: fromCssColor('#C7C7C7')),
                              borderRadius: BorderRadius.circular(5),
                              color: fromCssColor('#34424D'),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: AutoSizeText(
                                model.optionA,
                                maxLines: 1,
                                style: GoogleFonts.robotoMono(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: fromCssColor('#B6C5CA'))),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 10)),

                      // 選択肢B
                      Draggable(
                        data: model.optionB,
                        feedback: Opacity(
                          opacity: 0.5,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: fromCssColor('#C7C7C7')),
                              borderRadius: BorderRadius.circular(5),
                              color: fromCssColor('#34424D'),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: AutoSizeText(
                                model.optionB,
                                maxLines: 1,
                                style: GoogleFonts.robotoMono(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: fromCssColor('#B6C5CA'))),
                              ),
                            ),
                          ),
                        ),
                        childWhenDragging: Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: fromCssColor('#EAEAEA'),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // タップ時の処理
                            model.enterTextInBlank(model.optionB);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: fromCssColor('#C7C7C7')),
                              borderRadius: BorderRadius.circular(5),
                              color: fromCssColor('#34424D'),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: AutoSizeText(
                                model.optionB,
                                maxLines: 1,
                                style: GoogleFonts.robotoMono(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: fromCssColor('#B6C5CA'))),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    children: [
                      // 選択肢C
                      Draggable(
                        data: model.optionC,
                        feedback: Opacity(
                          opacity: 0.5,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: fromCssColor('#C7C7C7')),
                              borderRadius: BorderRadius.circular(5),
                              color: fromCssColor('#34424D'),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: AutoSizeText(
                                model.optionC,
                                maxLines: 1,
                                style: GoogleFonts.robotoMono(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: fromCssColor('#B6C5CA'))),
                              ),
                            ),
                          ),
                        ),
                        childWhenDragging: Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: fromCssColor('#EAEAEA'),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // タップ時の処理
                            model.enterTextInBlank(model.optionC);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: fromCssColor('#C7C7C7')),
                              borderRadius: BorderRadius.circular(5),
                              color: fromCssColor('#34424D'),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: AutoSizeText(
                                model.optionC,
                                maxLines: 1,
                                style: GoogleFonts.robotoMono(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: fromCssColor('#B6C5CA'))),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 10)),

                      // 選択肢D
                      Draggable(
                        data: model.optionD,
                        feedback: Opacity(
                          opacity: 0.5,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: fromCssColor('#C7C7C7')),
                              borderRadius: BorderRadius.circular(5),
                              color: fromCssColor('#34424D'),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: AutoSizeText(
                                model.optionD,
                                maxLines: 1,
                                style: GoogleFonts.robotoMono(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: fromCssColor('#B6C5CA'))),
                              ),
                            ),
                          ),
                        ),
                        childWhenDragging: Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: fromCssColor('#EAEAEA'),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // タップ時の処理
                            model.enterTextInBlank(model.optionD);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: fromCssColor('#C7C7C7')),
                              borderRadius: BorderRadius.circular(5),
                              color: fromCssColor('#34424D'),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: AutoSizeText(
                                model.optionD,
                                maxLines: 1,
                                style: GoogleFonts.robotoMono(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: fromCssColor('#B6C5CA'))),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),

      // ボタン
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: SizedBox(
          height: 75,
          width: 380,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: fromCssColor('#EC6517'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              '次へ',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: fromCssColor('#FFFFFF'))),
            ),
            onPressed: () {
              nextNavigation();
            },
          ),
        ),
      ),
    );
  }
}
