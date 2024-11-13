import 'package:flutter_application_intranet/Controller/Login_controller.dart';
import 'package:flutter_application_intranet/Model/entities/Ruta.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ActualizacionService {
  Future<Response> actualizarAlumno(String nombre, String apellidoP, String apellidoM, String numero, String dir) async {
    final response = await http.post(
      Uri.parse('http://${Ruta.ip}/bdintranet/Controla.php'),
      body: {
        'tag':'actualizarAlumno',
        'codigo_estudiante': LoginController.sesionAlumno!.codigo,
        'nombres': nombre,
        'apellido_paterno': apellidoP,
        'apellido_materno': apellidoM,
        'numero_celular': numero,
        'direccion': dir,
      },
    );
    return response;
  }
}