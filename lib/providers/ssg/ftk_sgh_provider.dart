import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/repository/ftk_shg/ftk_shg_repo.dart';

class SsgProvider extends ChangeNotifier {
  final SSGRepo _njmRepo = SSGRepo();
  bool _isLoading = false;

  bool get isLoading => _isLoading;



}
