import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/repository/note_repository.dart';

final noteListProvider = StreamNotifierProvider.autoDispose<NoteList, List<Note>>(NoteList.new);

class NoteList extends AutoDisposeStreamNotifier<List<Note>> {
  Stream<List<Note>> _getNotes() {
    final noteRepo = ref.watch(noteRepoProvider);
    return noteRepo.getNotes();
  }

  @override
  Stream<List<Note>> build() {
    return _getNotes();
  }

  // create
  Future<void> createNote(Note note) {
    return ref.read(noteRepoProvider).createNote(note);
  }

  // update
  Future<void> editNote(Note note) {
    // state = const AsyncLoading();
    return ref.read(noteRepoProvider).editNote(note);
  }

  // delete
  Future<void> deleteNote(String id) {
    return ref.read(noteRepoProvider).deleteNote(id);
  }
}
