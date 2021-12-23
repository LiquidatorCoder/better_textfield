import 'package:flutter/material.dart';

class BetterTextfield extends StatelessWidget {
  const BetterTextfield({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return EditableText(
      controller: controller,
      focusNode: FocusNode(),
      style: const TextStyle(),
      cursorColor: Colors.black,
      backgroundCursorColor: Colors.black12,
      showCursor: true,
      toolbarOptions: const ToolbarOptions(
        copy: true,
        cut: true,
        paste: true,
        selectAll: true,
      ),
    );
  }
}
