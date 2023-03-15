import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionPage extends StatelessWidget {
  QuestionPage({super.key});

  // 問題文
  String question =
      '1, 以下のJavaScriptコードを実行すると、コンソールに「false」と表示されます。バグを修正して、コンソールに「true」と表示されるようにしてください。';
  // コード
  String code = 'var x = 10;\nx = x + 10;\nconsole.log(x);';
  // 選択肢A
  String optionA = 'typeof演算子で、nullの型はオブジェクトであるため、バグが発生しています。';
  // 選択肢B
  String optionB = 'typeof演算子で、nullの型はオブジェクトであるため、バグが発生しています。';
  // 選択肢C
  String optionC = 'typeof演算子で、nullの型はオブジェクトであるため、バグが発生しています。';

  @override
  Widget build(BuildContext context) {
    // スクリーンの高さ
    double screeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: Text(
          'codegen',
          style: GoogleFonts.zenMaruGothic(
              textStyle: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: fromCssColor('#ffffff'))),
        ),
        backgroundColor: fromCssColor('#96D6AE'),
        elevation: 0,
        automaticallyImplyLeading: false, // もどるボタンを許可しない
        // おわるボタン設置
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'おわる',
                style: GoogleFonts.zenMaruGothic(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: fromCssColor('#ffffff'))),
              ),
            ),
          )
        ],
      ),
      backgroundColor: fromCssColor('#F4F2E4'),

      // 出題ボックス
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 430,
            color: fromCssColor('#EAE3C9'),
            alignment: Alignment.topCenter,
            child: Column(children: [
              const Padding(padding: EdgeInsets.only(top: 10)),

              // もんだいテキスト
              Text(
                'もんだい',
                style: GoogleFonts.zenMaruGothic(
                    textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: fromCssColor('#4E3703'))),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),

              // もんだい文ボックス
              Container(
                color: Colors.red,
                child: Container(
                  width: 380,
                  height: 150,
                  color: fromCssColor('#F4F2E4'),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),

                    // もんだい分を表示
                    child: Text(
                      question,
                      style: GoogleFonts.zenMaruGothic(
                          textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#77694A'))),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),

              // エディターの上タブ
              Container(
                width: 400,
                height: 30,
                color: fromCssColor('#343541'),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'javascript',
                    style:
                        TextStyle(color: fromCssColor('#ffffff'), fontSize: 14),
                  ),
                ),
              ),

              // エディター
              Container(
                width: 400,
                height: 180,
                color: fromCssColor('#0F161F'),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 20, right: 20, bottom: 10.0),

                  // コードを表示
                  child: Text(
                    code,
                    style: GoogleFonts.robotoMono(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: fromCssColor('#33E51C'))),
                  ),
                ),
              ),
            ]),
          ),

          // 答えのサブタイトル
          if (screeHeight > 850) // SEの場合は表示しない(レスポンシブ対応)
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 20.0),
                child: Text(
                  'どれが答え？',
                  style: GoogleFonts.zenMaruGothic(
                      textStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: fromCssColor('#4E3703'))),
                ),
              ),
            ),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          // 選択肢A
          Stack(alignment: Alignment.center, children: [
            // 外
            Container(
              width: 400,
              height: 85,
              decoration: BoxDecoration(
                  color: fromCssColor('#BCDF8A'),
                  borderRadius: BorderRadius.circular(5)),
            ),

            // 内
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // アルファベットボックス
                Container(
                  width: 45,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: fromCssColor('#80C03A'),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'A',
                    style: GoogleFonts.zenMaruGothic(
                        textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: fromCssColor('#BCDF8A'))),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 8.0)),

                // 選択肢文ボックス
                Container(
                  width: 330,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: fromCssColor('#F4F2E4'),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),

                    // 選択肢Aを表示
                    child: Text(
                      optionA,
                      style: GoogleFonts.zenMaruGothic(
                          textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#4E3703'))),
                    ),
                  ),
                ),
              ],
            ),
          ]),
          const Padding(padding: EdgeInsets.only(top: 8.0)),

          // 選択肢B
          Stack(alignment: Alignment.center, children: [
            // 外
            Container(
              width: 400,
              height: 85,
              decoration: BoxDecoration(
                  color: fromCssColor('#A2D0D3'),
                  borderRadius: BorderRadius.circular(5)),
            ),

            // 内
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // アルファベットボックス
                Container(
                  width: 45,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: fromCssColor('#54A7AF'),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'B',
                    style: GoogleFonts.zenMaruGothic(
                        textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: fromCssColor('#A2D0D3'))),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 8.0)),

                // 選択肢文ボックス
                Container(
                  width: 330,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: fromCssColor('#F4F2E4'),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),

                    // 選択肢Bを表示
                    child: Text(
                      optionB,
                      style: GoogleFonts.zenMaruGothic(
                          textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#4E3703'))),
                    ),
                  ),
                ),
              ],
            ),
          ]),
          const Padding(padding: EdgeInsets.only(top: 8.0)),

          // 選択肢C
          Stack(alignment: Alignment.center, children: [
            // 外
            Container(
              width: 400,
              height: 85,
              decoration: BoxDecoration(
                  color: fromCssColor('#DFA7A2'),
                  borderRadius: BorderRadius.circular(5)),
            ),

            // 内
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // アルファベットボックス
                Container(
                  width: 45,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: fromCssColor('#C3615E'),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'C',
                    style: GoogleFonts.zenMaruGothic(
                        textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: fromCssColor('#DFA7A2'))),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 8.0)),

                // 選択肢文ボックス
                Container(
                  width: 330,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: fromCssColor('#F4F2E4'),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),

                    // 選択肢Cを表示
                    child: Text(
                      optionC,
                      style: GoogleFonts.zenMaruGothic(
                          textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: fromCssColor('#4E3703'))),
                    ),
                  ),
                ),
              ],
            ),
          ])
        ],
      ),
    );
  }
}
