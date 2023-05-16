import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RestoreButton extends StatefulWidget {
  const RestoreButton({super.key});

  @override
  RestoreButtonState createState() => RestoreButtonState();
}

class RestoreButtonState extends State<RestoreButton> {
  bool? _restoring;

  @override
  void initState() {
    super.initState();
    setState(() {
      _restoring = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.all(10), backgroundColor: Colors.grey),
        onPressed: () async {
          try {
            setState(() {
              _restoring = true;
            });

            // 過去の購入情報を取得
            final restoredInfo = await Purchases.restorePurchases();

            if (restoredInfo.entitlements.all['picture_book_no_limit'] !=
                    null &&
                restoredInfo
                    .entitlements.all['picture_book_no_limit']!.isActive) {
              // 復元完了時の処理を記載
              // ...

              // 復元完了のポップアップ
              // var result = await showDialog<int>(
              //   context: context,
              //   barrierDismissible: false,
              //   builder: (BuildContext context) {
              //     return AlertDialog(
              //       title: const Text('確認'),
              //       content: Text('復元が完了しました。'),
              //       actions: <Widget>[
              //         TextButton(
              //           child: const Text('OK'),
              //           onPressed: () => Navigator.of(context).pop(1),
              //         ),
              //       ],
              //     );
              //   },
              // );
              debugPrint("restore complete");
            } else {
              // 購入情報が見つからない場合
              // var result = await showDialog<int>(
              //   context: context,
              //   barrierDismissible: false,
              //   builder: (BuildContext context) {
              //     return AlertDialog(
              //       title: const Text('確認'),
              //       content: const Text('過去の購入情報が見つかりませんでした。アカウント情報をご確認ください。'),
              //       actions: <Widget>[
              //         TextButton(
              //           child: const Text('OK'),
              //           onPressed: () => Navigator.of(context).pop(1),
              //         ),
              //       ],
              //     );
              //   },
              // );
              debugPrint("not find restore data");
            }
            setState(() {
              _restoring = false;
            });
          } on PlatformException catch (e) {
            setState(() {
              _restoring = false;
            });
            final errorCode = PurchasesErrorHelper.getErrorCode(e);
            debugPrint('errorCode: $errorCode');
          }
        },
        child: SizedBox(
          width: 200,
          child: Center(
            child: Text(
              _restoring! ? '復元中' : '復元',
            ),
          ),
        ));
  }
}
