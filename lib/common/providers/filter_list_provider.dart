// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:notes_app/common/providers/note_list_provider.dart';
// import 'package:notes_app/common/providers/search_term_provider.dart';
// import 'package:notes_app/models/note_model.dart';

// final filterListProvider = FutureProvider.autoDispose<List<Note>>((ref) async {
//   final searchTerm = ref.watch(searchTermProvider);
//   final noteList = await ref.watch(noteListProvider.future);

//   List<Note> tempList = noteList;

//   if (searchTerm.isNotEmpty) {
//     tempList = noteList
//         .where((note) => note.title.toLowerCase().contains(searchTerm.toLowerCase()))
//         .toList();
//   }

//   return tempList;
// });
