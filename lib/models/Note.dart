import 'package:flutter/foundation.dart';

class Note {
  String id;
  String title;
  String description;
  String createdTime;
  int color_id;

  Note(this.title, this.description, this.createdTime, this.color_id,
      {this.id = ''});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      json['title'] as String,
      json['description'] as String,
      json['createdTime'] as String,
      json['color_id'] as int,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdTime': createdTime,
      'color_id': color_id,
    };
  }
}
