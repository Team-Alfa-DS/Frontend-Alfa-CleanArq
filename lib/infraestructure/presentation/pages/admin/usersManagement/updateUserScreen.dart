import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UpdateUserScreen extends StatefulWidget {
  final User user;

  const UpdateUserScreen({super.key, required this.user});

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _phone = '';
  String _type = '';
  String _token = '';

  @override
  void initState() {
    super.initState();
    _name = widget.user.name!;
    _email = widget.user.email!;
    _phone = widget.user.phone!;
    _type = describeEnum(widget.user.type as Object);
    _token = widget.user.token ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Update User"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Foto del usuario
            CircleAvatar(
              radius: 50,
              //backgroundImage: NetworkImage(widget.user.photoUrl),
            ),
            SizedBox(height: 20),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _name,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value!,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _email,
                    decoration: InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Por favor ingrese un correo válido';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value!,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _phone,
                    decoration: InputDecoration(
                      labelText: 'Teléfono',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un teléfono';
                      }
                      return null;
                    },
                    onSaved: (value) => _phone = value!,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _type,
                    decoration: InputDecoration(
                      labelText: 'Tipo',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un tipo';
                      }
                      return null;
                    },
                    onSaved: (value) => _type = value!,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _token,
                    decoration: InputDecoration(
                      labelText: 'Token',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un token';
                      }
                      return null;
                    },
                    onSaved: (value) => _token = value!,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Actualizar usuario en la base de datos
                        //...
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, // Color del texto
                    ),
                    child: Text('Guardar cambios'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmar eliminación'),
                            content:
                                Text('¿Está seguro de eliminar al usuario?'),
                            actions: [
                              TextButton(
                                child: Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Eliminar'),
                                onPressed: () {
                                  // Eliminar usuario en la base de datos
                                  //...
                                  Navigator.of(context).pop();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red, // Color del texto
                    ),
                    child: Text('Eliminar usuario'),
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
