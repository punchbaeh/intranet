import 'package:flutter_application_intranet/Model/entities/Alumno.dart';
import 'package:flutter_application_intranet/Model/entities/Curso.dart';
import 'package:flutter_application_intranet/Model/entities/NotasContinuas.dart';
import 'package:flutter_application_intranet/Model/entities/NotasParciales.dart';

class LoginController{
  static Alumno? sesionAlumno;
  static Curso? sesionCurso;
  static NotasParciales? sesionParciales;
  static List<NotasContinuas>? sesionContinuas;

  bool validar_credenciales(String usu, int psw, List<Alumno> lista){
    bool res = false;
    for (Alumno x in lista){
      if (x.codigo == usu && x.dni == psw){
        res = true;
        sesionAlumno = x;
      }
    }
    return res;
  }
}