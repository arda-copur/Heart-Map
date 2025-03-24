enum PngImageItems { miu, miuIconSecond, c, d }

extension PngImageItemsExtension on PngImageItems {
  String _imagePath() {
    switch (this) {
      case PngImageItems.miu:
        return "miu_icon";

      case PngImageItems.miuIconSecond:
        return "miu_icon2";

      case PngImageItems.c:
        return "c";

      case PngImageItems.d:
        return "d";
    }
  }

  String get imagePath => "assets/icons/${_imagePath()}.png";
}

enum JpegImageItems { a, b, c, d }

extension JpgImageItemsExtension on JpegImageItems {
  String _imagePath() {
    switch (this) {
      case JpegImageItems.a:
        return "a";

      case JpegImageItems.b:
        return "b";

      case JpegImageItems.c:
        return "c";

      case JpegImageItems.d:
        return "d";
    }
  }

  String get imagePath => "assets/images/${_imagePath()}.jpeg";
}

enum AnimationImageItems { appSplash, appBackground, appLoading }

extension AnimationImageItemsExtension on AnimationImageItems {
  String _imagePath() {
    switch (this) {
      case AnimationImageItems.appSplash:
        return "app_splash";

      case AnimationImageItems.appBackground:
        return "app_background";
      case AnimationImageItems.appLoading:
        return "app_loading";
    }
  }

  String get imagePath => "assets/animation/${_imagePath()}.gif";
}
