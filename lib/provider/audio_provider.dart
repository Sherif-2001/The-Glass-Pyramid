import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _bgMusicPlayer = AudioPlayer();
  final AudioPlayer _typingPlayer = AudioPlayer();

  bool _canBGMusicPlay = true;
  bool _canSFXPlay = true;

  IconData _musicSettingsIcon = Icons.headset;
  IconData _sfxSettingsIcon = Icons.music_note;

  void playMusic() async {
    if (_bgMusicPlayer.state == PlayerState.stopped) {
      await _bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgMusicPlayer.play(AssetSource("audios/back_music.mp3"));
      notifyListeners();
    }
  }

  void pauseMusic() async {
    if (_bgMusicPlayer.state == PlayerState.playing) {
      await _bgMusicPlayer.pause();
    }
    notifyListeners();
  }

  void resumeMusic() async {
    if (_bgMusicPlayer.state == PlayerState.paused) {
      await _bgMusicPlayer.resume();
    }
    notifyListeners();
  }

  void disposeMusicPlayer() async {
    await _bgMusicPlayer.dispose();
    notifyListeners();
  }

  void checkMusicSettings() async {
    _canBGMusicPlay = !_canBGMusicPlay;
    if (_canBGMusicPlay) {
      await _bgMusicPlayer.resume();
      _musicSettingsIcon = Icons.headset;
    } else {
      await _bgMusicPlayer.pause();
      _musicSettingsIcon = Icons.headset_off;
    }
    notifyListeners();
  }

  IconData get musicSettingsIcon {
    return _musicSettingsIcon;
  }

// SFX Functions

  void playTypingAudio() {
    _typingPlayer.play(AssetSource("audios/typing.mp3"));

    notifyListeners();
  }

  void disposeTypingPlayer() async {
    await _typingPlayer.dispose();
    notifyListeners();
  }

  void stopTypingAudio() async {
    if (_typingPlayer.state == PlayerState.playing) {
      await _typingPlayer.stop();
    }
    notifyListeners();
  }

  void checkSFXSettings() async {
    _canSFXPlay = !_canSFXPlay;
    _sfxSettingsIcon = _canSFXPlay ? Icons.music_note : Icons.music_off;
    await _typingPlayer.setVolume(_canSFXPlay ? 1.0 : 0);
    notifyListeners();
  }

  IconData get sfxSettingsIcon {
    return _sfxSettingsIcon;
  }
}
