import 'package:flutter/material.dart';
import 'package:heartmap/core/route/navigation_service.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void init() {}

  @override
  void dispose() {
    super.dispose();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void navigateTo(String routeName, {Object? arguments}) {
    NavigationService.pushNamed(routeName, arguments: arguments);
  }

  void goBack(BuildContext context, {dynamic result}) {
    Navigator.pop(context, result);
  }

  Future<bool> onBackPressed() async {
    return true;
  }
}
