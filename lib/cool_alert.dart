library cool_alert;

import 'package:flutter/material.dart';
import 'src/models/cool_alert_options.dart';
import 'src/utils/animate.dart';
import 'src/widgets/cool_alert_container.dart';

enum CoolAlertType { success, error, warning, confirm, info, loading }
enum CoolAlertAnimType {
  scale,
  rotate,
  slideInDown,
  slideInUp,
  slideInLeft,
  slideInRight,
}

/// CoolAlert.
class CoolAlert {
  static Future show({
    /// BuildContext
    required BuildContext context,

    /// Title of the dialog
    String? title,

    /// Text of the dialog
    String? text,
    required CoolAlertType type,
    CoolAlertAnimType animType = CoolAlertAnimType.scale,
    bool barrierDismissible = true,
    VoidCallback? onConfirmBtnTap,
    VoidCallback? onCancelBtnTap,
    String confirmBtnText = "Ok",
    String cancelBtnText = "Cancel",
    Color confirmBtnColor = const Color(0xFF3085D6),
    TextStyle? confirmBtnTextStyle,
    TextStyle? cancelBtnTextStyle,
    bool showCancelBtn = false,
    double borderRadius = 10.0,
    Color backgroundColor = const Color(0xFF515C6F),
    Color textColor = Colors.black,
    String? flareAsset,
    String flareAnimationName = "play",
    String? lottieAsset,
  }) {
    CoolAlertOptions options = new CoolAlertOptions(
      title: title,
      text: text,
      type: type,
      animType: animType,
      barrierDismissible: barrierDismissible,
      onConfirmBtnTap: onConfirmBtnTap,
      onCancelBtnTap: onCancelBtnTap,
      confirmBtnText: confirmBtnText,
      cancelBtnText: cancelBtnText,
      confirmBtnColor: confirmBtnColor,
      confirmBtnTextStyle: confirmBtnTextStyle,
      cancelBtnTextStyle: cancelBtnTextStyle,
      showCancelBtn: showCancelBtn,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      textColor: textColor,
      flareAsset: flareAsset,
      flareAnimationName: flareAnimationName,
      lottieAsset: lottieAsset,
    );

    Widget child = new AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      content: new CoolAlertContainer(
        options: options,
      ),
    );
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, anim1, anim2, widget) {
        switch (animType) {
          case CoolAlertAnimType.scale:
            return Animate.scale(child: child, animation: anim1);
          case CoolAlertAnimType.rotate:
            return Animate.rotate(child: child, animation: anim1);
          case CoolAlertAnimType.slideInDown:
            return Animate.slideInDown(child: child, animation: anim1);
          case CoolAlertAnimType.slideInUp:
            return Animate.slideInUp(child: child, animation: anim1);
          case CoolAlertAnimType.slideInLeft:
            return Animate.slideInLeft(child: child, animation: anim1);
          case CoolAlertAnimType.slideInRight:
            return Animate.slideInRight(child: child, animation: anim1);
          default:
            return child;
        }
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      context: context,
      pageBuilder: (BuildContext context, Animation<double> anim1, Animation<double> anim2) => null as Widget,
    );
  }
}
