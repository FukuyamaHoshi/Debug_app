import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('codegen'),
          backgroundColor: fromCssColor('#96D6AE'),
          elevation: 0,
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

          // 山と強調画像
          Stack(children: [
            // 強調画像
            SizedBox(
                width: 430,
                height: 430,
                child: Image.asset(
                  'images/javascript_hallo.png',
                  fit: BoxFit.contain,
                )),
            // 山画像
            SizedBox(
                width: 465,
                height: 465,
                child: Image.asset(
                  'images/javascript_mountain.png',
                  fit: BoxFit.contain,
                )),
          ])
        ]));
  }
}
