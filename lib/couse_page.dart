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
          'スタートアップ',
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: fromCssColor('#ffffff'))),
        ),
        backgroundColor: fromCssColor('#004F8B'),
        elevation: 0,
        automaticallyImplyLeading: false, // もどるボタンを許可しない
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [fromCssColor('#004F8B'), fromCssColor('#6BB3D9')],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.1, 1]),
        ),
        child: Stack(children: [
          // やまの名前と詳細
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 310,
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 80)),
                  // やまの名前
                  Text(
                    'START<APP>',
                    style: GoogleFonts.robotoMono(
                        textStyle: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: fromCssColor('#C0D5ED'))),
                  ),
                  Container(
                    height: 3,
                    color: fromCssColor('#C0D5ED'),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),

                  // やまの詳細
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'for Javascript',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.normal,
                                color: fromCssColor('#C0D5ED'))),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 10.0)),
                      Text(
                        '初級',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.normal,
                                color: fromCssColor('#C0D5ED'))),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 2.0)),
                      Text(
                        'ー',
                        style: TextStyle(color: fromCssColor('#C0D5ED')),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 2.0)),
                      Text(
                        '５問',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.normal,
                                color: fromCssColor('#C0D5ED'))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 地面画像
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                width: 450,
                height: 630,
                child: Image.asset(
                  'images/home.png',
                  fit: BoxFit.contain,
                )),
          ),
        ]),
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
