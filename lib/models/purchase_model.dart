import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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

        // 購入おめでとう画面にナビゲーション
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        // 購入エラー処理
      }
    }
  }

  // すでに購入しているか確認
  Future<bool> checkIsPurchase() async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      EntitlementInfo? entitle =
          customerInfo.entitlements.all['picture_book_no_limit']; // 購入情報を取得
      // null チェック
      if (entitle == null) return Future<bool>.value(false); // 購入していない
      if (entitle.isActive) {
        // 購入している
        return Future<bool>.value(true); // 購入している
      }
      // not active
      return Future<bool>.value(false); // 購入していない
    } catch (e) {
      // Error fetching purchaser info
      debugPrint('[error check purchase]');
      debugPrint(e.toString());
      throw Exception(e); // エラー
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
