import 'package:flutter_application_intranet/Controller/Login_controller.dart';
import 'package:flutter_application_intranet/Model/entities/Profesor.dart';
import 'package:flutter_application_intranet/Model/entities/Ruta.dart';

class ImageService {
  String traerImagenAlumno(){
    return "http://${Ruta.ip}/bdintranet/image.php?file=${LoginController.sesionAlumno!.codigo}.jpg";
  }
  String traerImagenProfesor(Profesor prof){
    return "http://${Ruta.ip}/bdintranet/image.php?file=${prof.codigo}.jpg";
  }
}