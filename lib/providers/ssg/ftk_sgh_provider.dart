import 'package:flutter/cupertino.dart';

import '../../repository/ftk_ssg/ftk_ssg_repo.dart';

class SsgProvider extends ChangeNotifier {
  final SSGRepo _njmRepo = SSGRepo();
  bool _isLoading = false;

  bool get isLoading => _isLoading;



}
