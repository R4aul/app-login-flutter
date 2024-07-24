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
  final _nameController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.diary.title;
    _bodyController.text = widget.diary.body;
    _dbHelper = DatabaseHelper();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Diary updatedDiary = Diary(
        id: widget.diary.id,
        title: _nameController.text,
        body: _bodyController.text,
        user_id: widget.diary.user_id,
      );
      await _dbHelper.updateDiary(updatedDiary);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Diario actualizado exitosamente')));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Diario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Editar Diario',
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
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un nombre';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _bodyController,
                      decoration: InputDecoration(
                        labelText: 'Cuerpo',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el contenido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Guardar Diario'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 36), // Hace que el botón ocupe todo el ancho
                      ),
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
