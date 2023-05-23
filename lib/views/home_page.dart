import 'package:debug_app/models/picture_book_model.dart';
import 'package:debug_app/models/purchase_model.dart';
import 'package:debug_app/views/question_page.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../models/core_model.dart';
import '../models/local_database_model.dart';
import '../models/time_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  bool _isPurchase = false; // 課金フラグ
  // 初回で実行
  @override
  void initState() {
    super.initState();

    try {
      PurchaseModel pm = PurchaseModel(); // 購入モデル
      Future(() async {
        await pm.getIsPurchase().then((bool p) {
          // UIを更新
          setState(() {
            _isPurchase = p; // 購入フラグを取得
          });
        });
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // 永久データの処理
    context.read<TimeModel>().getPlayTime(); // プレイ時間
    context.read<CoreModel>().getPlayCount(); // プレイ数
    context.read<CoreModel>().getAverageCorrectRate(); // 平均正答率
    context.read<TimeModel>().getFastTime(); // 最速時間
    context.read<TimeModel>().getAverageTime(); // 平均時間
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
                  'コード図鑑',
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
        body: TabBarView(children: [
          // れんしゅう画面
          Container(
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
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Icon(
                          Icons.code,
                          color: fromCssColor('#C7C7C7'),
                          size: 30,
                        ),
                      ),
                      Text(
                        'for JavaScript',
                        style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),

                // 実績ラベル
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
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
                          context.select((TimeModel t) => t.playTime),
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
                            context
                                .select((CoreModel c) => c.playCount)
                                .toString(),
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

                    // 平均せいかい率
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
                          context.select((CoreModel c) => c.averageCorrectRate),
                          style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                                  fontSize: 33,
                                  fontWeight: FontWeight.bold,
                                  color: fromCssColor('#1CEEED'))),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Text(
                          '平均せいかい率',
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
                          context.select((TimeModel t) => t.fastTime),
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
                            context.select((TimeModel t) => t.averageTime),
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

                // レスポンジブ対応
                if (MediaQuery.of(context).size.height > 850)
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
                              '問題数、コード図鑑の内容が増えました。',
                              style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: fromCssColor('#191D33'))),
                            ),
                          ),
                        ]),
                  ),
                const Padding(padding: EdgeInsets.only(bottom: 50)),
                // 問題開始ボタン
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: fromCssColor('#EC6517'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      fixedSize: const Size(387, 65)),
                  child: Text(
                    'はじめる',
                    style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  onPressed: () async {
                    // 問題データベースの作成・更新する
                    await context
                        .read<LocalDatabaseModel>()
                        .setVersionAndBatch();

                    // もんだい数をリセット
                    if (context.mounted) {
                      context.read<CoreModel>().resetQuestion();
                    }
                    // データ数を取得
                    if (context.mounted) {
                      await context
                          .read<LocalDatabaseModel>()
                          .getQuestionsSize();
                    }
                    // 取得する問題を決める
                    if (context.mounted) {
                      context.read<CoreModel>().getQuestionsNum();
                    }
                    // 出題リストに問題を追加
                    if (context.mounted) {
                      await context.read<LocalDatabaseModel>().setQuestions();
                    }
                    // コードをWidgetへ変換
                    if (context.mounted) {
                      context.read<CoreModel>().setCodeWidget();
                    }
                    // もんだいを設定
                    if (context.mounted) {
                      context.read<CoreModel>().setQuestion();
                    }
                    // タイマーを開始
                    if (context.mounted) {
                      context.read<TimeModel>().startTimer();
                    }
                    // もんだい画面へ
                    if (context.mounted) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuestionPage()),
                      );
                    }
                  },
                )
              ],
            ),
          ),
          // コード図鑑画面
          Column(children: [
            // タイトルリスト
            Expanded(
              child: ListView.builder(
                itemCount: context.read<PictureBookModel>().pictureBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  return context.read<PictureBookModel>().setListTile(
                      index: index, context: context, isPurchase: _isPurchase);
                },
              ),
            )
          ])
        ]),
      ),
    );
  }
}
