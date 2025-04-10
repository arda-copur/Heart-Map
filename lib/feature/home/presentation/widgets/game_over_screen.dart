import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heartmap/core/theme/app_theme.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_bloc.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_event.dart';

class GameOverScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const GameOverScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    // Maksimum puan hesabı (yaklaşık olarak)
    final maxPossibleScore = totalQuestions * 50;

    // Başarı oranı
    final successRate = (score / maxPossibleScore) * 100;

    // Başarı mesajı
    String successMessage;
    if (successRate >= 80) {
      successMessage = "Tebrikler! Harita Uzmanısın! 🏆";
    } else if (successRate >= 60) {
      successMessage = "Çok İyi! Neredeyse bir harita uzmanısın! 🥈";
    } else if (successRate >= 40) {
      successMessage = "İyi! Ama biraz daha çalışmalısın! 🥉";
    } else if (successRate >= 20) {
      successMessage = "Fena değil. Tekrar dene! 🗺️";
    } else {
      successMessage = "Bir haritaya ihtiyacın var! 🧭";
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
      ),
      child: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(25),
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Oyun Bitti!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.appColorSheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Puan bilgisi
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppTheme.appColorSheme.surface,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Toplam Puanınız',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 30),
                          const SizedBox(width: 10),
                          Text(
                            score.toString(),
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.appColorSheme.inverseSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                Text(
                  successMessage,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Butonlar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        BlocProvider.of<CityGameBloc>(context)
                            .add(RestartGameEvent());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Yeniden Başla'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.appColorSheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Ana menüye dönmeden önce bloc'u resetleyelim
                        BlocProvider.of<CityGameBloc>(context)
                            .add(RestartGameEvent());
                            
                        // CountrySelectionPage'e yönlendir
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('Ana Menü'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.appColorSheme.secondary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
