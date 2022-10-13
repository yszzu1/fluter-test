import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String _ipAndPort = '192.168.3.34:81';

  void _startFFMpegSession() {
    setState(() {
      _counter++;
    });
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    print(timestamp);
    FFmpegKitConfig.selectDocumentForWrite(
            'video' + timestamp + '.mp4', 'video/*')
        .then((uri) {
      FFmpegKitConfig.getSafParameterForWrite(uri!).then((safUrl) {
        FFmpegKit.executeAsync("-i http://" + _ipAndPort + "/stream ${safUrl}");
      });
    });
  }

  void _closeFFMpegSession() {
    setState(() {
      _counter--;
      print('closeAllSession');
      FFmpegKit.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: _startFFMpegSession,
                  tooltip: 'startSession',
                  child: const Icon(Icons.add),
                ),
                SizedBox(
                  width: 30,
                ),
                FloatingActionButton(
                  onPressed: _closeFFMpegSession,
                  tooltip: 'CloseSession',
                  child: const Icon(Icons.add_alert),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'You have pushed the button this many times:' + '$_counter',
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ip:Port',
              ),
              onSubmitted: (txt) {
                setState(() {
                  _ipAndPort = txt;
                  print(_ipAndPort);
                });
              },
            ),
            Text('current ip port $_ipAndPort')
          ],
        ),
      ),
    );
  }
}
