import 'package:debug_app/models/picture_book_model.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../purchase.dart';

class PurchasePage extends StatelessWidget {
  final int index; // リストのindex番号

  const PurchasePage({required this.index, super.key});
  @override
  Widget build(BuildContext context) {
    Purchase purchase = context.read<PictureBookModel>().pictureBooks[index]
        as Purchase; // 型キャスト
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
                          "Get Started",
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
                  "さあ、あなたの可能性を信じて",
                  style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 20)),
                Lottie.asset('images/space_shuttle.json',
                    width: 350, repeat: false),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 18)),
                // 説明テキスト
                Text(
                  "全コード図鑑を購入して頂くと\n全てのコードが閲覧できるようになります。",
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
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "購入する",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSans(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#9F8B63'))),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 5)),
                    // 価格のボタンテキスト
                    Text(
                      "¥500(税込)",
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
                    "復元する(以前ご利用された方)",
                    style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: fromCssColor('#191D33'))),
                  ),
                ),
                onPressed: () {},
              )),
            ),
          )
        ],
      ),
    );
  }
}
