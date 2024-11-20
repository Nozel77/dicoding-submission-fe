import 'package:dicoding_submission/utils/themes.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color enabledColor;
  final Color disabledColor;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabledColor = bgButton,
    this.disabledColor = disable,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor:  WidgetStateProperty.all(primaryText),
          backgroundColor: WidgetStateProperty.all(
            onPressed == null ? disabledColor : enabledColor,
          )
        ),

          child: Text(text),),
    );
  }
}
