import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioManager extends ChangeNotifier {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  AudioPlayer? _audioPlayer;
  bool _isPlaying = false;
  String? _currentUrl;

  bool get isPlaying => _isPlaying;
  String? get currentUrl => _currentUrl;

  Future<void> play(String url) async {
    _audioPlayer ??= AudioPlayer();
    _currentUrl = url;
    await _audioPlayer!.play(AssetSource(url));
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> stop() async {
    if (_audioPlayer != null) {
      await _audioPlayer!.stop();
      _isPlaying = false;
      _currentUrl = null;
      notifyListeners();
    }
  }

  Future<void> pause() async {
    if (_audioPlayer != null) {
      await _audioPlayer!.pause();
      _isPlaying = false;
      notifyListeners();
    }
  }

  Future<void> resume() async {
    if (_audioPlayer != null) {
      await _audioPlayer!.resume();
      _isPlaying = true;
      notifyListeners();
    }
  }

  Future<void> setVolume(double volume) async {
    if (_audioPlayer != null) {
      await _audioPlayer!.setVolume(volume);
    }
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }
}
