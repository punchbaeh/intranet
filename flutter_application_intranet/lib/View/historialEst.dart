import 'package:flutter/material.dart';
import 'package:flutter_application_intranet/Controller/List_controller.dart';
import 'package:flutter_application_intranet/Model/entities/Curso.dart';

class HistorialEst extends StatefulWidget{
  const HistorialEst({super.key});

  @override
  State<HistorialEst> createState() => _HistorialEstState();

}

class _HistorialEstState extends State<HistorialEst>{
  int bus = 1;
  ListController controllerList = ListController();
  List<Curso> listaH = [];
  List<Curso> filtrada = [];

  Future<void> inicio()async{
    listaH = await controllerList.obtenerHistorial();
    filtrada = listaH;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255,1,161,197),
        title: Text('Universidad Católica Sedes Sapientae', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
        leading: Image.asset('assets/logo.png'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(icon: Icon(Icons.search)), onChanged: (x){
              setState(() {
                filtrada = controllerList.filtro(bus, listaH, x);
              });
            },),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(color: Color.fromARGB(255, 214, 234, 248), borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  RadioListTile(title: Text('Curso'), value: 1, groupValue: bus, onChanged: (x){
                    setState(() {
                      bus = x!;
                    });
                  }),
                  RadioListTile(title: Text('Ciclo'), value: 2, groupValue: bus, onChanged: (x){
                    setState(() {
                      bus = x!;
                    });
                  }),
                  RadioListTile(title: Text('Profesor'), value: 3, groupValue: bus, onChanged: (x){
                    setState(() {
                      bus = x!;
                    });
                  })                                   
                ],
              ),
            ),
            SizedBox(height: 10,),
            ListTile(title: Text('Ciclo   Curso y docente                      Creditos'),),
            Expanded(
              child: ListView.builder(
              itemCount: filtrada.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text('${filtrada[index].ciclo}'),
                        title: Text('${filtrada[index].nombre}'),
                        subtitle: Text('${filtrada[index].apellidosProfesor}'),
                        trailing: Text('${filtrada[index].creditos}'),
                      ),
                      Divider()
                    ],
                  ),
                );
              },
            ),
            )
          ],
        ),
      )

      );
  }
}