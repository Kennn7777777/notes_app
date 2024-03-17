import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

@immutable
class Note {
  final String? id;
  final String title;
  final String desc;
  final String color;

  const Note({
    this.id,
    required this.title,
    required this.desc,
    required this.color,
  });

  Note copyWith({
    String? id,
    String? title,
    String? desc,
    String? color,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'color': color,
    };
  }

  factory Note.fromJson(Map<String, dynamic> map) {
    return Note(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      desc: map['desc'] ?? '',
      color: map['color'] ?? '',
    );
  }

  factory Note.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Note(
      id: snapshot['id'] ?? '',
      title: snapshot['title'] ?? '',
      desc: snapshot['desc'] ?? '',
      color: snapshot['color'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Note(id: $id, title: $title, desc: $desc, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.desc == desc &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ desc.hashCode ^ color.hashCode;
  }
}
