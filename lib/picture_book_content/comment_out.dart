import 'package:debug_app/picture_book.dart';

final commentOut = PictureBook(
    // タイトル
    title: "コメントアウト",
    // エディター
    editor: [
      [
        '// あいさつを出力します',
        'console.log("おはよう 世界");',
        'console.log("こんにちは 世界");',
        'console.log("hello world");'
      ],
      [
        '// あいさつを出力します',
        '// console.log("おはよう 世界");',
        'console.log("こんにちは 世界");',
        'console.log("hello world");'
      ],
      [
        '// あいさつを出力します',
        '// console.log("おはよう 世界");',
        '// console.log("こんにちは 世界");',
        'console.log("hello world");'
      ]
    ],
    // コンソール
    console: [
      ["おはよう 世界", "こんにちは 世界", "hello world"],
      ["こんにちは 世界", "hello world"],
      ["hello world"]
    ],
    // 説明文
    explan: [
      "コードの頭に『//』をつけるとコメントになります。メモなどを残したい時に使われます。",
      "コメントはコンソールに出力されません。"
    ]);
