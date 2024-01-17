import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:noteapputs/models/Note.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class NoteOperation extends ChangeNotifier {
  List<Note> _notes = <Note>[];

  List<Note> get getNotes {
    return _notes;
  }

  Future<void> addNewNote(
      String title, String description, int color_id) async {
    final note = Note(
      title,
      description,
      DateFormat.yMMMEd().format(DateTime.now()).toString(),
      color_id,
      id: const Uuid().v4(),
    );
    _notes.add(note);
    await saveNotes();
    notifyListeners();
  }

  Future<void> removeNote(String id) async {
    final index = _notes.indexWhere((element) => element.id == id);
    _notes.removeAt(index);
    await saveNotes();
    notifyListeners();
  }

  Future<void> editNote(
      String id, String newTitle, String newDescription) async {
    final index = _notes.indexWhere((element) => element.id == id);

    if (index != -1) {
      _notes[index].title = newTitle;
      _notes[index].description = newDescription;
      _notes[index].createdTime =
          DateFormat.yMMMEd().format(DateTime.now()).toString();

      await saveNotes();
      notifyListeners();
    }
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = _notes.map((note) => note.toJson()).toList();
    await prefs.setString('notes', json.encode(notesJson));
  }

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString('notes');
    if (notesJson != null) {
      final List<dynamic> notesList = json.decode(notesJson);
      _notes = notesList.map((json) => Note.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
