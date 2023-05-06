import 'package:debug_app/models/picture_book_model.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PictureBookPage extends StatelessWidget {
  final int index; // リストのindex番号

  const PictureBookPage({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.read<PictureBookModel>().pictureBooks[index].title,
          style: GoogleFonts.notoSans(
              textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
        ),
        backgroundColor: fromCssColor('#1D252B'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        color: fromCssColor('#E8EFF5'),
        child: Column(children: [
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          // エディターとコンソールボックス
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              border: Border.all(color: fromCssColor('#C3C3C3')),
            ),
            width: 420,
            height: 500,
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                // エディターの上タブ
                Container(
                  width: 380,
                  height: 30,
                  color: fromCssColor('#46515C'),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      '<> エディター',
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
                  width: 380,
                  height: 200,
                  color: fromCssColor('#313B45'),
                  child: Column(
                      children:
                          context.select((PictureBookModel m) => m.editor)),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),

                // コンソールの上タブ
                Container(
                  width: 380,
                  height: 30,
                  color: fromCssColor('#DBDBDB'),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      '>_ コンソール',
                      style: GoogleFonts.robotoMono(
                          textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#45494B'))),
                    ),
                  ),
                ),
                // コンソール
                Container(
                  width: 380,
                  height: 180,
                  color: fromCssColor('#020405'),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          context.select((PictureBookModel m) => m.console)),
                ),
              ]),
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          // 説明
          Container(
            alignment: Alignment.center,
            width: 380,
            child: Text(
              context.select((PictureBookModel m) => m.explan),
              style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: fromCssColor('#191D33'))),
            ),
          )
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: SizedBox(
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 戻るボタン
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  fixedSize: const Size(130, 60),
                ),
                onPressed: () {
                  // リスト番号更新
                  context.read<PictureBookModel>().decrementListNum();
                  // UIをセット
                  context.read<PictureBookModel>().setDisplayTexts(index);
                },
                child: Icon(
                  Icons.arrow_left,
                  size: 45,
                  color: fromCssColor('#707070'),
                ),
              ),
              // 次へボタン
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: fromCssColor('#EC6517'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  fixedSize: const Size(260, 60),
                ),
                onPressed: () {
                  // リスト番号更新
                  context.read<PictureBookModel>().incrementListNum();
                  // UIをセット
                  context.read<PictureBookModel>().setDisplayTexts(index);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '次へ',
                      style: GoogleFonts.notoSans(
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 60)),
                    const Icon(
                      Icons.arrow_right,
                      size: 45,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
