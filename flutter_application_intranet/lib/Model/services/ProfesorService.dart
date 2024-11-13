import 'dart:convert';
import 'package:flutter_application_intranet/Controller/Login_controller.dart';
import 'package:flutter_application_intranet/Model/entities/Profesor.dart';
import 'package:flutter_application_intranet/Model/entities/Ruta.dart';
import 'package:http/http.dart' as http;

class ProfesorService {
    Future<Map<String,dynamic>> llenarProfesor() async {
      Map<String,dynamic> retorno = {};
      var url = Uri.parse("http://${Ruta.ip}/bdintranet/Controla.php?tag=listaProfesores");
      var res = await http.post(url);
      try {
        if (res.statusCode == 200) {
          List listaMap = json.decode(res.body)['dato'];
          List<Profesor> listaProf = listaMap.map((x) => Profesor.fromJson(x)).toList();
          Profesor profesor = listaProf.firstWhere((e) => e.codigo == LoginController.sesionCurso!.codigoProfesor);
          bool isLoadingProfesor = false;
          retorno = {
            "Profesor": profesor,
            "Condicion": isLoadingProfesor
          };
        } else {
          print("Algo salió mal en el listado de profesores");
        }
      } catch (e) {
        print(e);
      }
      return retorno;
  }
}