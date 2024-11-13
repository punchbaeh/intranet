import 'dart:convert';

import 'package:flutter_application_intranet/Model/entities/Alumno.dart';
import 'package:flutter_application_intranet/Model/entities/Ruta.dart';
import 'package:http/http.dart' as http;

class AlumnoService {
  
   Future<List<Alumno>> llenarAlumnos()async{
    List<Alumno> listaAlumnos = [];
    var url = Uri.parse("http://${Ruta.ip}/bdintranet/Controla.php?tag=listaAlumnos");
    var res = await http.get(url);
    print(json.decode(res.body));
    try {
      if (res.statusCode == 200){
        List listaMap = json.decode(res.body)['dato'];
        listaAlumnos = listaMap.map((e) => Alumno.fromJson(e)).toList();
      print("Listado Alumnos realizado correctamente: ${listaAlumnos.length}");
    } else {
      print("Algo salió mal en el listado");
    }
    } catch (e) {
      print(e);
      print("no corrió :c");
    }
    return listaAlumnos;
  }
}