import 'package:debug_app/picture_book.dart';

final variable = PictureBook(
    // タイトル
    title: "変数",
    // エディター
    editor: [
      [''],
      ['// ①『 var 』で変数の指示をだす', 'var'],
      [
        '// ②名前をつける',
        'var name',
      ],
      [
        '//③『 = 』でデータを入れる',
        'var name = "start app";',
      ],
      [
        '// 変数を出力する',
        'var name = "start app";',
        'console.log(name);',
      ],
    ],
    // コンソール
    console: [
      [""],
      [""],
      [""],
      [""],
      ["start app"],
    ],
    // 説明文
    explan: [
      '変数とは、\nデータ（文字列や数字）の『 入れ物 』を作ることができる機能のことです。',
      '変数の使い方は、\nまず①『 var 』と言う文字でこれは変数ですと指示をだし、',
      '②名前をつけて（名前は自由に決められます）',
      '③『 = 』でデータを入れます',
      '変数を出力すると、③で入れたデータのみが出力されます。'
    ]);
