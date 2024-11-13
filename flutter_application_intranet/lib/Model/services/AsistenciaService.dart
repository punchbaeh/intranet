import 'dart:convert';
import 'package:flutter_application_intranet/Controller/Login_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_intranet/Model/entities/Asistencia.dart';
import 'package:flutter_application_intranet/Model/entities/Ruta.dart';

class AsistenciaService {
  Future<List<Asistencia>> llenarAsistencia()async{
    List<Asistencia> listaA = [];
    var url = Uri.parse("http://${Ruta.ip}/bdintranet/Controla.php?tag=asistenciaClase&codigo_clase=${LoginController.sesionCurso!.codigoClase}&codigo_estudiante=${LoginController.sesionAlumno!.codigo}");
    var res = await http.post(url);
    print(json.decode(res.body));
    try {
      if (res.statusCode == 200){
        List listaMap = json.decode(res.body)['dato'];
        listaA = listaMap.map((e) => Asistencia.fromJson(e)).toList();
        print("Listado Asistencia realizado correctamente: ${listaA.length}");
      } else {
        print("Algo salió mal en el listado");
      }
    } catch (e) {
      print(e);
    }
    return listaA;
  }
}