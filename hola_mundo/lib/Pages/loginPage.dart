import 'package:flutter/material.dart';
import '../Utils/clsTextFieldGeneral.dart';

class loginPage extends StatefulWidget {
  static const String id = 'loginPage';
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Componente de texto
            Text(
              "Quiero \ndulces".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Impact',
              ),
            ),
            //Componente sideBox
            SizedBox(
              height: 30.0,
            ),
            //Componente Fila
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      print('object');
                    });
                  },
                  child: Text('Iniciar Sesion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      print('object2');
                    });
                  },
                  child: Text('Registrarse',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
            //Componente deside
            SizedBox(height: 20.0),
            _textFieldName(), //llamado de la funcion
            SizedBox(height: 15.0),
            _textFieldEmail(), //llamado de la funcion
            SizedBox(height: 15.0),
            _textFieldPassword(), //llamado de la funcion
            SizedBox(height: 20.0),
            _buttonSingUp()
          ],
        )),
      ),
    );
  }

//funcion para el campo de texto
  Widget _textFieldName() {
    return TextFieldGeneral(
      labelText: 'Nombre',
      hintText: 'Nombre',
      icon: Icons.person_outline,
      onChanged: (value) {},
    );
  }

  Widget _textFieldEmail() {
    return TextFieldGeneral(
      labelText: 'Correo',
      hintText: 'Correo',
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      onChanged: (value) {},
    );
  }

  Widget _textFieldPassword() {
    return TextFieldGeneral(
      labelText: 'Contraseña',
      hintText: 'Contraseña',
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      icon: Icons.lock,
      onChanged: (value) {},
    );
  }

  Widget _buttonSingUp() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        backgroundColor: const Color.fromARGB(255, 224, 120, 136),
      ),
      child: Text(
        'Registrarme',
        style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255), fontSize: 20.0),
      ),
    );
  }
}
