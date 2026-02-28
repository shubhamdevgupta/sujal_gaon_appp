import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/repository/ftk_shg/ftk_shg_repo.dart';
import 'package:jal_sanchalan/repository/vwsc/vwsc_repo.dart';

import '../../models/vwsc/njm_ftk_memberList.dart';

class VwscProvider extends ChangeNotifier {
  final VwscRepo _vwscRepo = VwscRepo();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<NjmFtKMember> njmFtkUsers = [];

  Future<void> fetchNjmFtkUser(
    int userTypeId,
    int userId,
    int stateId,
    int regId,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final rawResponse = await _vwscRepo.fetchNjmFtkUser(
        userTypeId,
        userId,
        stateId,
        regId
      );
      if(rawResponse.status==true){
        njmFtkUsers=rawResponse.registrationList;
      }else{
       njmFtkUsers=[];
      }
    } catch (e) {
      debugPrint("Error fetching block: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
