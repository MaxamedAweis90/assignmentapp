import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';

class Question3Page extends StatefulWidget {
  @override
  _Question3PageState createState() => _Question3PageState();
}

class _Question3PageState extends State<Question3Page> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  String audioUrl = '';
  String? localFilePath;
  Duration duration = Duration();
  Duration position = Duration();
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });
    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });
  }

  void playPauseAudio() {
    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      if (localFilePath != null) {
        _audioPlayer.play(DeviceFileSource(localFilePath!));
      } else if (audioUrl.isNotEmpty) {
        _audioPlayer.play(UrlSource(audioUrl));
      }
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void stopAudio() {
    _audioPlayer.stop();
    setState(() {
      isPlaying = false;
      position = Duration();
    });
  }

  void pickLocalFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null) {
      setState(() {
        localFilePath = result.files.single.path;
        audioUrl = '';
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Question 3: Audio Player')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: 'Enter audio URL',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  audioUrl = value;
                  localFilePath = null;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: playPauseAudio,
                  child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                ),
                SizedBox(width: 20),
                ElevatedButton(onPressed: stopAudio, child: Icon(Icons.stop)),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: pickLocalFile,
                  child: Icon(Icons.upload_file),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              localFilePath != null
                  ? 'Playing Local File'
                  : (audioUrl.isNotEmpty ? 'Playing URL' : 'No Audio Selected'),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Slider(
              value: position.inSeconds.toDouble(),
              min: 0.0,
              max: duration.inSeconds.toDouble(),
              onChanged: (double value) {
                setState(() {
                  _audioPlayer.seek(Duration(seconds: value.toInt()));
                });
              },
            ),
            Text(
              '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
