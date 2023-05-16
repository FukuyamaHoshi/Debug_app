import 'package:debug_app/purchase/upsel_screen.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class IAPScreen extends StatefulWidget {
  const IAPScreen({super.key});

  @override
  IAPScreenState createState() => IAPScreenState();
}

class IAPScreenState extends State<IAPScreen> {
  CustomerInfo? _purchaserInfo;
  Offerings? _offerings;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // 初期化処理
  // 購入情報・Offeringsの取得を行う
  Future<void> initPlatformState() async {
    // デバッグモードでログを出力
    await Purchases.setLogLevel(LogLevel.debug);

    // SDK Keyは RevenueCatの各アプリのAPI Keysから取得できます。
    // アプリで使用しているユーザーIDと紐づける場合は、
    // await Purchases.setup("public_sdk_key", appUserId: "my_app_user_id");
    await Purchases.configure(
        PurchasesConfiguration('appl_wsBLnOIBHwObHZuDisKTfdRisld'));

    final purchaserInfo = await Purchases.getCustomerInfo();
    final offerings = await Purchases.getOfferings(); // 購入アイテムの取得

    if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
      _offerings = offerings;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_purchaserInfo == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('課金画面')),
        body: const Center(
          child: Text('Loading...'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('課金画面'),
      ),
      body: UpsellScreen(
        offerings: _offerings!,
      ),
    );
  }
}
