import 'package:flutter/material.dart';
import 'package:flutter_application_intranet/Controller/ActualizacionController.dart';
import 'package:flutter_application_intranet/Controller/Login_controller.dart';
import 'package:flutter_application_intranet/View/main.dart';
import 'package:flutter_application_intranet/View/principalEst.dart';
import 'package:http/http.dart';

class MyActualiza extends StatefulWidget{
  const MyActualiza({super.key});

  @override
  State<MyActualiza> createState() => _MyActualizaState();

}

class _MyActualizaState extends State<MyActualiza>{
  ActualizacionController actualizacionController = ActualizacionController();
  TextEditingController nombre = TextEditingController();
  TextEditingController apellidoP = TextEditingController();
  TextEditingController apellidoM = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController dir = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombre.text = LoginController.sesionAlumno!.nombres;
    apellidoP.text = LoginController.sesionAlumno!.apellidoPaterno;
    apellidoM.text = LoginController.sesionAlumno!.apellidoMaterno;
    numero.text = LoginController.sesionAlumno!.numeroCelular.toString();
    dir.text = LoginController.sesionAlumno!.direccion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255,1,161,197),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>MyPrincipalHomePage(i:0)));
        }, icon: Icon(Icons.keyboard_return, color: Colors.white,),),
        title: Text('Universidad Católica Sedes Sapientae', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              SizedBox(height: 15,),
              Text('Actualización de datos',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              TextField(controller: nombre, decoration: InputDecoration(icon: Icon(Icons.abc), hintText: 'Actualizar nombre'),),
              SizedBox(height: 7,),
              TextField(controller: apellidoP, decoration: InputDecoration(icon: Icon(Icons.abc), hintText: 'Actualizar apellido Paterno'),),
              SizedBox(height: 7,),
              TextField(controller: apellidoM, decoration: InputDecoration(icon: Icon(Icons.abc), hintText: 'Actualizar apellido Materno'),),
              SizedBox(height: 7,),
              TextField(controller: numero, decoration: InputDecoration(icon: Icon(Icons.numbers), hintText: 'Actualizar número celular'),),
              SizedBox(height: 7,),
              TextField(controller: dir, decoration: InputDecoration(icon: Icon(Icons.maps_home_work), hintText: 'Actualizar dirección'),),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: () async {
                try {
                  Response response = await actualizacionController.actualizarAlumno(nombre.text, apellidoP.text, apellidoM.text, numero.text, dir.text);
                  if (response.statusCode == 200){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Actualización con exito'),
                          content: Text('Se procederá a cerrar la sesión.'),
                          actions: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(context, MaterialPageRoute(builder: (builder)=>MyApp()));
                              },
                              icon: Icon(Icons.keyboard_return, color: Colors.red,),
                            ),
                          ],
                        );
                      },
                    );                    
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Actualización fallida'),
                          content: Text('Hubo problemas con el servidor'),
                          actions: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.keyboard_return, color: Colors.red,),
                            ),
                          ],
                        );
                      },
                    );      
                  }

                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Actualización fallida'),
                        content: Text('Introduzca los datos correctamente.'),
                        actions: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.keyboard_return, color: Colors.red,),
                          ),
                        ],
                      );
                    },
                  );
                }
              }, child: Text('Registrar actualización',style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255,1,161,197))),
            ],
          ),
        ),
      )
    );
  }
}