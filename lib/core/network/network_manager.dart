import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class NetworkManager extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  NetworkManager() {
    _init();
  }

  Future<void> _init() async {
    await _checkConnectivity();

    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      await _updateConnectionStatus(results);
    });
  }

  Future<void> _checkConnectivity() async {
    List<ConnectivityResult> connectivityResults =
        await _connectivity.checkConnectivity();
    await _updateConnectionStatus(connectivityResults);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    bool newStatus = !results.contains(ConnectivityResult.none);
    if (_isConnected != newStatus) {
      _isConnected = newStatus;
      notifyListeners();
    }
  }
}
