import 'package:debug_app/question_page.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class CousePage extends StatelessWidget {
  const CousePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider model
    final Model model = Provider.of<Model>(context, listen: true);
    model.resetQuestion(); // もんだい数をリセット

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 134,
            height: 26,
            child: Image.asset(
              'images/title_text.png',
              fit: BoxFit.contain,
            ),
          ),
          bottom: TabBar(
            labelColor: fromCssColor('#1D252B'),
            unselectedLabelColor: Colors.white,
            indicator: RectangularIndicator(
                bottomLeftRadius: 5,
                bottomRightRadius: 5,
                topLeftRadius: 5,
                topRightRadius: 5,
                paintingStyle: PaintingStyle.fill,
                horizontalPadding: 2,
                verticalPadding: 2,
                color: fromCssColor('#1CEEED')),
            tabs: <Widget>[
              Tab(
                child: Text(
                  'れんしゅう場',
                  style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ),
              Tab(
                child: Text(
                  'ランクマッチ',
                  style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ),
            ],
          ),
          backgroundColor: fromCssColor('#1D252B'),
          elevation: 0,
          automaticallyImplyLeading: false, // もどるボタンを許可しない
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [fromCssColor('#DFE6F1'), fromCssColor('#99B1D3')],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: const [0.1, 1]),
          ),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 20)),

              // プレイヤー名前
              Container(
                height: 58,
                width: double.infinity,
                color: fromCssColor('#1D252B'),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Player',
                    style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),

              // 実績ラベル
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'これまでの実績',
                    style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              // 実績ボックス1列目
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // プレイ時間
                  Container(
                    width: 126,
                    height: 188,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: fromCssColor('#333B4C'),
                    ),
                    child: Column(children: [
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Icon(
                        Icons.history,
                        color: fromCssColor('#C7C7C7'),
                        size: 30,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        '00:00',
                        style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#1CEEED'))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        'プレイ時間',
                        style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white)),
                      ),
                    ]),
                  ),

                  // プレイ数
                  Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: Container(
                      width: 126,
                      height: 188,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: fromCssColor('#333B4C'),
                      ),
                      child: Column(children: [
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Icon(
                          Icons.play_arrow,
                          color: fromCssColor('#C7C7C7'),
                          size: 30,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          '00',
                          style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                                  fontSize: 33,
                                  fontWeight: FontWeight.bold,
                                  color: fromCssColor('#1CEEED'))),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Text(
                          'プレイ数',
                          style: GoogleFonts.notoSans(
                              textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                        ),
                      ]),
                    ),
                  ),

                  // せいかい率
                  Container(
                    width: 126,
                    height: 188,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: fromCssColor('#333B4C'),
                    ),
                    child: Column(children: [
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Icon(
                        Icons.check,
                        color: fromCssColor('#C7C7C7'),
                        size: 30,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        '00%',
                        style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#1CEEED'))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        'せいかい率',
                        style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white)),
                      ),
                    ]),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 3)),

              // 実績ボックス2列目
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 全問せいかいの最速タイム
                  Container(
                    width: 126,
                    height: 188,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: fromCssColor('#333B4C'),
                    ),
                    child: Column(children: [
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Icon(
                        Icons.bolt,
                        color: fromCssColor('#C7C7C7'),
                        size: 30,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        '00:00',
                        style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('#1CEEED'))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        '全問せいかいの\n最速タイム',
                        style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white)),
                      ),
                    ]),
                  ),

                  // 平均タイム
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Container(
                      width: 126,
                      height: 188,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: fromCssColor('#333B4C'),
                      ),
                      child: Column(children: [
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Icon(
                          Icons.trending_flat,
                          color: fromCssColor('#C7C7C7'),
                          size: 30,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          '00:00',
                          style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                                  fontSize: 33,
                                  fontWeight: FontWeight.bold,
                                  color: fromCssColor('#1CEEED'))),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Text(
                          '平均タイム',
                          style: GoogleFonts.notoSans(
                              textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                        ),
                      ]),
                    ),
                  ),

                  // 空白のボックス
                  const SizedBox(
                    width: 126,
                    height: 188,
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),

              // お知らせ
              Container(
                width: 387,
                height: 71,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        child: Text(
                          'お知らせ',
                          style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                  color: fromCssColor('#A3A3A3'))),
                        ),
                      ),

                      // お知らせ内容
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        child: Text(
                          'ランクマッチは実装中です。しばらくお待ちください。',
                          style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: fromCssColor('#191D33'))),
                        ),
                      ),
                    ]),
              )
            ],
          ),
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
                'はじめる',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: fromCssColor('#FFFFFF'))),
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
                    MaterialPageRoute(
                        builder: (context) => const QuestionPage()),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
