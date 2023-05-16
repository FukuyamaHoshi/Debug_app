import 'package:debug_app/picture_book.dart';

final strings = PictureBook(
    // タイトル
    title: "文字列",
    // エディター
    editor: [
      [
        '// 『 hello world 』と出力します',
        '// ダブルクォーテーションあり',
        'console.log("hello world");',
      ],
      [
        '// 『 hello world 』と出力します',
        '// ダブルクォーテーションあり',
        'console.log("hello world");',
      ],
      [
        '// 『 hello world 』と出力します',
        '// ダブルクォーテーションなし',
        'console.log(hello world);',
      ],
      [
        '// 『 hello world 』と出力します',
        '// ダブルクォーテーションなし',
        'console.log(hello world);',
      ],
      [
        '// 『 こんにちは世界 』と出力します',
        '// + で連結する',
        'console.log("こんにちは" + "世界");',
      ],
    ],
    // コンソール
    console: [
      [""],
      ["hello world"],
      [""],
      ["[ERR]: Executed JavaScript Failed"],
      [""],
      ["こんにちは世界"],
    ],
    // 説明文
    explan: [
      '文字列は, 『 "○○" 』(ダブルクォーテーション）で囲み使用します。',
      '文字列は, 『 "○○" 』(ダブルクォーテーション）で囲み使用します。',
      'ダブルクォーテーションで囲まないと、エラーとなります。',
      'ダブルクォーテーションで囲まないと、エラーとなります。',
      "文字列は『 ○○ + ○○ 』で連結させることもできます。"
    ]);
