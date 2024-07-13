import 'package:flutter/material.dart';
import 'package:login_application/db/database_helper.dart';
import 'package:login_application/models/user.dart';

class WelcomeView extends StatefulWidget {
  final int userId;

  WelcomeView({
    required this.userId,
  });

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  String name = '';
  String username = '';

  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    int id = widget.userId;
    User? foundUser = await dbHelper.getUserById(id);

    String MyName = foundUser!.name;
    String MyUserName = foundUser!.user;

    setState(() {
      name = MyName; // Aquí debes colocar los datos obtenidos de la API
      username = MyUserName; // Aquí debes colocar los datos obtenidos de la API
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_1280.png"), // Reemplaza con tu imagen
              backgroundColor: Colors.redAccent,
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(60),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
