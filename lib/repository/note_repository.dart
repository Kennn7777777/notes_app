import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/common/constants/firebase_constants.dart';
import 'package:notes_app/common/providers/firebase_providers.dart';
import 'package:notes_app/models/note_model.dart';

// abstract interface

final noteRepoProvider = Provider((ref) {
  return NoteRepository(
    firestore: ref.read(firestoreProvider),
    noteCollection: ref
        .read(firestoreProvider)
        .collection(FirebaseConstants.noteCollection)
        .withConverter<Note>(
            fromFirestore: (snapshot, _) => Note.fromJson(snapshot.data()!),
            toFirestore: (note, _) => note.toJson()),
  );
});

// final notesProvider = StreamProvider.autoDispose((ref) {
//   return ref.watch(noteRepoProvider).getNotes();
// });

class NoteRepository {
  final FirebaseFirestore firestore;
  final CollectionReference noteCollection;

  NoteRepository({required this.firestore, required this.noteCollection});

  // Create note
  Future<void> createNote(Note note) async {
    try {
      final id = noteCollection.doc().id;
      final newNote = note.copyWith(id: id);
      noteCollection.doc(id).set(newNote);
      // noteCollection.add(data)
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Read notes
  Stream<List<Note>> getNotes() {
    try {
      return noteCollection
          .snapshots()
          .map((event) => event.docs.map<Note>((doc) => doc.data() as Note).toList());

      // return noteCollection.snapshots().map((querySnapshot) => querySnapshot
      //     .docs
      //     .map((queryDocumentSnapshot) => Note.fromSnapshot(
      //         queryDocumentSnapshot as DocumentSnapshot<Map<String, dynamic>>))
      //     .toList());
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Edit note
  Future<void> editNote(Note note) async {
    try {
      noteCollection
          .doc(note.id)
          .withConverter<Note>(
              fromFirestore: (snapshot, _) => Note.fromJson(snapshot.data()!),
              toFirestore: (note, _) => note.toJson())
          .update(note.toJson());
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Delete note
  Future<void> deleteNote(String id) async {
    try {
      noteCollection.doc(id).delete();
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
