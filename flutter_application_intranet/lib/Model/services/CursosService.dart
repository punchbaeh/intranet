import 'package:flutter_application_intranet/Controller/Login_controller.dart';
import 'package:flutter_application_intranet/Model/entities/Curso.dart';
import 'package:flutter_application_intranet/Model/entities/Ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CursosService {
  Future<List<Curso>> llenarCursos() async{
    List<Curso> listaCurso = [];
    var url = Uri.parse("http://${Ruta.ip}/bdintranet/Controla.php?tag=listaCursos&codigo_estudiante=${LoginController.sesionAlumno!.codigo}");
    var res = await http.post(url);
    print(json.decode(res.body));
    try {
      if (res.statusCode == 200){
        List listaMap = json.decode(res.body)['dato'];
        listaCurso = listaMap.map((e) => Curso.fromJson(e)).toList();
        print("Listado Alumnos realizado correctamente: ${listaCurso.length}");
      } else {
        print("Algo salió mal en el listado");
      }
    } catch (e) {
      print(e);
    }
    return listaCurso;
  }

   Future<List<Curso>> historial() async{
    List<Curso> listaCurso = [];
    var url = Uri.parse("http://${Ruta.ip}/bdintranet/Controla.php?tag=historial&codigo_estudiante=${LoginController.sesionAlumno!.codigo}");
    var res = await http.post(url);
    print(json.decode(res.body));
    try {
      if (res.statusCode == 200){
        List listaMap = json.decode(res.body)['dato'];
        listaCurso = listaMap.map((e) => Curso.fromJson(e)).toList();
        print("Listado Alumnos realizado correctamente: ${listaCurso.length}");
      } else {
        print("Algo salió mal en el listado");
      }
    } catch (e) {
      print(e);
    }
    return listaCurso;
  } 
}

