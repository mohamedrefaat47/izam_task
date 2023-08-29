import 'package:flutter/material.dart';
import 'package:izam_task/theme/styles.dart';
import 'package:izam_task/utils/custom_widgets/custom_toast/custom_toast.dart';

import 'package:toast/toast.dart';

class Commons {
  static void showToast({required String message, bool isError = false}) {
    return Toast.show(
      message,
      backgroundColor: isError ? Styles.onDangerColor : Styles.onSuccessColor,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
    );
  }

  static OverlayEntry? overlayEntry;

  static void showOverlayToast(
      {required BuildContext cxt,
      required String message,
      ToastType type = ToastType.success}) {
    final overlay = Overlay.of(cxt);

    overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Align(
              alignment: Alignment.bottomCenter,
              child: CustomToast(
                toastMsg: message,
                toastType: type,
              ),
            ));
    overlay.insert(overlayEntry!);

    Future.delayed(const Duration(seconds: 3), () async {
      removeOverlay();
    });
  }

  static removeOverlay() {
    if (overlayEntry != null && overlayEntry!.mounted) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }
}
