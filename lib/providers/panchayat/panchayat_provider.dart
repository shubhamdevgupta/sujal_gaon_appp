import 'package:flutter/cupertino.dart';

import '../../models/vwsc/vwsc_member_list.dart';
import '../../models/vwsc/vwsc_ps_response.dart';
import '../../repository/panchayat/panchayat_repo.dart';

class PanchayatProvider extends ChangeNotifier {
  final PanchayatRepo _panchayatRepo;
  PanchayatProvider(this._panchayatRepo);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  VwscListResponse? _vwscListResponse;

  VwscListResponse? get vwscListResponse => _vwscListResponse;
  List<VwscMember> vwscMember = [];

  Future<void> fetchVwscMemberList(
    int userId,
    int stateId,
    int panchayatId,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final vwscListResponse = await _panchayatRepo.fetchVwscMemberList(
        userId,
        stateId,
        panchayatId,
      );
      if (vwscListResponse.status == true) {
        vwscMember = vwscListResponse.members;
      }
    } catch (e) {
      debugPrint("Error fetching block: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchVwscList(int userId, int stateId, int panchayatId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final rawResponse = await _panchayatRepo.fetchVwscList(
        userId,
        stateId,
        panchayatId,
      );
    } catch (e) {
      debugPrint("Error fetching block: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
