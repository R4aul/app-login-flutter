import 'package:flutter/material.dart';
import 'package:login_application/models/user.dart';
import 'package:login_application/models/diary.dart';
import 'package:login_application/db/database_helper.dart';
import 'package:login_application/utils/navigation.dart';
import 'package:login_application/utils/routes.dart';

class ListDiaryView extends StatefulWidget {
  final User user;

  ListDiaryView({
    required this.user,
  });

  @override
  _ListDiaryViewState createState() => _ListDiaryViewState();
}

class _ListDiaryViewState extends State<ListDiaryView> {
  late Future<List<Diary>> _diaries;

  @override
  void initState() {
    super.initState();
    _diaries = _fetchDiaries();
  }

  Future<List<Diary>> _fetchDiaries() async {
    final dbHelper = DatabaseHelper();
    return await dbHelper.getDiariesByUserId(widget.user.id!);
  }

  Future<void> _deleteDiary(int id) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.deleteDiary(id);
    setState(() {
      _diaries = _fetchDiaries(); // Actualiza la lista después de eliminar
    });
  }

  void _editDiary(Diary diary) {
    // Navega a la vista de edición, pasando el diario como argumento
    Navigation.navigateTo(
      Routes.EditDiary, // Asegúrate de tener esta ruta en tu archivo de rutas
      arguments: {'diary',diary},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Diarios'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigation.navigateTo(
                Routes.CreateDiary,
                arguments: {'user',widget.user},
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Diary>>(
        future: _diaries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tienes diarios.'));
          } else {
            final diaries = snapshot.data!;
            return ListView.builder(
              itemCount: diaries.length,
              itemBuilder: (context, index) {
                final diary = diaries[index];
                return ListTile(
                  title: Text(diary.title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.green,
                        onPressed: () => _editDiary(diary),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => _deleteDiary(diary.id!),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}