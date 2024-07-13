class User {
  int? id;
  final String name;
  final String lastName;
  final String user;
  final String password;

  User(
      {this.id,
      required this.name,
      required this.lastName,
      required this.user,
      required this.password});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'user': user,
      'password': password
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      lastName: map['lastName'] as String,
      user: map['user'] as String,
      password: map['password'] as String // Asegúrate de que esto coincida con el nombre de la columna en la base de datos
      );
  }
}
