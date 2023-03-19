import 'package:debug_app/couse_page.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'model.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  final String rank = 'すごい！'; // ランク

  @override
  Widget build(BuildContext context) {
    // Provider model
    final Model model = Provider.of<Model>(context, listen: true);
    double screeHeight = MediaQuery.of(context).size.height; // スクリーンの高さ
    double resultY = 0.8; // せいせきボックスの位置(レスポンシブ対応)
    // せいせきボックスの位置(レスポンシブ対応)
    if (screeHeight < 850) resultY = 1.6;

    // 正解率
    final int correntRate = model.getCollectRate();
    // 時間
    int time = model.time;

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
        Expanded(
          child: Stack(children: [
            // 山の背景
            Container(
              width: double.infinity,
              height: 340,
              color: fromCssColor('#F7F0B8'),
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
                              style: GoogleFonts.zenMaruGothic(
                                  textStyle: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: fromCssColor('#4E3703'))),
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
                              style: GoogleFonts.zenMaruGothic(
                                  textStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: fromCssColor('#77694A'))),
                            ),

                            // せいかい率表示
                            Text(
                              '$correntRate %',
                              style: GoogleFonts.zenMaruGothic(
                                  textStyle: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: fromCssColor('#77694A'))),
                            ),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.only(top: 10)),
                        // アンダーライン(せいかい率)
                        Container(
                          width: double.infinity,
                          height: 4,
                          color: fromCssColor("#FFFABC"),
                        ),

                        const Padding(padding: EdgeInsets.only(top: 10)),
                        // じかん
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // じかんテキスト
                            Text(
                              'じかん',
                              style: GoogleFonts.zenMaruGothic(
                                  textStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: fromCssColor('#77694A'))),
                            ),

                            // じかん表示
                            Text(
                              '$time 秒',
                              style: GoogleFonts.zenMaruGothic(
                                  textStyle: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: fromCssColor('#77694A'))),
                            ),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.only(top: 10)),
                        // アンダーライン(じかん)
                        Container(
                          width: double.infinity,
                          height: 4,
                          color: fromCssColor("#FFFABC"),
                        ),

                        const Padding(padding: EdgeInsets.only(top: 10)),
                        // ランク
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ランクテキスト
                            Text(
                              'ランク',
                              style: GoogleFonts.zenMaruGothic(
                                  textStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: fromCssColor('#77694A'))),
                            ),

                            // ランク表示
                            Text(
                              rank,
                              style: GoogleFonts.zenMaruGothic(
                                  textStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: fromCssColor('#77694A'))),
                            ),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.only(top: 10)),
                        // アンダーライン(ランク)
                        Container(
                          width: double.infinity,
                          height: 4,
                          color: fromCssColor("#FFFABC"),
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
              backgroundColor: fromCssColor('#ffffff'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              'もどる',
              style: GoogleFonts.zenMaruGothic(
                  textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: fromCssColor('#4E3703'))),
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
