import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        // おわるボタン設置
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'おわる',
                style: GoogleFonts.zenMaruGothic(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: fromCssColor('#ffffff'))),
              ),
            ),
          )
        ],
      ),
      backgroundColor: fromCssColor('#F8ED96'),

      body: Column(children: [
        // コースのボックス
        Container(
          width: double.infinity,
          height: 64,
          alignment: Alignment.center,
          child: Text(
            'せいせき',
            style: GoogleFonts.zenMaruGothic(
                textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: fromCssColor('#4E3703'))),
          ),
        ),

        // やまの名前と詳細、画像
        Container(
          height: 320,
          width: double.infinity,
          color: fromCssColor('#F7F0B8'),
          child: Stack(children: [
            // 山の名前、詳細
            Align(
              alignment: const Alignment(0, -0.9),
              child: Container(
                width: double.infinity,
                height: 70,
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    // やまの名前
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 20.0)),
                          Text(
                            'Javascriptやま',
                            style: GoogleFonts.zenMaruGothic(
                                textStyle: TextStyle(
                                    fontSize: 25,
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
                          const Padding(padding: EdgeInsets.only(left: 20.0)),
                          Text(
                            '初級',
                            style: GoogleFonts.zenMaruGothic(
                                textStyle: TextStyle(
                                    fontSize: 15,
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
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: fromCssColor('#536C67'))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 山画像
            SizedBox(
                width: double.infinity,
                child: SizedBox(
                  width: 320,
                  height: 320,
                  child: Image.asset(
                    'images/javascript_mountain.png',
                    fit: BoxFit.contain,
                  ),
                )),
          ]),
        ),

        // せいせきサブテキスト
      ]),
    );
  }
}
