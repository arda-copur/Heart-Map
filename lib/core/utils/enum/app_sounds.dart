enum AppSounds { menu, correctAnswer, wrongAnswer }

extension AppSoundsExtension on AppSounds {
  String get path {
    switch (this) {
      case AppSounds.menu:
        return "sounds/menu_sound.mp3";
      case AppSounds.correctAnswer:
        return "sounds/correct_sound.mp3";
      case AppSounds.wrongAnswer:
        return "sounds/wrong_sound.mp3";
    }
  }
}
