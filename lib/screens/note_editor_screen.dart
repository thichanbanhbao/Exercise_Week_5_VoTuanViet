import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../models/note.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
  }

  void _saveNote(BuildContext context) async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();
    final provider = Provider.of<NoteProvider>(context, listen: false);

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tiêu đề và nội dung không được để trống"),
        ),
      );
      return;
    }

    if (widget.note == null) {
      final newNote = Note(
        title: title,
        content: content,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await provider.addNote(newNote);
    } else {
      final updatedNote = Note(
        id: widget.note!.id,
        title: title,
        content: content,
        createdAt: widget.note!.createdAt,
        updatedAt: DateTime.now(),
      );
      await provider.updateNote(updatedNote);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final actions = widget.note != null
        ? <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await Provider.of<NoteProvider>(
                  context,
                  listen: false,
                ).deleteNote(widget.note!.id!);
                Navigator.pop(context);
              },
            ),
          ]
        : <Widget>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? "Tạo ghi chú" : "Chỉnh sửa ghi chú"),
        actions: actions,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Tiêu đề",
              ),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Nội dung...",
                ),
                style: const TextStyle(fontSize: 18),
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveNote(context),
        child: const Icon(Icons.save),
      ),
    );
  }
}
