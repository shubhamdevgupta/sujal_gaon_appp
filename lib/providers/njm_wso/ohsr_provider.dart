import 'package:flutter/cupertino.dart';

import '../../repository/njm_wso/njm_wso_repo.dart';

class OhsrProvider extends ChangeNotifier {
  final NjmWsoRepo _njmWsoRepo;

  OhsrProvider(this._njmWsoRepo);

  final capacityController = TextEditingController(text: "100"); // auto
  final numberOfReservoirsController = TextEditingController();

  final Map<String, int> yesNoMap = {"yes": 1, "no": 0};

  String? _isWaterRecived;
  String? get isWaterRecived => _isWaterRecived;
  int? _isWaterRecivedId;
  int? get isWaterRecivedId => _isWaterRecivedId;

  String? _flowMeter;
  String? get flowMeter => _flowMeter;
  int? _flowMeterId;
  int? get flowmeterId => _flowMeterId;

  void setWaterRecipt(String? label) {
    _isWaterRecived = label;
    if (label != null) {
      _isWaterRecivedId = yesNoMap[label];
    } else {
      _isWaterRecivedId = null;
    }
    notifyListeners();
  }

  void setFlowMeter(String? label) {
    _flowMeter=label;
    if (label != null) {
      _flowMeterId = yesNoMap[label];
    } else {
      _flowMeterId = null;
    }
    notifyListeners();
  }
}
