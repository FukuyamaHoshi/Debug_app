import 'package:debug_app/models/indicator_model.dart';
import 'package:debug_app/views/home_page.dart';
import 'package:debug_app/words.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:provider/provider.dart';
import '../models/core_model.dart';
import '../stores/store.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: Text(
          'リザルト',
          style: GoogleFonts.notoSans(
              textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
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
                // コース画面へ
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                    fullscreenDialog: true, // 下からのアニメーション
                  ),
                );
              },
              child: Text(
                'もどる',
                style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [fromCssColor('#8FA4BD'), fromCssColor('#243445')],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const [0.7, 1]),
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(children: [
              const Padding(padding: EdgeInsets.only(top: 30)),

              // プログレスインジケーター
              Container(
                color: Colors.black,
                height: 56,
                width: 370,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  context.read<IndicatorModel>().createIndicatorCircle(0),
                  const Padding(padding: EdgeInsets.only(right: 5)),
                  context.read<IndicatorModel>().createIndicatorLine(0),
                  const Padding(padding: EdgeInsets.only(right: 5)),
                  context.read<IndicatorModel>().createIndicatorCircle(1),
                  const Padding(padding: EdgeInsets.only(right: 5)),
                  context.read<IndicatorModel>().createIndicatorLine(1),
                  const Padding(padding: EdgeInsets.only(right: 5)),
                  context.read<IndicatorModel>().createIndicatorCircle(2)
                ]),
              ),

              // 結果ボックス
              Opacity(
                opacity: 0.7,
                child: Container(
                  width: 370,
                  height: 155,
                  color: Colors.black,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // プレイヤーネーム
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'Player',
                            style: GoogleFonts.notoSans(
                                textStyle: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // せいかい率
                            SizedBox(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Store.correctRate,
                                      style: GoogleFonts.notoSans(
                                          textStyle: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              color: fromCssColor('#1CEEED'))),
                                    ),
                                    Text(
                                      'せいかい率',
                                      style: GoogleFonts.notoSans(
                                          textStyle: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white)),
                                    ),
                                  ]),
                            ),
                            const Padding(padding: EdgeInsets.only(right: 30)),

                            // タイム
                            SizedBox(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Store.time,
                                      style: GoogleFonts.notoSans(
                                          textStyle: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              color: fromCssColor('#1CEEED'))),
                                    ),
                                    Text(
                                      'タイム',
                                      style: GoogleFonts.notoSans(
                                          textStyle: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white)),
                                    ),
                                  ]),
                            ),

                            // 空欄
                            const SizedBox(
                              width: 90,
                              height: 30,
                            )
                          ],
                        )
                      ]),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),

              // 答えのテキストタブ
              Container(
                width: 370,
                height: 30,
                color: fromCssColor('#3C476D'),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    '答え',
                    style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ),
              // 1問目の答えボックス
              Container(
                width: 370,
                height: 370,
                color: fromCssColor('#E8EFF5'),
                child: Column(children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 15)),
                      context.read<CoreModel>().setCorrectIcon(0),
                      const Padding(padding: EdgeInsets.only(left: 15)),
                      Text(
                        "1. ${Store.questions[0].question}",
                        style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#191D33'))),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),

                  // エディターの上タブ
                  Container(
                    width: 350,
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
                      width: 350,
                      height: 260,
                      color: fromCssColor('#313B45'),
                      child: Column(
                        children: context.read<CoreModel>().setCodeWidget(0),
                      )),
                ]),
              ),
              const Padding(padding: EdgeInsets.only(top: 3)),

              // 2問目の答えボックス
              Container(
                width: 370,
                height: 370,
                color: fromCssColor('#E8EFF5'),
                child: Column(children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 15)),
                      context.read<CoreModel>().setCorrectIcon(1),
                      const Padding(padding: EdgeInsets.only(left: 15)),
                      Text(
                        "2. ${Store.questions[1].question}",
                        style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#191D33'))),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),

                  // エディターの上タブ
                  Container(
                    width: 350,
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
                    width: 350,
                    height: 260,
                    color: fromCssColor('#313B45'),
                    child: Column(
                      children: context.read<CoreModel>().setCodeWidget(1),
                    ),
                  ),
                ]),
              ),
              const Padding(padding: EdgeInsets.only(top: 3)),

              // 3問目の答えボックス
              Container(
                width: 370,
                height: 370,
                color: fromCssColor('#E8EFF5'),
                child: Column(children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 15)),
                      context.read<CoreModel>().setCorrectIcon(2),
                      const Padding(padding: EdgeInsets.only(left: 15)),
                      Text(
                        "3. ${Store.questions[2].question}",
                        style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#191D33'))),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),

                  // エディターの上タブ
                  Container(
                    width: 350,
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
                    width: 350,
                    height: 260,
                    color: fromCssColor('#313B45'),
                    child: Column(
                      children: context.read<CoreModel>().setCodeWidget(2),
                    ),
                  ),
                ]),
              ),

              // ボタンがあるため空白を開ける
              const SizedBox(
                height: 150,
              )
            ]),
          ),
        ),
      ),
      // ボタン
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: SizedBox(
          height: 80,
          width: 380,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: fromCssColor('#EC6517'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              'もどる',
              style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            onPressed: () {
              // コース画面へ
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
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
