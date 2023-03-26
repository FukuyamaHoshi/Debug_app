import 'package:debug_app/couse_page.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'model.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider model
    final Model model = Provider.of<Model>(context, listen: true);
    double screeHeight = MediaQuery.of(context).size.height; // スクリーンの高さ
    double resultY = 0.8; // せいせきボックスの位置(レスポンシブ対応)
    // せいせきボックスの位置(レスポンシブ対応)
    if (screeHeight < 850) resultY = 1.6;

    model.calculateAccuracy(); // 正答率を計算する
    // 正解率
    final int correntRate = model.collectRate;
    // 時間
    int time = model.time;
    // ランク
    int score = model.getScore(); // スコアを取得
    String rank = model.getRank(score);

    return Scaffold(
      // AppBar
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
        // おわるボタン設置
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                // コース画面へ
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CousePage(),
                    fullscreenDialog: true, // 下からのアニメーション
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
      backgroundColor: fromCssColor('#1E2427'),

      body: Column(children: [
        // コースのボックス
        Container(
          width: double.infinity,
          height: 64,
          alignment: Alignment.center,
          child: Text(
            'せいせき',
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: fromCssColor('#ffffff'))),
          ),
        ),

        // やまの名前と詳細、画像
        Expanded(
          child: Stack(children: [
            // 山の背景
            Container(
              width: double.infinity,
              height: 340,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [fromCssColor('#5D8291'), fromCssColor('#1E2427')],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 1]),
              ),
            ),

            // 山の名前、詳細
            Align(
              alignment: const Alignment(0, -0.96),
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
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
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
                          const Padding(padding: EdgeInsets.only(left: 20.0)),
                          Text(
                            '初級',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 15,
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
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: fromCssColor('#ffffff'))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 山画像
            Align(
              alignment: const Alignment(0, -1.1),
              child: SizedBox(
                  width: double.infinity,
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: Image.asset(
                      'images/javascript_mountain.png',
                      fit: BoxFit.contain,
                    ),
                  )),
            ),

            // せいせきボックス
            Align(
              alignment: Alignment(0, resultY),
              child: SizedBox(
                height: 380,
                child: Column(
                  children: [
                    SizedBox(
                      width: 400,
                      child: Row(
                        children: [
                          // せいせきサブテキスト
                          if (screeHeight > 850) // SEの場合は表示しない(レスポンシブ対応)
                            Text(
                              'せいせき',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w400,
                                      color: fromCssColor('#ffffff'))),
                            ),
                        ],
                      ),
                    ),

                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    // 結果表示ボックス
                    SizedBox(
                      width: 390,
                      height: 330,
                      child: Column(children: [
                        // せいかい率
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // せいかい率テキスト
                            Text(
                              'せいかい率',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      color: fromCssColor('#ffffff'))),
                            ),

                            // せいかい率表示
                            Text(
                              '$correntRate %',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: fromCssColor('#ffffff'))),
                            ),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.only(top: 10)),
                        // アンダーライン(せいかい率)
                        Container(
                          width: double.infinity,
                          height: 2,
                          color: fromCssColor("#ffffff"),
                        ),

                        const Padding(padding: EdgeInsets.only(top: 10)),
                        // じかん
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // じかんテキスト
                            Text(
                              'じかん',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      color: fromCssColor('#ffffff'))),
                            ),

                            // じかん表示
                            Text(
                              '$time 秒',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: fromCssColor('#ffffff'))),
                            ),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.only(top: 10)),
                        // アンダーライン(じかん)
                        Container(
                          width: double.infinity,
                          height: 2,
                          color: fromCssColor("#ffffff"),
                        ),

                        const Padding(padding: EdgeInsets.only(top: 10)),
                        // ランク
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ランクテキスト
                            Text(
                              'ランク',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      color: fromCssColor('#ffffff'))),
                            ),

                            // ランク表示
                            Text(
                              rank,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: fromCssColor('#ffffff'))),
                            ),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.only(top: 10)),
                        // アンダーライン(ランク)
                        Container(
                          width: double.infinity,
                          height: 2,
                          color: fromCssColor("#ffffff"),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              'もどる',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 25,
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
            },
          ),
        ),
      ),
    );
  }
}
