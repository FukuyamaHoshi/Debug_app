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
  @override
  Widget build(BuildContext context) {
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

                    // もんだいを表示
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
                        TextStyle(color: fromCssColor('#ffffff'), fontSize: 13),
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

          // 答えAのボックス(ボタンにする？？)
        ],
      ),
    );
  }
}
