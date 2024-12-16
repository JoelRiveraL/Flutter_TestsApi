import 'package:flutter/material.dart';
import '../controller/controller.dart';

class UpdateUserScreen extends StatefulWidget {
  final int userId;

  UpdateUserScreen({required this.userId});

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final ApiController _apiController = ApiController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  bool _isLoading = false;
  String? _responseMessage;
  String? _updatedName;
  String? _updatedJob;

  Future<void> _updateUser() async {
    setState(() {
      _isLoading = true;
      _responseMessage = null;
    });

    try {
      final response = await _apiController.actualizarUsuario(
        widget.userId,
        _nameController.text,
        _jobController.text,
      );

      setState(() {
        _updatedName = response['name']; // Actualizamos el nombre
        _updatedJob = response['job']; // Actualizamos el trabajo
        _responseMessage =
            "Usuario actualizado: ${_updatedName} (${_updatedJob})";
      });

      // Opcional: Esperamos unos segundos antes de navegar a la pantalla anterior.
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context,
            true); // Navegar hacia atrás y pasar 'true' para indicar éxito
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
          "Actualizar Usuario",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.blue[800], // Azul profundo
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Si hay un nombre actualizado, lo mostramos de forma destacada
            if (_updatedName != null) ...[
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
                      'Usuario Actualizado',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Nombre: $_updatedName',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      'Trabajo: $_updatedJob',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
            // Campos de texto para la actualización
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
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updateUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        padding: EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Actualizar Usuario",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
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
