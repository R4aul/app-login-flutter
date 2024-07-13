import 'package:flutter/material.dart';

class ListDiaryView extends StatelessWidget{

  final int userId;

  ListDiaryView({
    required this.userId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Diario'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Acción para agregar nuevo diario
            },
          ),
        ],
      ),
      body: Center(
        child: Text('El user id es $userId'),
      ),
    ); 
  }
  
}