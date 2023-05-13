import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:debug_app/question.dart';
import 'package:debug_app/question_content/question_content.dart';

import '../stores/store.dart';

class LocalDatabaseModel with ChangeNotifier {
  // もんだいの個数を取得
  Future<void> getQuestionsSize() async {
    Database db = await openDatabase('questions.db'); // データベース
    // クエリ数を取得
    await db.query('questions').then(
      (res) {
        Store.total = res.length;
      },
      onError: (e) {
        debugPrint("error getQuestionSize: $e");
      },
    );
    debugPrint("question total count ${Store.total}");
  }

  // バージョン情報をセットし、問題のバッチ処理
  Future<void> setVersionAndBatch() async {
    // 永続化
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); // インスタンス
    String? local = prefs.getString("version"); // 保存データのバージョンを取得

    //pubspec.yamlの情報を取得する
    PackageInfo packageInfo = await PackageInfo.fromPlatform(); // 参照
    String pubVersion = packageInfo.version; // バージョン情報

    // バージョン情報を永続化し、問題を作成 or 更新する
    if (local == null) {
      //初回の場合、
      prefs.setString("version", pubVersion); // pubspec.yamlの情報をセット
      await _batchQuestions(); // 問題データを更新
      debugPrint("『 add 』questions data to Sqlite");
    } else {
      //すでにある場合、
      if (local != pubVersion) {
        //保存したデータとpubspec.yamlのデータが違う場合,(バージョンアップ直後)
        prefs.setString("version", pubVersion); // pubspec.yamlの情報をセット
        await _deleteQuestions(); // 問題データをすべて削除
        await _batchQuestions(); // 問題データを更新
        debugPrint("『 update 』 questions data to Sqlite");
      }
    }
  }

  // json型の問題をデータベース(Sqlite)にセット(バッチ)する
  Future<void> _batchQuestions() async {
    Database db = await openDatabase('questions.db'); // データベース

    // SQliteに問題データを挿入する
    Batch batch = db.batch(); // バッチインスタンス作成
    // すべての問題の配列を作成
    for (Map<String, String> content in questionContents) {
      Question q = Question(
          question: content['question'].toString(),
          code: content['code'].toString(),
          optionA: content['optionA'].toString(),
          optionB: content['optionB'].toString(),
          optionC: content['optionC'].toString(),
          optionD: content['optionD'].toString(),
          answerA: content['answerA'].toString(),
          answerB: content['answerB'].toString());

      batch.insert('questions', q.toMap()); // データを挿入
    }

    await batch.commit(); // コミット
  }

  // 問題のデータをすべて削除する
  Future<void> _deleteQuestions() async {
    Database db = await openDatabase('questions.db'); // データベース

    await db.delete('questions'); // データ削除
  }

  // 出題する問題をセットする
  Future<void> setQuestions() async {
    Database db = await openDatabase('questions.db'); // データベース
    // 問題をすべて取得
    await db.query('questions').then(
      (List<Map<String, dynamic>> maps) {
        // すべての問題のリストを作成
        List<Question> questionAll = List.generate(maps.length, (i) {
          return Question(
              question: maps[i]['question'],
              code: maps[i]['code'],
              optionA: maps[i]['optionA'],
              optionB: maps[i]['optionB'],
              optionC: maps[i]['optionC'],
              optionD: maps[i]['optionD'],
              answerA: maps[i]['answerA'],
              answerB: maps[i]['answerB']);
        });

        // 出題リストに追加
        for (int num in Store.questionNums) {
          Store.questions.add(questionAll[num]);
        }
      },
      onError: (e) {
        debugPrint("error setQuestions: $e");
      },
    );

    debugPrint('set questions data');
  }
}
