import 'package:debug_app/models/picture_book_model.dart';
import 'package:debug_app/models/purchase_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../purchase.dart';
import 'complete_page.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({required this.index, super.key});
  final int index; // リストのindex番号

  @override
  PurchaseState createState() => PurchaseState();
}

class PurchaseState extends State<PurchasePage> {
  bool _isPurchase = false; // 課金フラグ
  // 初回で実行
  @override
  void initState() {
    super.initState();
    try {
      initPlatformState(); // RebenueCat初期化
      PurchaseModel pm = PurchaseModel(); // 購入モデル
      Future(() async {
        // 購入フラグを取得
        await pm.getIsPurchase().then((bool p) {
          // UIを更新
          setState(() {
            _isPurchase = p;
          });
        });
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // 初期化する
  Future<void> initPlatformState() async {
    // デバッグモードでログを出力
    await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration? configuration;
    if (defaultTargetPlatform == TargetPlatform.android) {
      configuration = PurchasesConfiguration('<public_google_sdk_key>');
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      configuration =
          PurchasesConfiguration('appl_wsBLnOIBHwObHZuDisKTfdRisld');
    }

    if (configuration == null) {
      debugPrint('purchase init error');
      return;
    }

    await Purchases.configure(configuration); // 初期化
  }

  @override
  Widget build(BuildContext context) {
    Purchase purchase = context
        .read<PictureBookModel>()
        .pictureBooks[widget.index] as Purchase; // 型キャスト
    return Scaffold(
      appBar: AppBar(
        title: Text(
          purchase.title,
          style: GoogleFonts.notoSans(
              textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
        ),
        backgroundColor: fromCssColor('#1D252B'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [fromCssColor('#1D252B'), fromCssColor('#34424D')],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 1]),
            ),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                // Let`s goラベル
                Container(
                  color: fromCssColor('#1CEEED'),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isPurchase ? "Let's Go" : "Get Started",
                          style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: fromCssColor('#191D33'))),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 3)),
                        const Icon(
                          Icons.rocket_launch,
                          size: 28,
                        ),
                      ]),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                // サブテキスト
                Text(
                  _isPurchase ? "あなたの可能性の第一歩へ" : "さあ、あなたの可能性を信じて",
                  style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 20)),
                _isPurchase
                    ? Lottie.asset('images/happy_spaceman.json',
                        width: 350, repeat: false)
                    : Lottie.asset('images/space_shuttle.json',
                        width: 350, repeat: false),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 18)),
                // 説明テキスト
                Text(
                  _isPurchase
                      ? "ご購入ありがとうございます。\nこれからもスタートアップをお楽しみください。"
                      : "全コード図鑑を購入して頂くと\n全てのコードが閲覧できるようになります。",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 8,
            width: double.infinity,
            color: fromCssColor('#B4A17B'),
            child: Center(
              // 購入ボタン
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  fixedSize: const Size(310, 65),
                ),
                onPressed: () async {
                  try {
                    // 購入フラグチェック
                    if (!_isPurchase) {
                      // 購入していない場合
                      await context
                          .read<PurchaseModel>()
                          .handlePurchase(); // 購入処理

                      // 購入完了画面へ
                      if (context.mounted) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompletePage(
                              isRestore: false,
                            ),
                            fullscreenDialog: true, // 下からのアニメーション
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    // エラー処理()
                    debugPrint(e.toString());
                    // スナックバーを表示する
                    SnackBar snackBar = SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.notification_important,
                            size: 23,
                            color: fromCssColor('#C7C7C7'),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 5)),
                          Text(
                            '購入が完了できませんでした。',
                            style: GoogleFonts.notoSans(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                      backgroundColor: fromCssColor('#1D252B'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isPurchase ? "購入できません" : "購入する",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSans(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#9F8B63'))),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 5)),
                    // 価格のボタンテキスト
                    if (!_isPurchase)
                      Text(
                        "¥500(税抜)",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: fromCssColor('#9F8B63'))),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                  // リストアボタン
                  child: TextButton(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    _isPurchase ? "復元できません" : "復元する(以前ご利用された方)",
                    style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: fromCssColor('#191D33'))),
                  ),
                ),
                onPressed: () async {
                  try {
                    // 購入フラグチェック
                    if (!_isPurchase) {
                      // 購入していない場合
                      await context
                          .read<PurchaseModel>()
                          .handleRestore(); // リストア処理

                      // 購入完了画面へ
                      if (context.mounted) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompletePage(
                              isRestore: true,
                            ),
                            fullscreenDialog: true, // 下からのアニメーション
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    // エラー処理()
                    debugPrint(e.toString());
                    // スナックバーを表示する
                    SnackBar snackBar = SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.notification_important,
                            size: 23,
                            color: fromCssColor('#C7C7C7'),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 5)),
                          Text(
                            '復元を完了できませんでした。',
                            style: GoogleFonts.notoSans(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                      backgroundColor: fromCssColor('#1D252B'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              )),
            ),
          )
        ],
      ),
    );
  }
}
