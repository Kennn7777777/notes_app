import 'package:flutter/material.dart';
import 'package:notes_app/common/constants/app_colors.dart';

class SearchNoteField extends StatefulWidget {
  final Function(String) onChanged;
  final TextEditingController controller;

  const SearchNoteField({
    super.key,
    required this.onChanged,
    required this.controller,
  });

  @override
  State<SearchNoteField> createState() => _SearchNoteFieldState();
}

class _SearchNoteFieldState extends State<SearchNoteField> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.grey,
            contentPadding: EdgeInsets.all(15),
            hintText: "Search your notes...",
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ));
  }
}
