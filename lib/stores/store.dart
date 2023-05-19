// ストア
import '../question.dart';

class Store {
  // インスタンス
  static final Store _instance = Store._internal();

  static const int questionCount = 3; // 出題数
  static int total = 0; // すべての問題数(SQlite内の)
  static List<Question> questions = <Question>[]; // もんだいのデータのリスト
  static String time = ""; // タイマー(mm:ss)
  static List<bool> corrects = []; // 問題の正解判定
  static String correctRate = ""; // 正解率
  static List<int> questionNums = <int>[]; // もんだい番号のリスト
  static bool isTest = false; // テストフラグ

  // シングルトンへ
  factory Store() {
    return _instance;
  }

  // シングルトンメソッド
  Store._internal();
}
