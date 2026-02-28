import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/repository/ftk_shg/ftk_shg_repo.dart';

class FtkSghProvider extends ChangeNotifier {
  final FtkRepo _njmRepo = FtkRepo();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> registerNjmFTK(
    String username,
    int userId,
    String firstName,
    String lastName,
    int mobileNumber,
    String address,
    String designation,
    String email,
    String stateId,
    String districtId,
    String blockId,
    String panchayatId,
    String villageId,
    String levelTraining,
    String ipAddress,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final rawResponse = await _njmRepo.registerNjmFTK(
        username,
        userId,
        firstName,
        lastName,
        mobileNumber,
        address,
        designation,
        email,
        stateId,
        districtId,
        blockId,
        panchayatId,
        villageId,
        levelTraining,
        ipAddress,
      );
    } catch (e) {
      debugPrint("Error fetching block: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
