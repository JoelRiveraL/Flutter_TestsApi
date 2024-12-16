import 'package:flutter/material.dart';
import '../controller/controller.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final ApiController _apiController = ApiController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  bool _isLoading = false;
  String? _responseMessage;
  String? _createdName;
  String? _createdJob;

  Future<void> _createUser() async {
    setState(() {
      _isLoading = true;
      _responseMessage = null;
    });

    try {
      final response = await _apiController.crearUsuario(
        _nameController.text,
        _jobController.text,
      );

      setState(() {
        _createdName = response['name']; // Nombre creado
        _createdJob = response['job']; // Trabajo creado
        _responseMessage = "Usuario creado: ${_createdName} (${_createdJob})";
      });

      // Opcional: Espera 2 segundos y regresa a la pantalla anterior
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context, true);
      });
    } catch (e) {
      setState(() {
        _responseMessage = "Error: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Fondo suave y limpio
      appBar: AppBar(
        title: Text(
          "Crear Usuario",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mensaje de éxito con diseño de gradiente
            if (_createdName != null) ...[
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green[200]!, Colors.green[400]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Usuario Creado',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Nombre: $_createdName',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      'Trabajo: $_createdJob',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
            // Campo para el nombre
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nombre",
                labelStyle: TextStyle(color: Colors.blue[700]),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[700]!),
                ),
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              ),
            ),
            SizedBox(height: 20),
            // Campo para el trabajo
            TextField(
              controller: _jobController,
              decoration: InputDecoration(
                labelText: "Trabajo",
                labelStyle: TextStyle(color: Colors.blue[700]),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[700]!),
                ),
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              ),
            ),
            SizedBox(height: 30),
            // Botón de crear usuario con animación
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _createUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        padding: EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Crear Usuario",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
            // Mensaje de respuesta
            if (_responseMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  _responseMessage!,
                  style: TextStyle(
                    color: _responseMessage!.startsWith("Error")
                        ? Colors.red
                        : Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
