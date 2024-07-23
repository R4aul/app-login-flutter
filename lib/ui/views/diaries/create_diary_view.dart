import 'package:flutter/material.dart';
import 'package:login_application/models/user.dart';
import 'package:login_application/models/diary.dart'; // Asegúrate de que Diary esté importado
import 'package:login_application/db/database_helper.dart'; // Asegúrate de que DatabaseHelper esté importado
import 'package:login_application/utils/navigation.dart';
import 'package:login_application/utils/routes.dart';

class CreateDiaryView extends StatefulWidget {
  final User user;

  CreateDiaryView({
    required this.user,
  });

  @override
  _CreateDiaryView createState() => _CreateDiaryView();
}

class _CreateDiaryView extends State<CreateDiaryView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bodyController = TextEditingController();

  Future<void> _saveDiary() async {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text;
      final body = _bodyController.text;
      
      // Crear una instancia de Diary
      final diary = Diary(
        title: name,
        body: body,
        user_id: widget.user.id!,
      );

      // Insertar el diario en la base de datos
      final dbHelper = DatabaseHelper();
      await dbHelper.insertDiary(diary);

      // Volver a la vista anterior
      Navigation.navigateTo(Routes.MyDiary, arguments: {'user', widget.user});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Diario'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Crear Diario para ${widget.user.name}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El nombre es requerido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _bodyController,
                      decoration: InputDecoration(
                        labelText: 'Contenido',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El contenido es requerido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _saveDiary,
                      child: Text('Guardar Diario'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
