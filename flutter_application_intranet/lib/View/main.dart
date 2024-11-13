
import 'package:flutter/material.dart';
import 'package:flutter_application_intranet/Controller/List_controller.dart';
import 'package:flutter_application_intranet/Controller/Login_controller.dart';
import 'package:flutter_application_intranet/Model/entities/Alumno.dart';
import 'package:flutter_application_intranet/View/principalEst.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget{
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage>{
  ListController controllerList = ListController();
  LoginController controllerLogin = LoginController();
  TextEditingController usu = TextEditingController();
  TextEditingController psw = TextEditingController();
  List<Alumno> listaAlumnos = [];


  Future<void> inicio()  async {
    listaAlumnos = await controllerList.obtenerAlumnos(); 
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255,1,161,197),
        title: Text('Universidad Católica Sedes Sapientae', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
        leading: Image.asset('assets/logo.png'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Text('Inicio de sesión', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, )),
              SizedBox(height: 50,),
              Image.asset('assets/login.png', width: 200, height: 200,),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(controller: usu, decoration: InputDecoration(hintText: 'Usuario', icon: Icon(Icons.person)),cursorColor: Color.fromARGB(255,1,161,197),),
                    SizedBox(height: 10,),
                    TextField(controller: psw, decoration: InputDecoration(hintText: 'Contraseña', icon: Icon(Icons.password)),cursorColor: Color.fromARGB(255,1,161,197),obscureText: true,),          
                    SizedBox(height: 30,),
                    TextButton(onPressed: (){
                      if (controllerLogin.validar_credenciales(usu.text,int.tryParse(psw.text)??0, listaAlumnos)){
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>MyPrincipalHomePage(i: 0,)));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Validación de datos'),
                              content: Text('El nombre de usuario y/o contraseña son incorrectos, intentelo nuevamente.'),
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
                    }, child: Text('Ingresar', style: TextStyle(color: Colors.white),),style: TextButton.styleFrom(backgroundColor: Color.fromARGB(255,1,161,197)))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}