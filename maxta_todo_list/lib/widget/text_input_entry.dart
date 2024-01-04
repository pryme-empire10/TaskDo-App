import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';

class TextInputEntry extends StatefulWidget {
  const TextInputEntry({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.keyboardType,
    this.minLines,
    required this.controller,
  });

  final Function(String) onChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final int? minLines;
  final TextEditingController controller;

  @override
  State<TextInputEntry> createState() => _TextInputEntryState();
}

class _TextInputEntryState extends State<TextInputEntry> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      autocorrect: false,
      textCapitalization: TextCapitalization.sentences,
      controller: widget.controller,
      focusNode: _focusNode,
      minLines: widget.minLines,
      keyboardType: widget.keyboardType,
      maxLines: null,
      style: AppStyle.kTextInputStyle,
      cursorColor: AppColors.mainColor,
      textInputAction: TextInputAction.newline,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: AppColors.greyColor,
        filled: true,
        hintText: widget.hintText,
        hintStyle: AppStyle.kHintStyle,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
