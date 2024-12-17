import 'package:flutter/material.dart';
import '../controller/controller.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

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
        _createdName = response['name'];
        _createdJob = response['job'];
        _responseMessage = "Usuario creado: $_createdName ($_createdJob)";
      });

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
          "Crear Usuario",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 200, 220, 240),
              const Color.fromARGB(255, 171, 212, 230),
              const Color.fromARGB(255, 70, 130, 180),
            ],
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Mensaje de éxito
                if (_createdName != null) ...[
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
                          'Usuario Creado',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 70, 130, 180),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Nombre: $_createdName',
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 16),
                        ),
                        Text(
                          'Trabajo: $_createdJob',
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],

                // Campo: Nombre
                _buildInputField(
                  controller: _nameController,
                  label: "Nombre",
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),

                // Campo: Trabajo
                _buildInputField(
                  controller: _jobController,
                  label: "Trabajo",
                  icon: Icons.work,
                ),
                const SizedBox(height: 30),

                // Botón Crear Usuario
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _createUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color.fromARGB(255, 70, 130, 180),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Crear Usuario",
                      style: TextStyle(
                          fontSize: 18, color: Colors.white),
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
                        fontSize: 16,
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
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 70, 130, 180)),
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
        const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    );
  }
}
