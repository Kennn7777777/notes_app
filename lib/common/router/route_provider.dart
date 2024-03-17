import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/common/router/route_names.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/screens/edit_note_screen.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/screens/new_note_screen.dart';

final routeProvider = Provider<GoRouter>((_) {
  return GoRouter(initialLocation: "/", routes: [
    GoRoute(
        path: "/",
        name: RouteNames.home,
        builder: (context, state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: "newnote",
            name: RouteNames.newnote,
            builder: (context, state) {
              return NewNoteScreen();
            },
          ),
          GoRoute(
            path: "editnote",
            name: RouteNames.editnote,
            builder: (context, state) {
              final Note note = state.extra as Note;
              return EditNoteScreen(note: note);
            },
          ),
        ]),
  ]);
});
