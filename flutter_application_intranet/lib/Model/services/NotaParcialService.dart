import 'dart:convert';
import 'package:flutter_application_intranet/Controller/Login_controller.dart';
import 'package:flutter_application_intranet/Model/entities/NotasParciales.dart';
import 'package:flutter_application_intranet/Model/entities/Ruta.dart';
import 'package:http/http.dart' as http;

class NotaParcialService {
  Future<Map<String,dynamic>> llenarParciales() async {
    Map<String,dynamic> retorno = {};
    var url = Uri.parse("http://${Ruta.ip}/bdintranet/Controla.php?tag=notasParciales&codigo_clase=${LoginController.sesionCurso!.codigoClase}&codigo_estudiante=${LoginController.sesionAlumno!.codigo}");
    var res = await http.post(url);
    try {
      if (res.statusCode == 200) {
        List listaMap = json.decode(res.body)['dato'];
        List<NotasParciales> notas = listaMap.map((e) => NotasParciales.fromJson(e)).toList();
        LoginController.sesionParciales = notas[0];
        bool isLoadingParciales = false;
        retorno = {
          "ListaNP": notas,
          "Condicion": isLoadingParciales
        };
      } else {
        print("Algo salió mal en el listado de notas parciales");
      }
    } catch (e) {
      print(e);
    }
    return retorno;
  }
}