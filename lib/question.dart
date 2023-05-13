class Question {
  String question;
  String code;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String answerA;
  String answerB;

  Question(
      {required this.question,
      required this.code,
      required this.optionA,
      required this.optionB,
      required this.optionC,
      required this.optionD,
      required this.answerA,
      required this.answerB});

  // Map型へ変換する
  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'code': code,
      'optionA': optionA,
      'optionB': optionB,
      'optionC': optionC,
      'optionD': optionD,
      'answerA': answerA,
      'answerB': answerB,
    };
  }
}
