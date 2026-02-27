import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/repository/ftk_repo.dart';

class FtkSghProvider extends ChangeNotifier {
  final FtkRepo _njmRepo = FtkRepo();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchBlock(
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
      final rawBlock = await _njmRepo.registerNJMWSO(
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


  Future<void> fetchNJMUser(
    int userTypeId,
    int userId,
    int stateId,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final rawBlock = await _njmRepo.fetchNJMUser(
        userTypeId,
        userId,
        stateId,
      );
    } catch (e) {
      debugPrint("Error fetching block: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
