import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  bool get isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Vui lòng nhập tiêu đề!')));
      return;
    }

    final provider = Provider.of<NoteProvider>(context, listen: false);

    if (isEditing) {
      final updatedNote = Note(
        id: widget.note!.id,
        title: title,
        content: content,
        createdAt: widget.note!.createdAt,
        updatedAt: DateTime.now(),
      );
      await provider.updateNote(updatedNote);
    } else {
      final newNote = Note(
        title: title,
        content: content,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await provider.addNote(newNote);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Chỉnh sửa Ghi chú' : 'Tạo Ghi chú Mới'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveNote),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Tiêu đề...',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: TextField(
                controller: _contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Nội dung ghi chú...',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
