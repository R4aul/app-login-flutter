import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_application/utils/navigation.dart';
import 'package:login_application/utils/routes.dart';
import 'package:login_application/db/database_helper.dart';
import 'package:login_application/models/user.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final bdHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_1280.png"), // Reemplaza con la ruta de tu imagen
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el usuario';
                        } else if (value.length < 6) {
                          return 'El usuario debe tener al menos 6 caracteres';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese la contraseña';
                        } else if (value.length < 8) {
                          return 'La contraseña debe tener al menos 8 caracteres';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Acción de inicio de sesión
                          try {
                            String userText = _emailController.text.trim();
                            String userTextPassword = _passwordController.text.trim();
                            User? foundUser = await bdHelper.getUser(userText);
                            if (foundUser == null) {
                              // Mostrar alerta al usuario
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Usuario no encontrado'),
                                    content: Text('El usuario $userText proporcionado no fue encontrado.'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Cerrar el AlertDialog
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              String? userPassword = foundUser?.password;
                              if (userPassword == userTextPassword) {
                                int? userId = foundUser?.id;
                                Navigation.navigateTo(Routes.welcome, arguments: {'userID': userId});
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text('El contraseña incorrecta.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Cerrar el AlertDialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text('Entrar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Bordes redondeados
                        ),
                        textStyle: TextStyle(
                          fontSize: 16, // Tamaño del texto
                          color: Colors.white, // Color del texto
                        ),
                        minimumSize: Size(double.infinity, 50), // Anchura completa
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigation.navigateTo(Routes.register);
                      },
                      child: Text('Registrar'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade100,
                        minimumSize: Size(double.infinity, 50), // Anchura completa
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
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
