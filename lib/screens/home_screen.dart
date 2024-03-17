import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/common/constants/app_colors.dart';
import 'package:notes_app/common/providers/note_list_provider.dart';
import 'package:notes_app/common/providers/search_term_provider.dart';
import 'package:notes_app/common/router/route_names.dart';
import 'package:notes_app/common/widgets/search_note_field.dart';
import 'package:notes_app/common/widgets/single_note.dart';
import 'package:notes_app/models/note_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  void onChanged(String query) {
    ref.read(searchTermProvider.notifier).setSearchTerm(query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Note> filterList(List<Note> noteList) {
    final searchTerm = ref.watch(searchTermProvider);

    List<Note> tempList = noteList;

    if (searchTerm.isNotEmpty) {
      tempList = noteList.where((note) => note.title.toLowerCase().contains(searchTerm.toLowerCase())).toList();
    }

    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Consumer(
                builder: (context, ref, child) {
                  print("rebuild");
                  final notes = ref.watch(noteListProvider);
                  // final filterNotes = ref.watch(filterListProvider);

                  return notes.when(
                      data: (notes) {
                        final filteredList = filterList(notes);

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              child!,
                              Align(
                                alignment: Alignment.topCenter,
                                child: Wrap(
                                  children: filteredList.map((note) {
                                    return SingleNote(
                                      note: note,
                                      onTap: () {
                                        context.pushNamed(RouteNames.editnote, extra: note);
                                      },
                                      onLongPress: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: AppColors.dialog,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                title: Text("Delete"),
                                                content: Text("Are you sure you want to delete this note?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        context.pop();
                                                      },
                                                      child: Text("Cancel")),
                                                  TextButton(
                                                    onPressed: () {
                                                      ref.read(noteListProvider.notifier).deleteNote(note.id!);
                                                      context.pop();
                                                    },
                                                    child: Text("Delete"),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      error: (error, _) {
                        return Container(child: Center(child: Text(error.toString())));
                      },
                      loading: () => const Center(child: CircularProgressIndicator()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: SearchNoteField(
                    onChanged: onChanged,
                    controller: _searchController,
                  ),
                ))),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.pushNamed(RouteNames.newnote),
          child: Icon(Icons.add),
        ));
  }
}
