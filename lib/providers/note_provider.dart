import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future<void> LoadNotes() async {
    _notes = await DatabaseHelper.instance.readAll();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await DatabaseHelper.instance.create(note);
    await LoadNotes();
  }

  Future<void> updateNote(Note note) async {
    await DatabaseHelper.instance.update(note);
    await LoadNotes(); // Tải lại danh sách để cập nhật UI
  }

  // HÀM BỔ SUNG: Xóa ghi chú (nên có)
  Future<void> deleteNote(int id) async {
    await DatabaseHelper.instance.delete(id);
    await LoadNotes(); // Tải lại danh sách để cập nhật UI
  }
}
