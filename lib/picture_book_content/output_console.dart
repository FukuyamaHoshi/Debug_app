import 'package:debug_app/picture_book.dart';

final outputConsole = PictureBook(
    // タイトル
    title: "コンソールへ出力",
    // エディター
    editor: [
      ['console.log("hellow world")']
    ],
    // コンソール
    console: [
      [""],
      ["hello world"]
    ],
    // 説明文
    explan: [
      "console.log(○○);で、○○の部分に文字や数字を入力するとコンソールに出力される。"
    ]);
