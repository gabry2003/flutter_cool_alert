import 'package:cool_alert/cool_alert.dart';
import 'package:cool_alert/src/constants/images.dart';
import 'package:cool_alert/src/models/cool_alert_options.dart';
import 'package:cool_alert/src/widgets/cool_alert_buttons.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CoolAlertContainer extends StatelessWidget {
  final CoolAlertOptions? options;

  const CoolAlertContainer({
    Key? key,
    this.options,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _header = _buildHeader(context);
    final _title = _buildTitle(context);
    final _text = _buildText(context);
    final _buttons = _buildButtons();

    final _content = new Container(
      padding: EdgeInsets.all(20.0),
      child: new Column(
        children: [
          _title,
          new SizedBox(
            height: 5.0,
          ),
          _text,
          new SizedBox(
            height: 10.0,
          ),
          _buttons
        ],
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_header, _content],
      ),
    );
  }

  Widget _buildHeader(context) {
    if (options?.type == CoolAlertType.loading) {
      return new Container();
    } else {
      String? anim = AppAnim.success;

      switch (options?.type) {
        case CoolAlertType.success:
          anim = AppAnim.success;
          break;
        case CoolAlertType.error:
          anim = AppAnim.error;
          break;
        case CoolAlertType.warning:
          anim = AppAnim.warning;
          break;
        case CoolAlertType.confirm:
          anim = AppAnim.info;
          break;
        case CoolAlertType.info:
          anim = AppAnim.info;
          break;
        default:
          anim = AppAnim.info;
      }

      if (options?.flareAsset != null) {
        anim = options?.flareAsset;
      }
      return new Container(
        width: double.infinity,
        decoration: new BoxDecoration(
          color: options?.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular((options?.borderRadius) as double),
            topRight: Radius.circular((options?.borderRadius) as double),
          ),
        ),
        child: new Container(
          height: 150,
          width: 150,
          child: options?.lottieAsset == null
              ? new FlareActor(
                  anim,
                  animation: options?.flareAnimationName,
                )
              : Lottie.asset((options?.lottieAsset) as String),
        ),
      );
    }
  }

  Widget _buildTitle(context) {
    if (options?.type == CoolAlertType.loading) {
      return new Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: new Container(
          height: 100,
          width: 100,
          child: options?.lottieAsset == null
              ? new FlareActor(
                  AppAnim.loading,
                  animation: options?.flareAnimationName,
                )
              : Lottie.asset((options?.lottieAsset) as String),
        ),
      );
    } else {
      String? title = options?.title == null ? _whatTitle() : options?.title;
      return new Text(
        title!,
        style: Theme.of(context).textTheme.headline6?.copyWith(
        	color: options?.textColor
	),
      );
    }
  }

  Widget _buildText(context) {
    if (options?.text == null && options?.type != CoolAlertType.loading) {
      return new Container();
    } else {
      String? text = "";
      if (options?.type == CoolAlertType.loading) {
        text = options?.text ?? "Loading...";
      } else {
        text = options?.text;
      }
      return Text(
        text ?? "",
        textAlign: TextAlign.center,
        style: new TextStyle(
		color: options?.textColor
        )
      );
    }
  }

  Widget _buildButtons() {
    if (options?.type == CoolAlertType.loading) {
      return new Container();
    } else {
      return new CoolAlertButtons(
        options: options,
      );
    }
  }

  String? _whatTitle() {
    switch (options?.type) {
      case CoolAlertType.success:
        return "Success!!!";
      case CoolAlertType.error:
        return "Error!!!";
      case CoolAlertType.warning:
        return "Warning!!!";
      case CoolAlertType.confirm:
        return "Are you sure?";
      case CoolAlertType.info:
        return "Info!";
      case CoolAlertType.loading:
        return null;
      default:
        return null;
    }
  }
}
