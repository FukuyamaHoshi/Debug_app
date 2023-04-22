// ストア
import '../question.dart';

class Store {
  // インスタンス
  static final Store _instance = Store._internal();

  static const int questionCount = 3; // 出題数
  static int total = 3; // すべての問題数(Firebase内の)
  static List<Question> questions = <Question>[]; // もんだいのデータのリスト
  static int time = 0; // タイマー
  static List<bool> corrects = []; // 問題の正解判定

  // シングルトンへ
  factory Store() {
    return _instance;
  }

  // シングルトンメソッド
  Store._internal();
}
