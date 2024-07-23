class Diary {
  final int? id;
  final String title;
  final String body;
  final int user_id;

  Diary({
    this.id,
    required this.title,
    required this.body,
    required this.user_id,
  });

  Map<String, Object?> toMap() {
    return {'id': id, 'name': title, 'body': body, 'user_id': user_id};
  }

  factory Diary.fromMap(Map<String, dynamic> map) {
    return Diary(
      id: map['id'],
      title: map['name'],
      body: map['body'],
      user_id: map['user_id'], // Asegúrate de que esto coincida con el nombre de la columna en la base de datos
    );
  }
}
