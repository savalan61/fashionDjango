import 'package:flutter/cupertino.dart';

class PasswordNotifier with ChangeNotifier {
  bool _password = false;
  bool get password => _password;

  void setPassword() {
    _password = !_password;
    notifyListeners();
  }
}
