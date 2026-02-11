import 'package:flutter/material.dart';

import '../repository/login_repo.dart';



class LoginProvider with ChangeNotifier {
  final LoginRepository _repository = LoginRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;



}
