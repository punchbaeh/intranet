import 'package:flutter_application_intranet/Model/entities/Alumno.dart';
import 'package:flutter_application_intranet/Model/entities/Asistencia.dart';
import 'package:flutter_application_intranet/Model/entities/Curso.dart';
import 'package:flutter_application_intranet/Model/services/AlumnoService.dart';
import 'package:flutter_application_intranet/Model/services/AsistenciaService.dart';
import 'package:flutter_application_intranet/Model/services/CursosService.dart';
import 'package:flutter_application_intranet/Model/services/NotaContinuaService.dart';
import 'package:flutter_application_intranet/Model/services/NotaParcialService.dart';
import 'package:flutter_application_intranet/Model/services/ProfesorService.dart';

class ListController {
  final AlumnoService _alumnoService = AlumnoService();
  final CursosService _cursoService = CursosService();
  final ProfesorService _profesorService = ProfesorService();
  final NotaParcialService _npService = NotaParcialService();
  final NotaContinuaService _ncService = NotaContinuaService();
  final AsistenciaService _asistenciaService = AsistenciaService();

  Future<List<Alumno>> obtenerAlumnos() {
    return _alumnoService.llenarAlumnos();
  }

  Future<List<Curso>> obtenerCursos() {
    return _cursoService.llenarCursos();
  }

  Future<Map<String, dynamic>> obtenerProfesor() {
    return _profesorService.llenarProfesor();
  }

  Future<Map<String, dynamic>> obtenerNotasParciales() {
    return _npService.llenarParciales();
  }

  Future<Map<String, dynamic>> obtenerNotasContinuas() {
    return _ncService.llenarContinuas();
  }

  Future<List<Asistencia>> obtenerAsistencias() {
    return _asistenciaService.llenarAsistencia();
  }

  Future<List<Curso>> obtenerHistorial() {
    return _cursoService.historial();
  }

  List<Curso> filtro(int bus, List<Curso> listaH, String x) {
    List<Curso> resultado = [];
    if (bus == 1) {
      resultado = listaH.where((c) => c.nombre.contains(x)).toList();
    } else if (bus == 2) {
      int ci = int.tryParse(x) ?? 0;
      resultado = listaH.where((c) => c.ciclo == ci).toList();
    } else {
      String prof = x.toUpperCase();
      resultado = listaH.where((c) => c.apellidosProfesor.contains(prof)).toList();
    }
    return resultado;
  }
}
