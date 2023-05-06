import 'dart:math';
import 'package:debug_app/output_console.dart';
import 'package:debug_app/picture_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';

// コード図鑑
class PictureBookModel with ChangeNotifier {
  final List<PictureBook> pictureBooks = [outputConsole]; // 図鑑クラス配列
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
    // コンソール
    console = _getConsoleWidght(pictureBooks[index].console);
    // 説明文
    if (pictureBooks[index].explan.length - 1 < listNum) {
      // リスト番号の方が大きい(レンジエラー)の場合、
      explan =
          pictureBooks[index].explan[pictureBooks[index].explan.length - 1];
    } else {
      // リスト番号が小さい
      explan = pictureBooks[index].explan[listNum];
    }

    // リストの最大値と現在のリスト番号を揃える
    _ajustListNum(pictureBooks[index].editor.length,
        pictureBooks[index].console.length, pictureBooks[index].explan.length);

    notifyListeners(); // UI更新
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

  // リストの最大値と現在のリスト番号を揃える
  void _ajustListNum(int a, int b, int c) {
    int m = [a, b, c].reduce(max); // 最大値
    if (m == listNum) {
      // 最大値とリスト番号が違う(想定では下)の場合、
      return;
    } else {
      // 同じの場合、
      listNum = m - 1;
    }
  }
}
