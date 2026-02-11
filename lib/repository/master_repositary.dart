

import 'package:flutter/cupertino.dart';

import '../models/base_response.dart';
import '../models/block_model.dart';
import '../models/dictorey_model.dart';
import '../models/district_model.dart';
import '../models/gp_model.dart';
import '../models/habitaion_model.dart';
import '../models/state_model.dart';
import '../models/village_mdoel.dart';
import '../service/base_api_service.dart';
import '../utils/custom screen/global_exception_handler.dart';

class MasterRepositary {

  final BaseApiService _apiService =BaseApiService();

  Future<BaseResponseModel<Statelist>> fetchState() async {
    try {
      debugPrint("📡 fetchState() API Call Started");

      final token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiTmljIiwianRpIjoiNGU0MzczZjYtODVmYS00ZTdiLWJiYWItZjUzNjE1ZWNiYjUxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjpbIlJvbGUxIiwiUm9sZTIiXSwiZXhwIjoxNjU3MTA2OTQ5LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjU5OTIxIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo0MjAwIn0.bnqKmcJ-yBAo3OF8pdHBd0w4INzQplFDs51upRkNxto";

      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };

      debugPrint("🔐 Token Attached");

      final response = await _apiService.get(
        'GeoUnit/StatesList',
        headers: headers, // 👈 PASS HERE
      );

      debugPrint("✅ fetchState() Response Received:");
      debugPrint("📦 Response Data: $response");

      final result = BaseResponseModel<Statelist>.fromJson(
        response,
            (json) => Statelist.fromJson(json),
      );

      debugPrint("🎯 fetchState() Parsed Successfully");
      debugPrint("📊 Total States: ${result.result?.length ?? 0}");

      return result;

    } catch (e, stackTrace) {

      debugPrint("❌ fetchState() API Error");
      debugPrint("🔥 Error: $e");
      debugPrint("🧵 StackTrace: $stackTrace");

      rethrow;
    }
  }




  Future<BaseResponseModel<DistrictList>> fetchDistrict(String stateId) async {
    try {
      debugPrint("📡 fetchDistrict() API Call Started");

      final token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiTmljIiwianRpIjoiNGU0MzczZjYtODVmYS00ZTdiLWJiYWItZjUzNjE1ZWNiYjUxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjpbIlJvbGUxIiwiUm9sZTIiXSwiZXhwIjoxNjU3MTA2OTQ5LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjU5OTIxIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo0MjAwIn0.bnqKmcJ-yBAo3OF8pdHBd0w4INzQplFDs51upRkNxto";


      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      // ✅ New Endpoint
      final endpoint = "GeoUnit/Districtslist?Stateid=$stateId";

      debugPrint("➡️ District API URL: $endpoint");

      final response = await _apiService.get(
        endpoint,
        headers: headers,
      );

      debugPrint("✅ fetchDistrict() Response:");
      debugPrint("📦 $response");

      final result = BaseResponseModel<DistrictList>.fromJson(
        response,
            (json) => DistrictList.fromJson(json),
      );

      debugPrint("🎯 fetchDistrict() Parsed Successfully");
      debugPrint("📊 Total Districts: ${result.result.length}");

      return result;

    } catch (e, stackTrace) {

      debugPrint("❌ fetchDistrict() API Error");
      debugPrint("🔥 Error: $e");
      debugPrint("🧵 StackTrace: $stackTrace");

      rethrow;
    }
  }


  Future<BaseResponseModel<Blocklist>> fetchBlock(String districtId) async {
    try {
      debugPrint("📡 fetchBlock() API Call Started");

      final token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiTmljIiwianRpIjoiNGU0MzczZjYtODVmYS00ZTdiLWJiYWItZjUzNjE1ZWNiYjUxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjpbIlJvbGUxIiwiUm9sZTIiXSwiZXhwIjoxNjU3MTA2OTQ5LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjU5OTIxIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo0MjAwIn0.bnqKmcJ-yBAo3OF8pdHBd0w4INzQplFDs51upRkNxto";


      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };


      // ✅ Block API Endpoint
      final endpoint = "GeoUnit/Blockslist?Districtid=$districtId";

      debugPrint("➡️ Block API URL: $endpoint");

      final response = await _apiService.get(
        endpoint,
        headers: headers,
      );

      debugPrint("✅ fetchBlock() Response:");
      debugPrint("📦 $response");

      final result = BaseResponseModel<Blocklist>.fromJson(
        response,
            (json) => Blocklist.fromJson(json),
      );

      debugPrint("🎯 fetchBlock() Parsed Successfully");
      debugPrint("📊 Total Blocks: ${result.result.length}");

      return result;

    } catch (e, stackTrace) {

      debugPrint("❌ fetchBlock() API Error");
      debugPrint("🔥 Error: $e");
      debugPrint("🧵 StackTrace: $stackTrace");

      rethrow;
    }
  }



  Future<BaseResponseModel<Grampanchayatlist>> fetchGramPanchayat(
      String blockId) async {

    try {
      debugPrint("📡 fetchGramPanchayat() API Call Started");

      final token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiTmljIiwianRpIjoiNGU0MzczZjYtODVmYS00ZTdiLWJiYWItZjUzNjE1ZWNiYjUxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjpbIlJvbGUxIiwiUm9sZTIiXSwiZXhwIjoxNjU3MTA2OTQ5LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjU5OTIxIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo0MjAwIn0.bnqKmcJ-yBAo3OF8pdHBd0w4INzQplFDs51upRkNxto";


      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };


      // ✅ GP API
      final endpoint = "GeoUnit/Gplist?Blockid=$blockId";

      debugPrint("➡️ GP API URL: $endpoint");

      final response = await _apiService.get(
        endpoint,
        headers: headers,
      );

      debugPrint("✅ fetchGramPanchayat() Response:");
      debugPrint("📦 $response");

      final result = BaseResponseModel<Grampanchayatlist>.fromJson(
        response,
            (json) => Grampanchayatlist.fromJson(json),
      );

      debugPrint("🎯 fetchGramPanchayat() Parsed Successfully");
      debugPrint("📊 Total GPs: ${result.result.length}");

      return result;

    } catch (e, stackTrace) {

      debugPrint("❌ fetchGramPanchayat() API Error");
      debugPrint("🔥 Error: $e");
      debugPrint("🧵 StackTrace: $stackTrace");

      rethrow;
    }
  }


  Future<BaseResponseModel<Villagelist>> fetchVillage(
      String panchayatId) async {

    try {
      debugPrint("📡 fetchVillage() API Call Started");

      final token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiTmljIiwianRpIjoiNGU0MzczZjYtODVmYS00ZTdiLWJiYWItZjUzNjE1ZWNiYjUxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjpbIlJvbGUxIiwiUm9sZTIiXSwiZXhwIjoxNjU3MTA2OTQ5LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjU5OTIxIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo0MjAwIn0.bnqKmcJ-yBAo3OF8pdHBd0w4INzQplFDs51upRkNxto";


      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      // ✅ Village API
      final endpoint = "GeoUnit/Villagelist?PanchayatId=$panchayatId";

      debugPrint("➡️ Village API URL: $endpoint");

      final response = await _apiService.get(
        endpoint,
        headers: headers,
      );

      debugPrint("✅ fetchVillage() Response:");
      debugPrint("📦 $response");

      final result = BaseResponseModel<Villagelist>.fromJson(
        response,
            (json) => Villagelist.fromJson(json),
      );

      debugPrint("🎯 fetchVillage() Parsed Successfully");
      debugPrint("📊 Total Villages: ${result.result.length}");

      return result;

    } catch (e, stackTrace) {

      debugPrint("❌ fetchVillage() API Error");
      debugPrint("🔥 Error: $e");
      debugPrint("🧵 StackTrace: $stackTrace");

      rethrow;
    }
  }


  Future<BaseResponseModel<HabitationList>> fetchHabitation(
      String villageId) async {

    try {
      debugPrint("📡 fetchHabitation() API Call Started");

      final token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiTmljIiwianRpIjoiNGU0MzczZjYtODVmYS00ZTdiLWJiYWItZjUzNjE1ZWNiYjUxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjpbIlJvbGUxIiwiUm9sZTIiXSwiZXhwIjoxNjU3MTA2OTQ5LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjU5OTIxIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo0MjAwIn0.bnqKmcJ-yBAo3OF8pdHBd0w4INzQplFDs51upRkNxto";


      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };



      // ✅ Habitation API
      final endpoint = "GeoUnit/Hblist?VillageId=$villageId";

      debugPrint("➡️ Habitation API URL: $endpoint");

      final response = await _apiService.get(
        endpoint,
        headers: headers,
      );

      debugPrint("✅ fetchHabitation() Response:");
      debugPrint("📦 $response");

      final result = BaseResponseModel<HabitationList>.fromJson(
        response,
            (json) => HabitationList.fromJson(json),
      );

      debugPrint("🎯 fetchHabitation() Parsed Successfully");
      debugPrint("📊 Total Habitations: ${result.result.length}");

      return result;

    } catch (e, stackTrace) {

      debugPrint("❌ fetchHabitation() API Error");
      debugPrint("🔥 Error: $e");
      debugPrint("🧵 StackTrace: $stackTrace");

      rethrow;
    }
  }


  Future<BaseResponseModel<RpwssResultList>> fetchDirectory(
      String stateId,
      String districtId,
      String blockId,
      String panchayatId,
      String villageId,
      String habitationId,
      ) async {

    try {
      debugPrint("📡 fetchDirectory() API Call Started");

      final token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiTmljIiwianRpIjoiNGU0MzczZjYtODVmYS00ZTdiLWJiYWItZjUzNjE1ZWNiYjUxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjpbIlJvbGUxIiwiUm9sZTIiXSwiZXhwIjoxNjU3MTA2OTQ5LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjU5OTIxIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo0MjAwIn0.bnqKmcJ-yBAo3OF8pdHBd0w4INzQplFDs51upRkNxto";


      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      // ✅ CORRECT PATH (MAIN FIX)
      final endpoint =
          "api/RPWSS/RPWSS_Result_Lsit_BY_Directory"
          "?StateId=$stateId"
          "&DistrictID=$districtId"
          "&BlockId=$blockId"
          "&Panchayatid=$panchayatId"
          "&VillageId=$villageId"
          "&HabitationId=$habitationId"
          "&UserID=0";

      debugPrint("➡️ Directory API URL: $endpoint");

      final response = await _apiService.get(
        endpoint,
        headers: headers,
      );

      debugPrint("✅ fetchDirectory() Response:");
      debugPrint("📦 $response");

      final result = BaseResponseModel<RpwssResultList>.fromJson(
        response,
            (json) => RpwssResultList.fromJson(json),
      );

      debugPrint("🎯 fetchDirectory() Parsed Successfully");
      debugPrint("📊 Total Directory: ${result.result.length}");

      return result;

    } catch (e, stackTrace) {

      debugPrint("❌ fetchDirectory() API Error");
      debugPrint("🔥 Error: $e");
      debugPrint("🧵 StackTrace: $stackTrace");

      rethrow;
    }
  }




}