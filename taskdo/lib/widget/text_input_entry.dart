import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';

class TextInputEntry extends StatelessWidget {
  const TextInputEntry({
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
    required this.hintText,
    this.keyboardType,
    this.minLines,
    this.maxLines,
    this.suffixIcon,
    required this.readOnly,
    required this.controller,
  });

  final Function(String)? onChanged;
   final Function(String)? onFieldSubmitted;
  final String hintText;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextEditingController controller;

  // final FocusNode _focusNode = FocusNode();

  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   _focusNode.requestFocus();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      readOnly: readOnly,
      autocorrect: false,
      // textCapitalization: TextCapitalization.sentences,
      controller: controller,
      // focusNode: _focusNode,
      minLines: minLines,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: AppStyle.kTextInputStyle,
      cursorColor: AppColors.mainColor,
      textInputAction: TextInputAction.newline,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: AppColors.whiteColor,
        filled: true,
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: AppStyle.kHintStyle,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.mainColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.mainColor,
          ),
        ),
      ),
    );
  }
}
