import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'home_page.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({required this.isRestore, super.key});

  final bool isRestore; // リストア完了ページ or 購入完了ページ

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: Text(
          isRestore ? 'リストア完了' : '購入完了',
          style: GoogleFonts.notoSans(
              textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        backgroundColor: fromCssColor('#1D252B'),
        elevation: 0,
        automaticallyImplyLeading: false, // もどるボタンを許可しない
      ),
      body: Container(
        color: fromCssColor('#E8EFF5'),
        width: double.infinity,
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 18)),
          Lottie.asset('images/complete.json', width: 300, repeat: false),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 4)),
          Text(
            isRestore
                ? '購入データの復元が完了しました。\n引き続き、スタートアップをお楽しみください。'
                : 'ご購入ありがとうございます。\nご購入処理が完了しました。。',
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: fromCssColor('#191D33'))),
          ),
        ]),
      ),
      // ボタン
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        // レスポンシブ対応
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height > 850 ? 35 : 15),
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
              'ホームにもどる',
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
