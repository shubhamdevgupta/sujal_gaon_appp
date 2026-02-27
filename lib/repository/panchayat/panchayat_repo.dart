import '../../models/vwsc/vwsc_member_list.dart';
import '../../models/vwsc/vwsc_ps_response.dart';
import '../../service/base_api_service.dart';
import '../../utils/global_exception_handler.dart';

class PanchayatRepo {
  final BaseApiService _apiService = BaseApiService();

  Future<VwscListResponse> fetchVwscList(
    int userId,
    int stateId,
    int panchayatId,
  ) async {
    try {
      final response = await _apiService.get(
        '/SJL_GetVWSC_PS_UG_list?UserId=$userId&StateId=$stateId&PanchayatId=$panchayatId',
      );

      return VwscListResponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<VwscMembersResponse> fetchVwscMemberList(
    int userId,
    int stateId,
    int panchayatId,
  ) async {
    try {
      final response = await _apiService.get(
        'SJL_GetVWSC_Members_list?UserId=$userId&StateId=$stateId&PanchayatId=$panchayatId',
      );

      return VwscMembersResponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
