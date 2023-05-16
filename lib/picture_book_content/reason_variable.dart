import 'package:debug_app/picture_book.dart';

final reasonVariable = PictureBook(
    // タイトル
    title: "なぜ変数を使用するか",
    // エディター
    editor: [
      [''],
      [
        '// 変数を作る',
        'var myAge = 20',
        '// 自分の年齢を出力する',
        'console.log("ぼくの年齢は" + myAge);',
        '// 自分の姉の年齢を出力する',
        'var sisterAge = myAge + 2;',
        'console.log("姉は" + sisterAge);'
      ],
      [
        '// 自分の名前',
        'var myName = "hoshi";',
        '// 姉の名前',
        'var sisterName = "hizuki";',
        '// 母の名前',
        'var matherName = "miki";'
      ],
      [
        '// 自分の年齢',
        'var myAge = 20;',
        'console.log(myAge);',
        '// 21歳になった',
        'var myAge = 21;',
        'console.log(myAge);',
      ],
    ],
    // コンソール
    console: [
      [""],
      ["僕の年齢は20", "姉は22"],
      [""],
      ["20", "21"],
    ],
    // 説明文
    explan: [
      '変数を使用する理由として、\n①使い回しができる\n②名前がつけれる\n③中身を途中で変えることができる\nがあります。',
      '①使い回しができる\nは、同じデータを何回も使うときに使い回しができるので便利です。',
      '②名前がつけれる\nは、そのデータが何のデータなのかわかりやすくなります。',
      '③中身を途中で変えることができる\nは、使う目的は決まっているけど 『 内容だけ変更 』したいときにすごく便利です',
    ]);
