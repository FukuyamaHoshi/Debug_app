import 'package:debug_app/question_page.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'model.dart';

class CousePage extends StatelessWidget {
  const CousePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider model
    final Model model = Provider.of<Model>(context, listen: true);
    model.resetQuestion(); // もんだい数をリセット

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'codegen',
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: fromCssColor('#ffffff'))),
        ),
        backgroundColor: fromCssColor('#121517'),
        elevation: 0,
        automaticallyImplyLeading: false, // もどるボタンを許可しない
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [fromCssColor('#567582'), fromCssColor('#D6D3BD')],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.4, 1]),
        ),
        child: Column(children: [
          // コースのボックス
          Container(
            width: double.infinity,
            height: 64,
            color: fromCssColor('#1E2427'),
            alignment: Alignment.center,
            child: Text(
              'コース',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: fromCssColor('#ffffff'))),
            ),
          ),

          // やまの名前と詳細
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15.0, top: 15.0),
            child: Column(
              children: [
                // やまの名前
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        'Javascriptやま',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                                color: fromCssColor('#ffffff'))),
                      ),
                    ],
                  ),
                ),
                // やまの詳細
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        '初級',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: fromCssColor('#ffffff'))),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 2.0)),
                      Text(
                        'ー',
                        style: TextStyle(color: fromCssColor('#ffffff')),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 2.0)),
                      Text(
                        '５問',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: fromCssColor('#ffffff'))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 山と強調, 地面画像
          Expanded(
            child: Stack(children: [
              // 山画像
              Align(
                alignment: const Alignment(0, -1.1),
                child: SizedBox(
                    width: 465,
                    height: 465,
                    child: Image.asset(
                      'images/javascript_mountain.png',
                      fit: BoxFit.contain,
                    )),
              ),
              // 木画像
              Align(
                alignment: const Alignment(-0.81, 0.3),
                child: SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.asset(
                      'images/tree_third.png',
                      fit: BoxFit.contain,
                    )),
              ),
              // 木画像
              Align(
                alignment: const Alignment(-1, 0.3),
                child: SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.asset(
                      'images/tree_third.png',
                      fit: BoxFit.contain,
                    )),
              ),
              // 地面画像
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    width: 465,
                    height: 465,
                    child: Image.asset(
                      'images/ground_second.png',
                      fit: BoxFit.contain,
                    )),
              ),
            ]),
          ),
        ]),
      ),

      // ボタン
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: SizedBox(
          height: 73,
          width: 329,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: fromCssColor('#ffffff'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              'はじめる',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: fromCssColor('#373737'))),
            ),
            onPressed: () async {
              // Firebaseからデータ数を取得
              await model.fetchQuestionsSize();
              // 取得する問題を決める
              model.getQuestionsNum();
              // Firebaseからデータ取得
              await model.fetchQuestionsData();
              // もんだいを設定
              model.setQuestion();
              // タイマーを開始
              model.startTimer();

              if (context.mounted) {
                // もんだい画面へ
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuestionPage()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
