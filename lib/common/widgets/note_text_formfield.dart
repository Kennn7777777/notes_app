import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/app_colors.dart';

class NoteTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double fontSize;
  final int maxLines;
  final int maxLength;
  final bool showWordCount;

  const NoteTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.fontSize = 16,
    this.maxLines = 1,
    this.maxLength = 20,
    this.showWordCount = false,
  });

  @override
  State<NoteTextFormField> createState() => _NoteTextFormFieldState();
}

class _NoteTextFormFieldState extends State<NoteTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      TextFormField(
        controller: widget.controller,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: widget.fontSize),
          counterText: "",
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: AppColors.grey,
        ),
        onChanged: (value) => {setState(() {})},
      ),
      widget.showWordCount
          ? Positioned(
              right: 10,
              bottom: 5,
              child:
                  Text("${widget.controller.text.length}/${widget.maxLength}"),
            )
          : SizedBox.shrink(),
    ]);
  }
}
