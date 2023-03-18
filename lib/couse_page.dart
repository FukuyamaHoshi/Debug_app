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

    return Scaffold(
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
      ),
      backgroundColor: fromCssColor('#F4F2E4'),
      body: Column(children: [
        // コースのボックス
        Container(
          width: double.infinity,
          height: 64,
          color: fromCssColor('#BDE2B8'),
          alignment: Alignment.center,
          child: Text(
            'コース',
            style: GoogleFonts.zenMaruGothic(
                textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: fromCssColor('#4E3703'))),
          ),
        ),

        // やまの名前と詳細
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              // やまの名前
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10.0)),
                    Text(
                      'Javascriptやま',
                      style: GoogleFonts.zenMaruGothic(
                          textStyle: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#536C67'))),
                    ),
                  ],
                ),
              ),
              // やまの詳細
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10.0)),
                    Text(
                      '初級',
                      style: GoogleFonts.zenMaruGothic(
                          textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: fromCssColor('#536C67'))),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 2.0)),
                    const Text('ー'),
                    const Padding(padding: EdgeInsets.only(left: 2.0)),
                    Text(
                      '５問',
                      style: GoogleFonts.zenMaruGothic(
                          textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: fromCssColor('#536C67'))),
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
            // 強調画像
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                  width: 430,
                  height: 430,
                  child: Image.asset(
                    'images/javascript_hallo.png',
                    fit: BoxFit.contain,
                  )),
            ),
            // 山画像
            Align(
              alignment: const Alignment(0, -0.9),
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
              alignment: const Alignment(-0.81, 0.25),
              child: SizedBox(
                  width: 90,
                  height: 90,
                  child: Image.asset(
                    'images/tree_first.png',
                    fit: BoxFit.contain,
                  )),
            ),
            // 木画像
            Align(
              alignment: const Alignment(-1, 0.25),
              child: SizedBox(
                  width: 90,
                  height: 90,
                  child: Image.asset(
                    'images/tree_second.png',
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
                    'images/zimen.png',
                    fit: BoxFit.contain,
                  )),
            ),
          ]),
        ),
      ]),

      // ボタン
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: SizedBox(
          height: 73,
          width: 329,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white, width: 4),
              backgroundColor: fromCssColor('#90CCC9'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              'はじめる',
              style: GoogleFonts.zenMaruGothic(
                  textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: fromCssColor('#ffffff'))),
            ),
            onPressed: () async {
              // 取得する問題を決める
              model.getQuestionsNum();
              // Firebaseからデータ取得
              model.getQuestionsData();

              // もんだい画面へ
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionPage()),
              );
            },
          ),
        ),
      ),
    );
  }
}
