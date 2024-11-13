import 'package:flutter_application_intranet/Model/services/ActualizacionService.dart';
import 'package:http/http.dart';

class ActualizacionController {
  final ActualizacionService _controllerActualizacion = ActualizacionService();

  Future<Response> actualizarAlumno(String nombre, String apellidoP, String apellidoM, String numero, String dir) async {
    return _controllerActualizacion.actualizarAlumno(nombre, apellidoP, apellidoM, numero, dir);
  }
}