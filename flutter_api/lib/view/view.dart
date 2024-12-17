import 'package:flutter/material.dart';
import 'package:flutter_api/view/updateView.dart';
import './createView.dart';
import '../controller/controller.dart';
import '../model/model.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ApiController _apiController = ApiController();
  late Future<List<User>> _usuarios;

  @override
  void initState() {
    super.initState();
    _usuarios = _apiController.obtenerUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: const Text(
          "Contactos",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateUserScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 212, 240, 250),
              Color.fromARGB(255, 171, 212, 230),
              Color.fromARGB(255, 70, 130, 180),
            ],
          ),
        ),
        child: FutureBuilder<List<User>>(
          future: _usuarios,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        color: Colors.redAccent, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(
                          fontSize: 20, color: Colors.redAccent),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_off,
                        color: Colors.grey.shade400, size: 50),
                    const SizedBox(height: 10),
                    const Text(
                      "No hay contactos disponibles.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              );
            } else {
              final usuarios = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Número de columnas
                    crossAxisSpacing: 30, // Espacio horizontal entre cuadros
                    mainAxisSpacing: 30, // Espacio vertical entre cuadros
                    childAspectRatio:
                        0.78, // Reducir la relación ancho-alto (más altura)
                  ),
                  itemCount: usuarios.length,
                  itemBuilder: (context, index) {
                    final usuario = usuarios[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(usuario.avatar),
                            backgroundColor: Colors.grey.shade200,
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            // Asegura que el contenido se ajuste correctamente
                            child: Text(
                              "${usuario.firstName} ${usuario.lastName}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            child: Text(
                              usuario.email,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateUserScreen(userId: usuario.id),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Editar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
