import 'dart:convert';
import 'package:flutter_application_intranet/Model/entities/NotasContinuas.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_intranet/Controller/Login_controller.dart';
import 'package:flutter_application_intranet/Model/entities/Ruta.dart';

class NotaContinuaService {
  Future<Map<String,dynamic>> llenarContinuas() async {
    Map<String,dynamic> resultado = {};
    var url = Uri.parse("http://${Ruta.ip}/bdintranet/Controla.php?tag=notasContinuas&codigo_clase=${LoginController.sesionCurso!.codigoClase}&codigo_estudiante=${LoginController.sesionAlumno!.codigo}");
    var res = await http.post(url);
    try {
      if (res.statusCode == 200) {
        List listaMap = json.decode(res.body)['dato'];
        List<NotasContinuas> notasC = listaMap.map((e) => NotasContinuas.fromJson(e)).toList();
        LoginController.sesionContinuas = notasC;
        bool isLoadingContinuas = false;
        resultado = {
          "ListaNC": notasC,
          "Condicion": isLoadingContinuas
        };
      } else {
        print("Algo salió mal en el listado de notas continuas");
      }
    } catch (e) {
      print(e);
    }
    return resultado;
  }
}