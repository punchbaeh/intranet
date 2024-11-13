import 'package:flutter/material.dart';
import 'package:flutter_application_intranet/Controller/List_controller.dart';
import 'package:flutter_application_intranet/Controller/Login_controller.dart';
import 'package:flutter_application_intranet/Model/entities/Curso.dart';
import 'package:flutter_application_intranet/View/secundarioEst.dart';

class CursosEst extends StatefulWidget{
  const CursosEst({super.key});

  @override
  State<CursosEst> createState() => _CursosEstState();

}

class _CursosEstState extends State<CursosEst>{
  ListController controllerList = ListController();
  List<Curso> listaCursos = [];

  Future<void> inicio()  async {
    listaCursos = await controllerList.obtenerCursos(); 
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    inicio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255,1,161,197),
        title: Text('Universidad Católica Sedes Sapientae', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
        leading: Image.asset('assets/logo.png'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: listaCursos.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(color: Color.fromARGB(255, 214, 234, 248), borderRadius: BorderRadius.circular(20)),              
              child: ListTile(
                onTap: (){
                  LoginController.sesionCurso = listaCursos[index];
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>MySecondApp()));
                },
                title: Text(listaCursos[index].nombre, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Código: ${listaCursos[index].codigoCurso}        Cred.: ${listaCursos[index].creditos}        Tipo: ${listaCursos[index].tipo()}\nDocente: ${listaCursos[index].nombresProfesor} ${listaCursos[index].apellidosProfesor}')
              ),
            );
          },
        ),
      ),
    );
  }
}