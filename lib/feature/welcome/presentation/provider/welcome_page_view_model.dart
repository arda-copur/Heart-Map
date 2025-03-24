import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heartmap/core/base/base_view_model.dart';
import 'package:heartmap/core/error/app_error.dart';
import 'package:heartmap/core/error/error_manager.dart';
import 'package:heartmap/core/network/network_manager.dart';
import 'package:heartmap/core/services/audio/audio_manager.dart';
import 'package:heartmap/core/utils/app_dialog.dart';
import 'package:heartmap/core/utils/enum/app_sounds.dart';
import 'package:heartmap/core/utils/enum/app_durations.dart';

class WelcomePageViewModel extends BaseViewModel {
  late AnimationController buttonController;
  late Animation<Offset> buttonAnimation;
  final ValueNotifier<bool> buttonsVisible = ValueNotifier(false);

  final AudioManager _audioManager = AudioManager();
  final NetworkManager _networkManager = NetworkManager();

  bool get isConnected => _networkManager.isConnected;

  WelcomePageViewModel() {
    _networkManager.addListener(_onNetworkChanged);
  }

  void _onNetworkChanged() {
    notifyListeners();
  }

  void playMenuSound() {
    try {
      _audioManager.play(AppSounds.menu.path);
    } catch (e, stack) {
      ErrorManager.handleError(
        AppError(
            message: "Ses çalınırken hata oluştu!",
            type: ErrorType.unknown,
            exception: e,
            stackTrace: stack),
      );
    }
  }

  void initializeButtonAnimation(TickerProvider vsync) {
    try {
      buttonController = AnimationController(
        vsync: vsync,
        duration: AppDurations.extraSlowAnimation.duration,
      );

      buttonAnimation = Tween<Offset>(
        begin: const Offset(0, 1.5),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(
        parent: buttonController,
        curve: Curves.easeOut,
      ));

      Future.delayed(AppDurations.medium.duration, () {
        buttonsVisible.value = true;
        try {
          buttonController.forward();
        } catch (e, stack) {
          ErrorManager.handleError(
            AppError(message: "Animasyon başlatılamadı!", type: ErrorType.unknown, exception: e, stackTrace: stack),
          );
        }
        notifyListeners();
      });
    } catch (e, stack) {
      ErrorManager.handleError(
        AppError(message: "Animasyon başlatılırken hata oluştu!", type: ErrorType.unknown, exception: e, stackTrace: stack),
      );
    }
  }


  void goToPage(String routeName, {Object? arguments}) {
    try {
      navigateTo(routeName, arguments: arguments);
    } catch (e, stack) {
      ErrorManager.handleError(
        AppError(message: "Sayfaya yönlendirme hatası!", type: ErrorType.unknown, exception: e, stackTrace: stack),
      );
    }
  }
  void exitApp() {
    try {
      SystemNavigator.pop();
    } catch (e, stack) {
      ErrorManager.handleError(
        AppError(message: "Uygulamadan çıkış yapılamadı!", type: ErrorType.unknown, exception: e, stackTrace: stack),
      );
    }
  }

  
  void showNoInternetDialog(context) {
    AppDialog.show(
      context: context,
      title: "Bağlantı Hatası",
      message: "İnternet bağlantınız yok. Lütfen tekrar deneyin.",
      confirmText: "Tamam",
    );
  }

  @override
  void dispose() {
    buttonController.dispose();
    _audioManager.stop();
    _networkManager.removeListener(_onNetworkChanged);
    super.dispose();
  }
}
