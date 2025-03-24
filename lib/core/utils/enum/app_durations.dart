enum AppDurations {
  //Standart
  short(Duration(milliseconds: 200)),
  medium(Duration(milliseconds: 500)),
  long(Duration(seconds: 1)),
  extraLong(Duration(seconds: 2)),

  // Animasyon süreleri
  fastAnimation(Duration(milliseconds: 150)),
  normalAnimation(Duration(milliseconds: 300)),
  slowAnimation(Duration(milliseconds: 600)),
  extraSlowAnimation(Duration(milliseconds: 800)),

  // Zaman aşımı süreleri
  requestTimeout(Duration(seconds: 10)),
  connectionTimeout(Duration(seconds: 15)),

  // Snackbar & Toast gösterim süreleri
  snackbarDuration(Duration(seconds: 3)),
  toastDuration(Duration(seconds: 2)),

  // Gecikme süreleri
  debounceTime(Duration(milliseconds: 300)),
  throttleTime(Duration(milliseconds: 500));

  final Duration duration;
  const AppDurations(this.duration);
}
