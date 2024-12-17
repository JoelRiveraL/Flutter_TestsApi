import 'package:flutter/material.dart';
import '../controller/controller.dart';

class UpdateUserScreen extends StatefulWidget {
  final int userId;

  const UpdateUserScreen({super.key, required this.userId});

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
        _updatedName = response['name'];
        _updatedJob = response['job'];
        _responseMessage = "Usuario actualizado: $_updatedName ($_updatedJob)";
      });

      // Opcional: Espera 2 segundos y regresa a la pantalla anterior
      Future.delayed(const Duration(seconds: 3), () {
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
      appBar: AppBar(
        title: const Text(
          "Actualizar Usuario",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 70, 130, 180), // Color consistente
        elevation: 0, // Sin sombra para un diseño más limpio
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 200, 220, 240),
              Color.fromARGB(255, 171, 212, 230),
              Color.fromARGB(255, 70, 130, 180),
            ],
          ),
        ),
        constraints: const BoxConstraints.expand(), // Fondo cubre toda la pantalla
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Encabezado

                const SizedBox(height: 20),

                // Tarjeta de confirmación
                if (_updatedName != null) ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Usuario Actualizado',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 70, 130, 180),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Nombre: $_updatedName',
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 16),
                        ),
                        Text(
                          'Trabajo: $_updatedJob',
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],

                // Campo de texto: Nombre
                _buildInputField(
                  controller: _nameController,
                  label: "Nombre",
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),

                // Campo de texto: Trabajo
                _buildInputField(
                  controller: _jobController,
                  label: "Trabajo",
                  icon: Icons.work,
                ),
                const SizedBox(height: 30),

                // Botón actualizar
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _updateUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color.fromARGB(255, 70, 130, 180),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Actualizar Usuario",
                      style: TextStyle(
                          fontSize: 22, color: Colors.white),
                    ),
                  ),
                ),

                // Mensaje de error o éxito
                if (_responseMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      _responseMessage!,
                      style: TextStyle(
                        color: _responseMessage!.startsWith("Error")
                            ? Colors.red
                            : const Color.fromARGB(255, 22, 59, 89),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        hintText: "Ingrese su $label",
        hintStyle: TextStyle(
          color: Colors.grey.shade900,
          fontSize: 16,
        ),
        prefixIcon:
        Icon(icon, color: const Color.fromARGB(255, 70, 130, 180)),
        labelStyle: const TextStyle(color: Colors.black54),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 70, 130, 180), width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      ),
    );
  }
}
