import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/repository/ftk_shg/ftk_shg_repo.dart';

class FtkSghProvider extends ChangeNotifier {
  final FtkRepo _njmRepo = FtkRepo();
  bool _isLoading = false;

  bool get isLoading => _isLoading;



}
