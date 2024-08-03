import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.microphone.request();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mic to Speaker with Effects',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterSoundPlayer _player = FlutterSoundPlayer();
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  String _path = 'audio.aac';

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    await _player.openPlayer();
    await _recorder.openRecorder();
  }

  @override
  void dispose() {
    _player.closePlayer();
    _recorder.closeRecorder();
    super.dispose();
  }

  void _startRecording() async {
    await _recorder.startRecorder(
      toFile: _path,
      codec: Codec.aacADTS,
    );
  }

  void _stopRecording() async {
    await _recorder.stopRecorder();
    _applyAudioEffects();
  }

  void _applyAudioEffects() async {
    // Filtro básico para afinación de voz usando flutter_ffmpeg
    String command = '-i $_path -af "asetrate=44100*1.25,aresample=44100,atempo=1.25" output.aac';
    await _flutterFFmpeg.execute(command).then((rc) => print("FFmpeg process exited with rc $rc"));

    _player.startPlayer(fromURI: 'output.aac');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mic to Speaker with Effects'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _startRecording,
              child: Text('Start'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _stopRecording,
              child: Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
