import 'dart:math';
import 'package:debug_app/picture_book_content/comment_out.dart';
import 'package:debug_app/picture_book_content/constant.dart';
import 'package:debug_app/picture_book_content/integers.dart';
import 'package:debug_app/picture_book_content/output_console.dart';
import 'package:debug_app/picture_book.dart';
import 'package:debug_app/picture_book_content/strings.dart';
import 'package:debug_app/picture_book_content/variable.dart';
import 'package:debug_app/purchase.dart';
import 'package:debug_app/purchase/purchase_title.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight_text/highlight_text.dart';
import '../picture_book_content/difference_string_integer.dart';
import '../picture_book_content/reason_constant.dart';
import '../picture_book_content/reason_variable.dart';
import '../views/picture_book_page.dart';
import '../views/purchase_page.dart';
import '../words.dart';

// コード図鑑
class PictureBookModel with ChangeNotifier {
  // コード図鑑の中身
  final pictureBooks = [
    '基本',
    outputConsole,
    commentOut,
    '文字列と数字',
    strings,
    integers,
    differenceStringInteger,
    '変数と定数',
    variable,
    reasonVariable,
    constant,
    reasonConstant,
    'その他',
    purchaseTitle
  ];
  // ラベルの色
  final Map<int, String> _colors = {
    0: '#33B0FF',
    3: '#93C38E',
    7: '#EFAA3D',
    12: '#9F8B63'
  };
  List<Widget> editor = []; // 表示するコード
  List<Widget> console = []; // 表示するコンソール
  String explan = ""; // 表示する説明分
  int listNum = 0; // 表示するリストの番号

  // リスト番号を増やす
  void incrementListNum() {
    listNum++;
  }

  // リスト番号を減らす
  void decrementListNum() {
    if (listNum <= 0) return; // 0以下にさせない
    listNum--;
  }

  // 表示する図鑑をセット
  void setDisplayTexts(int index) {
    // 型チェック
    if (pictureBooks[index] is String) {
      debugPrint('not PictureBook model');
      return;
    }

    // ignore: no_leading_underscores_for_local_identifiers
    List<PictureBook> _pictureBooks =
        pictureBooks.cast<PictureBook>(); // キャストする

    // エディター
    editor = _getEditorWidght(_pictureBooks[index].editor);
    // コンソール
    console = _getConsoleWidght(_pictureBooks[index].console);
    // 説明文
    if (_pictureBooks[index].explan.length - 1 < listNum) {
      // リスト番号の方が大きい(レンジエラー)の場合、
      explan =
          _pictureBooks[index].explan[_pictureBooks[index].explan.length - 1];
    } else {
      // リスト番号が小さい
      explan = _pictureBooks[index].explan[listNum];
    }

    // リストの最大値を制限する
    _limitListNum(
        _pictureBooks[index].editor.length,
        _pictureBooks[index].console.length,
        _pictureBooks[index].explan.length);

    notifyListeners(); // UI更新
  }

  // エディターのテキストを作成し返却
  List<Widget> _getEditorWidght(List<List<String>> es) {
    List<Widget> texts = []; // 作成したテキスト配列
    int num = 0; // 配列の番号

    // どの配列をテキスト化するか
    if (es.length - 1 < listNum) {
      // リスト番号の方が大きい(レンジエラー)の場合、
      num = es.length - 1;
    } else {
      // リスト番号が小さい
      num = listNum;
    }
    // テキストリストを作成
    for (int i = 0; i < es[num].length; i++) {
      Widget t = es[num][i].contains("//")
          // コメントアウト
          ? Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 2.5, right: 10, bottom: 2.5),
              child: Text(
                es[num][i],
                style: GoogleFonts.robotoMono(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: fromCssColor('#A0A0A0'))),
              ),
            )
          // コード
          : Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 2.5, right: 10, bottom: 2.5),
              child: TextHighlight(
                text: es[num][i],
                words: words,
                textStyle: GoogleFonts.robotoMono(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            );

      texts.add(t); // 配列に追加
    }

    return texts;
  }

  // コンソールのテキストを作成し返却
  List<Widget> _getConsoleWidght(List<List<String>> cs) {
    List<Widget> texts = []; // 作成したテキスト配列
    int num = 0; // 配列の番号

    // どの配列をテキスト化するか
    if (cs.length - 1 < listNum) {
      // リスト番号の方が大きい(レンジエラー)の場合、
      num = cs.length - 1;
    } else {
      // リスト番号が小さい
      num = listNum;
    }

    // Textリストを作成
    for (int i = 0; i < cs[num].length; i++) {
      Widget t = Padding(
        padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
        child: Text(
          cs[num][i],
          style: GoogleFonts.robotoMono(
              textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: fromCssColor('#56DC4D'))),
        ),
      );

      texts.add(t); // 配列に追加
    }

    return texts;
  }

  // リストの最大値を制限する
  void _limitListNum(int a, int b, int c) {
    int m = [a, b, c].reduce(max); // 最大値
    // リスト番号が最大値より大きい場合、
    if (m <= listNum) {
      listNum = m; // リスト番号を最大値に制限
      _changeOverExplan(); // 説明文を変更する
    }
  }

  // コード図鑑終了時の説明文を更新する
  void _changeOverExplan() {
    explan = '説明は終わりです。';
  }

  // コード図鑑のListTileを作成する
  Widget setListTile({required int index, required BuildContext context}) {
    Widget tile; // タイル

    // 型チェック
    if (pictureBooks[index] is String) {
      // ラベル
      tile = Container(
          color: fromCssColor(_colors[index].toString()),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              top: 5,
              bottom: 5,
            ),
            child: Text(
              pictureBooks[index].toString(),
              style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ));
    } else if (pictureBooks[index] is PictureBook) {
      PictureBook p = pictureBooks[index] as PictureBook; // 図鑑クラスにキャスト

      // 問題リスト
      tile = Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: fromCssColor('#CCCCCC')),
          ),
        ),
        child: ListTile(
            title: Text(
              p.title.toString(),
              style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: fromCssColor('#191D33'))),
            ),
            leading: const Icon(
              Icons.description,
              size: 30,
            ),
            trailing: const Icon(
              Icons.arrow_right,
              size: 40,
            ),
            onTap: () {
              // リスト番号をリセット
              listNum = 0;
              // コード図鑑のテキストをセット
              setDisplayTexts(index);
              // コード図鑑の内容
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PictureBookPage(
                          index: index,
                        )),
              );
            }),
      );
    } else {
      Purchase p = pictureBooks[index] as Purchase; // 課金クラスにキャスト

      // 課金リスト
      tile = Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: fromCssColor('#CCCCCC')),
          ),
        ),
        child: ListTile(
            title: Text(
              p.title.toString(),
              style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: fromCssColor('#191D33'))),
            ),
            leading: const Icon(
              Icons.key,
              size: 30,
            ),
            trailing: const Icon(
              Icons.arrow_right,
              size: 40,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PurchasePage(
                          index: index,
                        )),
              );
            }),
      );
    }

    return tile;
  }
}
