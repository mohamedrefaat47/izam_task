import 'package:flutter/material.dart';
import 'package:izam_task/theme/styles.dart';

enum ToastType {
  error,
  success,
}

extension ToastTypeExtension on ToastType {
  Color get backgroundColor {
    switch (this) {
      case ToastType.success:
        return Styles.onSuccessColor;
      case ToastType.error:
        return Styles.onDangerColor;

      default:
        return Styles.onSuccessColor;
    }
  }
}

class CustomToast extends StatelessWidget {
  const CustomToast({Key? key, required this.toastMsg, required this.toastType})
      : super(key: key);

  final String toastMsg;
  final ToastType toastType;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          decoration: BoxDecoration(
            color: toastType.backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            toastMsg,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
