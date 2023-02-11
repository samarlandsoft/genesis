import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis/core/constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final String? errorText;
  final bool showError;
  final int maxLength;

  const TextInputField({
    Key? key,
    required this.controller,
    this.focusNode,
    required this.hintText,
    this.errorText,
    this.showError = false,
    this.maxLength = 100,
  }) : super(key: key);

  static const inputFiledHeight = 140.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: inputFiledHeight,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: StyleConstants.kGetDarkColor(),
          hintText: hintText,
          errorText: showError ? errorText : null,
          errorMaxLines: 1,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: StyleConstants.kHyperLinkColor,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: StyleConstants.kGetLightColor().withOpacity(0.3),
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.withOpacity(0.5),
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
        inputFormatters: [
          _LengthLimitingTextFieldFormatterFixed(maxLength),
        ],
        minLines: 3,
        maxLength: maxLength,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}

class _LengthLimitingTextFieldFormatterFixed
    extends LengthLimitingTextInputFormatter {
  _LengthLimitingTextFieldFormatterFixed(int maxLength) : super(maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength != null &&
        maxLength! > 0 &&
        newValue.text.characters.length > maxLength!) {
      if (oldValue.text.characters.length == maxLength) {
        return oldValue;
      }
      return LengthLimitingTextInputFormatter.truncate(newValue, maxLength!);
    }
    return newValue;
  }
}
