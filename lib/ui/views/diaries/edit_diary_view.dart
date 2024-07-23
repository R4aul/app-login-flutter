import 'package:flutter/material.dart';
import 'package:login_application/models/diary.dart';
import 'package:login_application/db/database_helper.dart';

class EditDiaryView extends StatefulWidget {
  final Diary diary;

  EditDiaryView({required this.diary});

  @override
  _EditDiaryViewState createState() => _EditDiaryViewState();
}

class _EditDiaryViewState extends State<EditDiaryView> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _body;
  late DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _name = widget.diary.title;
    _body = widget.diary.body;
    _dbHelper = DatabaseHelper();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Diary updatedDiary = Diary(
        id: widget.diary.id,
        title: _name,
        body: _body,
        user_id: widget.diary.user_id,
      );
      await _dbHelper.updateDiary(updatedDiary);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Diary updated successfully')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Diario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _body,
                decoration: InputDecoration(labelText: 'Cuerpo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el contenido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _body = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
