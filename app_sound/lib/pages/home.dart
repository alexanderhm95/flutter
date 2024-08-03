import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id =
      'homePage'; //Se crea una constante de tipo String con el nombre de la clase
  @override //Se sobreescribe el metodo build
  _homePageState createState() =>
      _homePageState(); //Se retorna una instancia de la clase _homePageState
}

class _homePageState extends State<HomePage> {
  @override //Se sobreescribe el metodo build
  Widget build(BuildContext context) {
    return SafeArea(
      //Se retorna un widget de tipo SafeArea
      child: Scaffold(
        //Se retorna un widget de tipo Scaffold
        backgroundColor:
            Colors.red, //Se establece el color de fondo del Scaffold
        body: Center(
          //Se establece el cuerpo del Scaffold
          child: Column(
            //Se retorna un widget de tipo Column
            mainAxisAlignment: MainAxisAlignment
                .center, //Se establece la alineacion principal de la Columna
            children: [
              //Se establece una lista de widgets
              //Componente de texto
              Text(
                //Se retorna un widget de tipo Text
                "Quiero \ndulces"
                    .toUpperCase(), //Se establece el texto del widget
                textAlign:
                    TextAlign.center, //Se establece la alineacion del texto
                style: TextStyle(
                  //Se establece el estilo del texto
                  color: Colors.white, //Se establece el color del texto
                  fontSize: 30, //Se establece el tamaño de la fuente del texto
                  fontWeight: FontWeight
                      .bold, //Se establece el peso de la fuente del texto
                  fontFamily: 'Impact', //Se establece la fuente del texto
                ),
              ),
              //Componente sideBox
              SizedBox(
                //Se retorna un widget de tipo SizedBox
                height: 30.0, //Se establece la altura del widget
              ),
              //Componente Fila
              Row(
                //Se retorna un widget de tipo Row
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround, //Se establece la alineacion principal de la fila
                children: [
                  //Se establece una lista de widgets
                  GestureDetector(
                    //Se retorna un widget de tipo GestureDetector
                    onTap: () {
                      //Se establece la accion al presionar el widget
                      setState(() {
                        //Se establece el estado del widget
                        print('object'); //Se imprime un mensaje en la consola
                      });
                    },
                    child: Text(
                      'Iniciar Sesion', //Se retorna un widget de tipo Text
                      style: TextStyle(
                        //Se establece el estilo del texto
                        color: Colors.white, //Se establece el color del texto
                        fontSize:
                            20, //Se establece el tamaño de la fuente del texto
                        fontWeight: FontWeight.bold, //Se establece
                      ),
                    ),
                  ),
                  GestureDetector(
                    //Se retorna un widget de tipo GestureDetector
                    onTap: () {
                      //Se establece la accion al presionar el widget
                      setState(() {
                        //Se establece el estado del widget
                        print('object2'); //Se imprime un mensaje en la consola
                      });
                    },
                    child: Text(
                      'Registrarse', //Se retorna un widget de tipo Text
                      style: TextStyle(
                        //Se establece el estilo del texto
                        color: Colors.white, //Se establece el color del texto
                        fontSize:
                            20, //Se establece el tamaño de la fuente del texto
                        fontWeight: FontWeight
                            .bold, //Se establece el peso de la fuente del texto
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
