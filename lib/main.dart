import 'package:debug_app/models/local_database_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:debug_app/views/home_page.dart';
import 'package:path/path.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sqflite/sqflite.dart';
import 'firebase_options.dart';
import 'models/core_model.dart';
import 'models/indicator_model.dart';
import 'models/picture_book_model.dart';
import 'models/purchase_model.dart';
import 'models/time_model.dart';

void main() async {
  // Firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // SQlite初期化
  await openDatabase(
    join(await getDatabasesPath(), 'questions.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE questions(id INTEGER PRIMARY KEY AUTOINCREMENT, question TEXT, code TEXT, optionA TEXT, optionB TEXT, optionC TEXT, optionD TEXT, answerA TEXT, answerB TEXT)',
      );
    },
    version: 1,
  );

  runApp(
    // プレビュー機能ラップ
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Provider 追加
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoreModel>(create: (context) => CoreModel()),
        ChangeNotifierProvider<TimeModel>(create: (context) => TimeModel()),
        ChangeNotifierProvider<IndicatorModel>(
            create: (context) => IndicatorModel()),
        ChangeNotifierProvider<PictureBookModel>(
            create: (context) => PictureBookModel()),
        ChangeNotifierProvider<LocalDatabaseModel>(
            create: (context) => LocalDatabaseModel()),
        ChangeNotifierProvider<PurchaseModel>(
            create: (context) => PurchaseModel())
      ],
      child: MaterialApp(
        // プレビュー機能
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        //builder: DevicePreview.appBuilder,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),

        // レスポンシブ対応
        builder: (context, child) =>
            ResponsiveWrapper.builder(child, defaultScale: true),
        home: const HomePage(),
      ),
    );
  }
}
