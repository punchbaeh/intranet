import 'dart:ui';

class LeyendaController {
  Color leyenda(String e){
    Color? cl;
    if (e == '0'){
      cl = Color.fromARGB(255, 255, 148, 148);
    } else if (e == '1'){
      cl = Color.fromARGB(255, 221, 255, 170);
    } else if (e == '2'){
      cl = Color.fromARGB(255, 255, 248, 214);
    } else if (e == '3'){
      cl = Color.fromARGB(255, 199, 240, 255);
    } else {
      cl = Color.fromARGB(255, 234, 234, 234);
    }

    return cl;
  }
}