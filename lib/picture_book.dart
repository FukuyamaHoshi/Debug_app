class PictureBook {
  PictureBook(
      {required this.title,
      required this.editor,
      required this.console,
      required this.explan});

  String title; // タイトル
  List<List<String>> editor; // エディター
  List<List<String>> console; // コンソール
  List<String> explan; // 説明文
}
