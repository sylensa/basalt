import 'package:basalt/helper/helper.dart';
import 'package:flutter/material.dart';

enum PButtonSize { small, medium, large }

class PButton extends StatelessWidget {
  PButton(
      {required this.onPressed,
        required this.text,
        this.isDisabled = false,
        this.color = Colors.black,
        this.buttonSize = PButtonSize.small,
        this.icon,
        this.padding,
        this.textColor = Colors.white,
        this.rounded = true,
        this.textStyle});

  final Function()? onPressed;
  final bool isDisabled;
  final dynamic text;
  final Color color;
  final double? padding;
  final Color textColor;
  final PButtonSize buttonSize;
  final Widget? icon;
  final bool rounded;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isDisabled ? null : onPressed,
      child: Container(
        padding: EdgeInsets.all(padding ?? 10.0),

        width: double.infinity,
        child: Row(
          children: <Widget>[
            icon != null
                ? icon!
                : SizedBox(
              height: 24.0,
            ),
            Expanded(
              child: text is String
                  ? Text(
                text,
                textAlign: TextAlign.center,
                style: appStyle(col: Colors.white),
              )
                  : text,
            ),
          ],
        ),
      ),
      color: color,
      disabledColor: color.withOpacity(0.5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 24.0 : 4.0)),
    );
  }
}
