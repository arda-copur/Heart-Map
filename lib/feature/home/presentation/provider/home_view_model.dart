import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heartmap/core/error/app_error.dart';
import 'package:heartmap/core/error/error_manager.dart';

class HomeViewModel with ChangeNotifier {
  late ConfettiController _confettiController;
  late AnimationController _shakeController;
  bool _isMapLoaded = false;
  GoogleMapController? _mapController;

  HomeViewModel(TickerProvider vsync) {
    try {
      _confettiController =
          ConfettiController(duration: const Duration(seconds: 5));
      _shakeController = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: vsync,
      );
    } catch (e, stack) {
      ErrorManager.handleError(
        AppError(
            message: "Animasyonlar başlatılırken hata oluştu.",
            type: ErrorType.unknown,
            exception: e,
            stackTrace: stack),
      );
    }
  }

  bool get isMapLoaded => _isMapLoaded;
  ConfettiController get confettiController => _confettiController;
  AnimationController get shakeController => _shakeController;
  GoogleMapController? get mapController => _mapController;

  void setMapLoaded(bool value) {
    _isMapLoaded = value;
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) async {
    try {
      _mapController = controller;
      setMapLoaded(true);
    } catch (e, stack) {
      ErrorManager.handleError(
        AppError(
            message: "MapController oluşturulurken hata oluştu.",
            type: ErrorType.unknown,
            exception: e,
            stackTrace: stack),
      );
    }
  }

  void playConfetti() {
    try {
      _confettiController.play();
    } catch (e, stack) {
      ErrorManager.handleError(
        AppError(
            message: "Confetti oynatılırken hata oluştu.",
            type: ErrorType.unknown,
            exception: e,
            stackTrace: stack),
      );
    }
  }

  void shake() {
    try {
      _shakeController.forward(from: 0);
    } catch (e, stack) {
      ErrorManager.handleError(
        AppError(
            message: "Shake animasyonu oynatılırken hata oluştu.",
            type: ErrorType.unknown,
            exception: e,
            stackTrace: stack),
      );
    }
  }

  @override
  void dispose() {
    try {
      _confettiController.dispose();
      _shakeController.dispose();
    } catch (e, stack) {
      ErrorManager.handleError(
        AppError(
            message: "Dispose sırasında hata oluştu.",
            type: ErrorType.unknown,
            exception: e,
            stackTrace: stack),
      );
    }
    super.dispose();
  }
}
