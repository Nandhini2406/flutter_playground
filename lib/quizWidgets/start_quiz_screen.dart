import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/notification_service.dart';
import '../customWidgets/CustomButton.dart';
import '../customWidgets/styledText.dart';

class StartQuizScreen extends StatefulWidget {
  StartQuizScreen(this.startQuiz, {super.key});
  final void Function() startQuiz;

  @override
  State<StartQuizScreen> createState() => _StartQuizScreenState();
}

class _StartQuizScreenState extends State<StartQuizScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  String? filePath;
  bool _isMuted = false;

  void pickAudio() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (result != null) {
      setState(() {
        filePath = result.files.first.path;
        prefs.setString('FilePath', filePath!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMuteSetting();
  }

  _loadMuteSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isMuted = prefs.getBool('muteSetting') ?? false;
    });
  }

  _saveMuteSetting(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('muteSetting', value);
    NotificationService().setNotificationMute(value);
  }

// _showTimePickerModal() async {}

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/quiz.png',
            width: 200.0,
            height: 200.0,
          ),
          const SizedBox(height: 40.0),
          const StyledText(
            'Are you Flutter nerd? Try this!',
            textColor: Colors.white,
            textSize: 20,
            textWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40.0),
          CustomButton(
            bgColor: const Color.fromARGB(100, 0, 0, 0),
            onPressed: widget.startQuiz,
            buttonText: 'Start Quiz',
          ),
          Row(
            children: [
              const Text('Mute Notifications at Night'),
              Switch(
                value: _isMuted,
                onChanged: (value) {
                  setState(() {
                    print(value);
                    _isMuted = value;
                  });
                  _saveMuteSetting(value);
                },
              ),
            ],
          ),
          if (_isMuted)
            ElevatedButton(
              onPressed: () {},
              child: const Text('Set Mute Timing'),
            ),
          ElevatedButton(
            onPressed: pickAudio,
            child: const Text('pick'),
          )
        ],
      ),
    );
  }
}
