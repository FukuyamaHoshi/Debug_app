import 'package:debug_app/purchase/purchase_button.dart';
import 'package:debug_app/purchase/restore_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:purchases_flutter/models/offerings_wrapper.dart';

class UpsellScreen extends StatelessWidget {
  const UpsellScreen({Key? key, required this.offerings}) : super(key: key);
  final Offerings offerings;

  @override
  Widget build(BuildContext context) {
    // DashBoardでcurrent設定のOfferingを取得します。
    final offering = offerings.current;
    if (offering != null) {
      // Offeringに紐づいたPackageを取得します。
      // 今回はCustomタイプのPackageを作成したので、Package名を指定しています。
      // Monthlyなど、デフォルトで用意されているPackageを使う場合は
      // offering.monthlyで取得できます。
      // final noAdsPackage = offering.getPackage('NoAds'); ↓へ変更
      final lifeTimePackage = offering.lifetime;
      if (lifeTimePackage != null) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // 課金アイテムの説明
                const Text('アプリ内の広告が非表示になります'),
                const SizedBox(height: 10),

                // 購入ボタン
                PurchaseButton(
                  package: lifeTimePackage,
                  label: '広告を削除',
                ),
                const SizedBox(height: 30),

                // 復元ボタンのガイド
                const Text('すでにご購入いただいている場合は、下記の復元ボタンをタップしてください'),
                const SizedBox(height: 10),

                // 復元ボタン
                const RestoreButton(),
              ],
            ),
          ),
        );
      }
    }
    return const Center(
      child: Text('Loading...'),
    );
  }
}
