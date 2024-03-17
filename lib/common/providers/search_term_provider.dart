import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchTermProvider = NotifierProvider<SearchTerm, String>(SearchTerm.new);

class SearchTerm extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void setSearchTerm(String newSearchTerm) {
    state = newSearchTerm;
  }
}
