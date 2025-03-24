import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heartmap/core/services/locator/service_locator.dart';
import 'package:heartmap/core/services/audio/audio_manager.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_bloc.dart';
import 'package:provider/provider.dart';

class AppInit {
  static Future<void> initializeApp(Widget app) async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    setupServiceLocator();

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AudioManager>(
            create: (_) => getIt<AudioManager>(),
          ),
          BlocProvider<CityGameBloc>(
            create: (context) => getIt<CityGameBloc>(),
          ),
        ],
        child: app,
      ),
    );
  }
}
