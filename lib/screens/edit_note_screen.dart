import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/common/constants/app_colors.dart';
import 'package:notes_app/common/providers/note_list_provider.dart';
import 'package:notes_app/common/widgets/note_text_formfield.dart';
import 'package:notes_app/repository/note_repository.dart';

import '../models/note_model.dart';

class EditNoteScreen extends ConsumerStatefulWidget {
  final Note note;
  EditNoteScreen({super.key, required this.note});

  @override
  ConsumerState<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends ConsumerState<EditNoteScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late int selectedPalette;

  @override
  void initState() {
    super.initState();
    final int value = int.parse(widget.note.color);
    selectedPalette = AppColors.palette.indexOf(Color(value));

    _titleController = TextEditingController(text: widget.note.title);
    _descController = TextEditingController(text: widget.note.desc);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _editNote(BuildContext context) async {
    final noteList = ref.read(noteListProvider.notifier);

    final newNote = Note(
        id: widget.note.id,
        title: _titleController.text.trim(),
        desc: _descController.text.trim(),
        color: AppColors.palette[selectedPalette].value.toString());

    try {
      await noteList.editNote(newNote);
      // TODO: Toast message
      if (mounted) Navigator.of(context).pop();
    } on FirebaseException catch (e) {
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit note"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () => _editNote(context),
            child: const Text("Edit"),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                child: Column(
                  children: [
                    // title textfield
                    NoteTextFormField(
                      controller: _titleController,
                      hintText: "Title",
                    ),
                    const SizedBox(height: 20),
                    // description textfield
                    NoteTextFormField(
                      controller: _descController,
                      hintText: "Type your description here...",
                      maxLines: 10,
                      showWordCount: true,
                    ),
                  ],
                ),
              ),
            ),

            // color palatte
            SizedBox(
              height: 80,
              child: ListView.separated(
                  itemCount: AppColors.palette.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final paletteColor = AppColors.palette[index];

                    return GestureDetector(
                      onTap: () => setState(() {
                        selectedPalette = index;
                      }),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 4.0,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: selectedPalette == index ? Colors.white : Colors.transparent),
                          color: paletteColor,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
