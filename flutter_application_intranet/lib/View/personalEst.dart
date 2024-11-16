import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_intranet/Controller/ImgController.dart';
import 'package:flutter_application_intranet/Controller/Login_controller.dart';
import 'package:flutter_application_intranet/View/main.dart';
import 'package:flutter_application_intranet/View/actualizaEst.dart';

class PersonalEst extends StatefulWidget {
  const PersonalEst({super.key});

  @override
  State<PersonalEst> createState() => _PersonalEstState();
}

class _PersonalEstState extends State<PersonalEst> {
  ImgController controllerImg = ImgController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 1, 161, 197),
        title: const Text('Universidad Católica Sedes Sapientae',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        leading: Image.asset('assets/logo.png'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Center(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 214, 234, 248),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                  'Código de estudiante: ${LoginController.sesionAlumno!.codigo}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                controllerImg.fotoPerfilAlumno(),
                width: 200,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/default.png', // Ruta de la imagen local
                    width: 200,
                    height: 300,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            BarcodeWidget(
              barcode: Barcode.code128(),
              data:
                  '${LoginController.sesionAlumno!.codigo} ${LoginController.sesionAlumno!.apellidoPaterno}',
              width: 300,
              height: 100,
              drawText: false,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 214, 234, 248),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LoginController.sesionAlumno!.getLabels(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(LoginController.sesionAlumno!.getValues(),
                      style: TextStyle(fontSize: 14))
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => MyActualiza()));
                    },
                    child: Text(
                      'Actualizar datos',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 1, 161, 197))),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => MyApp()));
                    },
                    child: Text(
                      'Cerrar Sesión',
                      style: TextStyle(color: Colors.white),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red)),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
