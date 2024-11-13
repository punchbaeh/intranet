import 'package:flutter/material.dart';
import 'package:flutter_application_intranet/Controller/ImgController.dart';
import 'package:flutter_application_intranet/Controller/List_controller.dart';
import 'package:flutter_application_intranet/Controller/Login_controller.dart';
import 'package:flutter_application_intranet/Model/entities/NotasContinuas.dart';
import 'package:flutter_application_intranet/Model/entities/NotasParciales.dart';
import 'package:flutter_application_intranet/Model/entities/Profesor.dart';
import 'package:flutter_application_intranet/View/graficosEst.dart';

class NotasEst extends StatefulWidget {
  const NotasEst({super.key});

  @override
  State<NotasEst> createState() => _NotasEstState();
}

class _NotasEstState extends State<NotasEst> {
  ListController controllerList = ListController();
  ImgController controllerImg = ImgController();
  List<NotasParciales> notas = [];
  List<NotasContinuas> notasC = [];
  Profesor? profesor;
  bool isLoadingParciales = true;
  bool isLoadingContinuas = true;
  bool isLoadingProfesor = true;

  Future<void> llenarProfesor() async {
    Map<String,dynamic> resultado = await controllerList.obtenerProfesor();
    setState(() {
      profesor = resultado["Profesor"];
      isLoadingProfesor = resultado["Condicion"];
    });
  }

  Future<void> llenarParciales() async {
    Map<String,dynamic> resultado = await controllerList.obtenerNotasParciales();
    setState(() {
      notas = resultado["ListaNP"];
      isLoadingParciales = resultado["Condicion"];
    });
  }

  Future<void> llenarContinuas() async {
    Map<String,dynamic> resultado = await controllerList.obtenerNotasContinuas();
    setState(() {
      notasC = resultado["ListaNC"];
      isLoadingContinuas = resultado["Condicion"];
    });
  }

  @override
  void initState() {
    super.initState();
    llenarProfesor();
    llenarParciales();
    llenarContinuas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              LoginController.sesionCurso!.nombre,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 214, 234, 248),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLoadingParciales ? "Cargando..." : LoginController.sesionParciales!.toStringLabels(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(width: 10),
                  Text(
                    isLoadingParciales ? "" : LoginController.sesionParciales!.toStringValues(),
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isLoadingProfesor
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Información del profesor'),
                                content: SingleChildScrollView(
                                  padding: EdgeInsets.all(15),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 214, 234, 248),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            'Código de docente: ${profesor!.codigo}',
                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.network(
                                            controllerImg.fotoPerfilProfesor(profesor!),
                                            width: 150,
                                            height: 250,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 214, 234, 248),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  profesor!.getLabels(),
                                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.right,
                                                ),
                                                SizedBox(width: 10),
                                                Text(profesor!.getValues(), style: TextStyle(fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.keyboard_return, color: Colors.red),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                  child: Text('Ver profesor', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 1, 161, 197)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => MyGraficos()));
                  },
                  child: Text('Ver gráficos', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 1, 161, 197)),
                ),
              ],
            ),
            Expanded(
              child: isLoadingContinuas
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: notasC.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Continua ${notasC[index].numero}',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('Nota: ${notasC[index].nota}'),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
