import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionPage extends StatelessWidget {
  QuestionPage({super.key});

  // 問題文
  String question =
      '1, 以下のJavaScriptコードを実行すると、コンソールに「false」と表示されます。バグを修正して、コンソールに「true」と表示されるようにしてください。';

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
          TextButton(
            onPressed: () {},
            child: Text(
              'おわる',
              style: GoogleFonts.zenMaruGothic(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: fromCssColor('#ffffff'))),
            ),
          )
        ],
      ),
      backgroundColor: fromCssColor('#F4F2E4'),

      // 出題ボックス
      body: Container(
        width: double.infinity,
        height: 400,
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

          // もんだい分ボックス
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              color: Colors.red,
              child: Container(
                width: 380,
                height: 150,
                color: fromCssColor('#F4F2E4'),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),

                  // もんだい分
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
          )
        ]),
      ),
    );
  }
}
