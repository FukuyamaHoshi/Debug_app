import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseButton extends StatelessWidget {
  const PurchaseButton({Key? key, required this.package, required this.label})
      : super(key: key);
  final Package package;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.all(10), backgroundColor: Colors.grey),
      onPressed: () async {
        try {
          // 購入処理
          final purchaserInfo = await Purchases.purchasePackage(package);
          final isNoAds =
              purchaserInfo.entitlements.all['picture_book_no_limit']!.isActive;
          if (isNoAds) {
            // 購入完了時の処理
            // ...
            debugPrint('User purchase success');
          }
        } on PlatformException catch (e) {
          final errorCode = PurchasesErrorHelper.getErrorCode(e);
          if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
            debugPrint('User cancelled');
          } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
            debugPrint('User not allowed to purchase');
          }
        }
      },
      child: SizedBox(
          width: 200,
          child: Center(
              child: Text('$label   (${package.storeProduct.priceString})'))),
    );
  }
}
