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
          'スタートアップ',
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: fromCssColor('#ffffff'))),
        ),
        backgroundColor: fromCssColor('#265F65'),
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

      body: Column(children: [
        // やまの名前と詳細、画像
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [fromCssColor('#265F65'), fromCssColor('#F5CA8F')],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.1, 1]),
          ),
          child: Column(children: [
            if (screeHeight > 850) // SEの場合は表示しない(レスポンシブ対応)
              const Padding(padding: EdgeInsets.only(top: 70.0)),

            // 山の名前、詳細
            SizedBox(
              width: 160,
              child: Column(
                children: [
                  Text(
                    'Javascript',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: fromCssColor('#D9E7E8'))),
                  ),
                  Container(
                    height: 3,
                    color: fromCssColor('#D9E7E8'),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5.0)),

                  // やまの詳細
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 20.0)),
                      Text(
                        '初級',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 16,
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
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: fromCssColor('#ffffff'))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (screeHeight > 850) // SEの場合は表示しない(レスポンシブ対応)
              const Padding(padding: EdgeInsets.only(top: 20.0)),

            // 画像
            SizedBox(
                child: SizedBox(
              width: 450,
              height: 240,
              child: Image.asset(
                'images/result.png',
                fit: BoxFit.contain,
              ),
            )),
          ]),
        ),

        // せいせきボックス
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [fromCssColor('#F5CA8F'), fromCssColor('#265F65')],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 1]),
            ),
            child: Stack(alignment: Alignment.topCenter, children: [
              Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 20.0)),
                  Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: 380,
                      height: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: fromCssColor('#000000'),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 35),
                child: Column(
                  children: [
                    Text(
                      'せいせき',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.normal,
                              color: fromCssColor('#ffffff'))),
                    ),

                    const Padding(padding: EdgeInsets.only(top: 20.0)),
                    // 結果表示ボックス
                    Column(children: [
                      SizedBox(
                        width: 350,
                        // せいかい率
                        child: Column(
                          children: [
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
                            const Padding(padding: EdgeInsets.only(top: 5)),

                            // アンダーライン(せいかい率)
                            Container(
                              height: 1,
                              color: fromCssColor("#ffffff"),
                            ),
                          ],
                        ),
                      ),

                      const Padding(padding: EdgeInsets.only(top: 10)),
                      // じかん
                      SizedBox(
                        width: 350,
                        child: Column(
                          children: [
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
                            const Padding(padding: EdgeInsets.only(top: 5)),

                            // アンダーライン(じかん)
                            Container(
                              height: 1,
                              color: fromCssColor("#ffffff"),
                            ),
                          ],
                        ),
                      ),

                      const Padding(padding: EdgeInsets.only(top: 10)),
                      // ランク
                      SizedBox(
                        width: 350,
                        child: Column(
                          children: [
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
                            const Padding(padding: EdgeInsets.only(top: 5)),
                            // アンダーライン(ランク)
                            Container(
                              height: 1,
                              color: fromCssColor("#ffffff"),
                            )
                          ],
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ]),
          ),
        ),
      ]),

      // ボタン
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: SizedBox(
          height: 80,
          width: 380,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: fromCssColor('#ffffff'),
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
            },
          ),
        ),
      ),
    );
  }
}
