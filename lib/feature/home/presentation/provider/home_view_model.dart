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
  bool _isDisposed = false;

  HomeViewModel(TickerProvider vsync) {
    try {
      _confettiController =
          ConfettiController(duration: const Duration(seconds: 2));
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
      if (_mapController != null && _mapController != controller) {
        _mapController!.dispose();
      }

      _mapController = controller;
      debugPrint("MapController oluşturuldu");
      setMapLoaded(true);
    } catch (e, stack) {
      debugPrint("MapController oluşturulurken hata: $e");
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
    if (_isDisposed) return;
    _isDisposed = true;

    try {
      if (_confettiController.state != ConfettiControllerState.disposed) {
        _confettiController.dispose();
      }
      if (_shakeController.isAnimating) {
        _shakeController.stop();
      }
      _shakeController.dispose();
      if (_mapController != null) {
        _mapController!.dispose();
        _mapController = null;
      }
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
