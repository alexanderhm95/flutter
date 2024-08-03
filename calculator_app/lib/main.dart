import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorHome(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";
  List<String> _history = [];
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    bool available = await _speech.initialize();
    if (!available) {
      Fluttertoast.showToast(
        msg: "Reconocimiento de voz no disponible",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _calculateResult(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        _result = eval.toString();
      });
    } catch (e) {
      setState(() {
        _result = "Error";
      });
    }
  }

  void _appendToExpression(String value) {
    setState(() {
      _controller.text += value;
      _calculateResult(_controller.text);
    });
  }

  void _clearExpression() {
    setState(() {
      _controller.clear();
      _result = "";
    });
  }

  void _saveToHistory() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _history.add('${_controller.text} = $_result');
        Fluttertoast.showToast(
          msg: "Operación guardada con éxito",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    }
  }

  void _showHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Historial'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _history.map((entry) => Text(entry)).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _listen() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status.isGranted) {
      if (!_isListening) {
        bool available = await _speech.initialize(
          onStatus: (val) => setState(() => _isListening = val == 'listening'),
          onError: (val) => setState(() => _isListening = false),
        );
        if (available) {
          setState(() => _isListening = true);
          _speech.listen(
            onResult: (val) => setState(() {
              _controller.text = val.recognizedWords;
              _calculateResult(_controller.text);
            }),
          );
        }
      } else {
        setState(() => _isListening = false);
        _speech.stop();
      }
    } else {
      Fluttertoast.showToast(
        msg: "Permiso de micrófono denegado",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _showHistory(context),
          child: Text('Calculadora Automática'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
              child: TextField(
                controller: _controller,
                readOnly: true,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingresa la expresión',
                  suffixIcon: IconButton(
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    onPressed: _listen,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    _buildButton('('),
                    _buildButton(')'),
                    _buildButton('C', onPressed: _clearExpression),
                    _buildButton('G', onPressed: _saveToHistory),
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('/'),
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('*'),
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-'),
                    _buildButton('.'),
                    _buildButton('0'),
                    _buildButton('='),
                    _buildButton('+'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Resultado: $_result',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String value, {VoidCallback? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed ?? () {
        if (value == '=') {
          _calculateResult(_controller.text);
        } else {
          _appendToExpression(value);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        textStyle: TextStyle(fontSize: 24),
      ),
      child: Text(value),
    );
  }
}
