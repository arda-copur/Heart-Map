import 'package:flutter/material.dart';
import 'package:heartmap/core/theme/app_theme.dart';

class ScoreTimerDisplay extends StatelessWidget {
  final int score;
  final int timeRemaining;
  final int currentQuestion;
  final int totalQuestions;

  const ScoreTimerDisplay({
    super.key,
    required this.score,
    required this.timeRemaining,
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    // Renklendirilmiş zaman
    Color timerColor;
    if (timeRemaining > 10) {
      timerColor = Colors.green;
    } else if (timeRemaining > 5) {
      timerColor = Colors.orange;
    } else {
      timerColor = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Skor gösterimi
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Skor',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      score.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.appColorSheme.surfaceTint,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Soru sayısı
            Column(
              children: [
                const Text(
                  'Soru',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '$currentQuestion/$totalQuestions',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // Zaman gösterimi
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Süre',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.timer, color: timerColor, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      timeRemaining.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: timerColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
