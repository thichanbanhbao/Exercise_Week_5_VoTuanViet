import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../models/note.dart';
import 'note_editor_screen.dart';
import '../widgets/note_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigate(BuildContext context, {Note? note}) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => NoteEditorScreen(note: note)));
  }

  @override
  void initState() {
    super.initState();

    // gọi loadNotes() sau khi build xong frame đầu tiên
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NoteProvider>(context, listen: false).loadNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ghi chú của bạn")),

      body: Consumer<NoteProvider>(
        builder: (context, provider, child) {
          final notes = provider.notes;

          if (notes.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notes, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Chưa có ghi chú nào',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    Text(
                      'Nhấn nút "+" để tạo ghi chú đầu tiên!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return NoteCard(
                note: note,
                onTap: () => _navigate(context, note: note),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigate(context), // tạo ghi chú mới
        child: const Icon(Icons.add),
      ),
    );
  }
}
