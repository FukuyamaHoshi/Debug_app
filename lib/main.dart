import 'package:debug_app/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:debug_app/couse_page.dart';
import 'package:debug_app/question_page.dart';
import 'package:debug_app/result_page.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
      providers: [ChangeNotifierProvider<Model>(create: (context) => Model())],
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
        home: const CousePage(),
      ),
    );
  }
}
