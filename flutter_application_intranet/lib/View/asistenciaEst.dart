import 'package:flutter/material.dart';
import 'package:flutter_application_intranet/Controller/LeyendaController.dart';
import 'package:flutter_application_intranet/Controller/List_controller.dart';
import 'package:flutter_application_intranet/Model/entities/Asistencia.dart';

class AsistenciaEst extends StatefulWidget{
  const AsistenciaEst({super.key});

  @override
  State<AsistenciaEst> createState() => _AsistenciaEstState();

}

class _AsistenciaEstState extends State<AsistenciaEst>{
  List<Asistencia> listaA = [];
  ListController controllerList = ListController();
  LeyendaController controllerLy = LeyendaController();

  Future<void> inicio()  async {
    listaA = await controllerList.obtenerAsistencias(); 
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    inicio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Color.fromARGB(255, 255, 148, 148),
                        ),
                        SizedBox(width: 6,),
                        Text('No asistió')
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Color.fromARGB(255, 221, 255, 170),
                        ),
                        SizedBox(width: 6,),
                        Text('Asistió')
                      ],
                    )
                  ],
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Color.fromARGB(255, 255, 248, 214),
                        ),
                        SizedBox(width: 6,),
                        Text('Tardanza')
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Color.fromARGB(255, 199, 240, 255),
                        ),
                        SizedBox(width: 6,),
                        Text('Justificado')
                      ],
                    )
                  ],
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Color.fromARGB(255, 234, 234, 234),
                        ),
                        SizedBox(width: 6,),
                        Text('No informa')
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: listaA.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(color: controllerLy.leyenda(listaA[index].estado), borderRadius: BorderRadius.circular(20)),              
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Center(child: Text("Semana ${listaA[index].semana}", style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}