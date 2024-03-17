import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/common/providers/note_list_provider.dart';
import 'package:notes_app/common/providers/search_term_provider.dart';
import 'package:notes_app/models/note_model.dart';

final filterListProvider = Provider.autoDispose.family<List<Note>, List<Note>>((ref, noteList) {
  final searchTerm = ref.watch(searchTermProvider);

  List<Note> tempList = noteList;

  if (searchTerm.isNotEmpty) {
    tempList = noteList.where((note) => note.title.toLowerCase().contains(searchTerm.toLowerCase())).toList();
  }

  return tempList;
});
