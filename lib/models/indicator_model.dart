import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

import '../stores/store.dart';

class IndicatorModel with ChangeNotifier {
  // インジケーターの丸を作成する
  Widget createIndicatorCircle(int circleNum) {
    // 出題中の問題
    if (Store.corrects.length == circleNum) {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: fromCssColor('#1CEEED')),
          borderRadius: BorderRadius.circular(15),
          color: Colors.black,
        ),
      );
    }

    // 未出題の問題
    if (Store.corrects.length < circleNum) {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: fromCssColor('#57585A'),
        ),
      );
    }

    // 正解の場合
    if (Store.corrects[circleNum]) {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: fromCssColor('#49DB49'),
        ),
        child: const Icon(Icons.check, color: Colors.white),
      );
    }

    // 不正解の場合
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: fromCssColor('#F04565'),
      ),
      child: const Icon(Icons.close, color: Colors.white),
    );
  }

  // インジケーターの線の作成する
  Widget createIndicatorLine(int lineNum) {
    // 強く表示
    if (Store.corrects.length > lineNum) {
      return Container(
        width: 75,
        height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
        ),
      );
    }

    // 弱く表示
    return Container(
      width: 75,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: fromCssColor('#57585A'),
      ),
    );
  }
}
