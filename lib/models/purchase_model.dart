import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseModel with ChangeNotifier {
  // 購入処理
  Future<void> handlePurchase() async {
    try {
      Offerings offerings = await Purchases.getOfferings(); // Offerings取得
      // Offeringsのnullチェック
      if (offerings.current == null) {
        throw Exception('null Offerings in RevenueCat');
      }
      Package package = offerings.current!.lifetime!; // パッケージ取得
      CustomerInfo customerInfo =
          await Purchases.purchasePackage(package); // 購入処理
      EntitlementInfo? noLimitEntitle =
          customerInfo.entitlements.all['picture_book_no_limit']; // 資格情報があるか？
      // EntitlementInfoのnullチェック
      if (noLimitEntitle == null) {
        throw Exception('null entitlementInfo of limit less in RevenueCat');
      }
      // 資格情報がある場合,
      if (noLimitEntitle.isActive) {
        // アンロック処理
        _setLimit(); // 永続化処理
      } else {
        throw Exception('not entitle');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // リストア処理
  Future<void> handleRestore() async {
    try {
      CustomerInfo restoredInfo = await Purchases.restorePurchases();
      EntitlementInfo? noLimitEntitle =
          restoredInfo.entitlements.all['picture_book_no_limit']; // 資格情報があるか？
      // EntitlementInfoのnullチェック
      if (noLimitEntitle == null) {
        throw Exception('null entitlementInfo of limit less in RevenueCat');
      }
      // 資格情報がある場合,
      if (noLimitEntitle.isActive) {
        // アンロック処理
        _setLimit(); // 永続化処理
      } else {
        throw Exception('not entitle');
      }
    } catch (e) {
      // Error restoring purchases
      throw Exception(e);
    }
  }

  // ****************************************************
  // データ永続化
  // ****************************************************
  // 購入フラグをセット
  Future<void> _setLimit() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); // インスタンス
    // 永続化処理
    prefs.setBool("is_purchase", true);
  }

  // 購入フラグを取得する
  Future<bool> getIsPurchase() async {
    try {
      final SharedPreferences prefs =
          await SharedPreferences.getInstance(); // インスタンス
      bool? p = prefs.getBool("is_purchase"); // 平均正答率を取得
      // nullチェック
      if (p == null) {
        // 初回
        return false;
      }

      return p;
    } catch (e) {
      throw Exception('error not get purchase flg : $e');
    }
  }
}
