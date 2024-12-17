import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'view.dart';


class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  PantallaLoginState createState() => PantallaLoginState();
}

class PantallaLoginState extends State<PantallaLogin> {


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade400,
      body: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 50.0,
                  spreadRadius: 1.0,
                  offset: Offset(5.0, 5.0)
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        margin: EdgeInsets.only(top: 50, left: 40, right: 40, bottom: 50),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset('assets/Logo_ESPE.png'),
              ),
              SizedBox(height: 30),
              Text(
                "Universidad de las Fuerzas Armadas",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                "Departamento de Ciencias de la Computación",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height: 20
              ),
              Text(
                "Tarea/Res Creación y Uso de API",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height: 30
              ),
              Text(
                "Lindsay Barrionuevo\nJuan Pablo Pinza\nJoel Rivera\nLeonardo Yaranga",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height: 50
              ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 70, 130, 180),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_)=>UserListScreen()));
                  },
                  child: Text("Ir a Menú", style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
