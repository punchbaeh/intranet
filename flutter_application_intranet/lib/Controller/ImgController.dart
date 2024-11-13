import 'package:flutter_application_intranet/Model/services/ImageService.dart';
import '../Model/entities/Profesor.dart';

class ImgController {
  ImageService imageService = ImageService();
  String fotoPerfilAlumno(){
    return imageService.traerImagenAlumno();
  }
  String fotoPerfilProfesor(Profesor prof){
    return imageService.traerImagenProfesor(prof);
  }
}