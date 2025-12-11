class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };

    // Chỉ thêm id nếu tồn tại (khi Update)
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] is int ? map['id'] : int.tryParse(map['id'].toString()),
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
