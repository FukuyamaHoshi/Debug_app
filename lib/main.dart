import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:debug_app/couse_page.dart';
import 'package:debug_app/question_page.dart';
import 'package:debug_app/result_page.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:device_preview/device_preview.dart';

void main() {
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
    return MaterialApp(
      // プレビュー機能
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      //builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      // レスポンシブ対応
      builder: (context, child) =>
          ResponsiveWrapper.builder(child, defaultScale: true),
      home: CousePage(),
    );
  }
}
