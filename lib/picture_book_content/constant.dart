import 'package:debug_app/picture_book.dart';

final constant = PictureBook(
    // タイトル
    title: "定数",
    // エディター
    editor: [
      [''],
      ['//『 const 』で定数の指示をだす', 'const'],
      [
        '// 名前をつけて、データを入れる',
        'const color = "white";',
      ],
      ['// 名前をつけて、データを入れる', 'const color = "white";', 'console.log(color);'],
      ['// 名前をつけて、データを入れる', 'const color = "white";', 'console.log(color);'],
    ],
    // コンソール
    console: [
      [""],
      [""],
      [""],
      [""],
      ["white"],
    ],
    // 説明文
    explan: [
      '変数と似たデータの入れ物を作る機能で、『 定数 』があります。',
      '定数の使い方は変数と似ており、varの代わりに『 const 』を使って指示を出し、',
      'あとは変数と同じように名前をつけて、データを入れます。',
      '定数を出力すると、入れたデータのみが出力されます。'
    ]);
