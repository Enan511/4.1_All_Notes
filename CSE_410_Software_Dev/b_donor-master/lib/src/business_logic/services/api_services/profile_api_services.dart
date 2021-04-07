import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organize_flutter_project/src/business_logic/models/profile_model.dart';
import 'package:organize_flutter_project/src/business_logic/models/user_profile_view_model.dart';
import 'package:organize_flutter_project/src/business_logic/services/hive_services/hive_services.dart';
import 'package:organize_flutter_project/src/business_logic/utils/api_response_object.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';

class ProfileAPIServices {
  final _client = http.Client();

  // get user profile data
  Future<ResponseObject> getProfileData() async {
    try {
      final _response = await _client.post(BASE_URL + 'profile',
          body: {'user_id': UserData.userId.toString()});
      print(jsonDecode(_response.body));
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        print(decodedResponse);
        return ResponseObject(
            id: ResponseCode.SUCCESSFUL,
            object: ProfileModel.fromJson(decodedResponse));
      } else {
        return ResponseObject(
            id: ResponseCode.FAILED,
            object: 'Status code for request ${_response.statusCode}');
      }
    } catch (e) {
      return ResponseObject(id: ResponseCode.FAILED, object: e.toString());
    }
  }

  // get other profile view
  Future<ResponseObject> getAnotherProfileData(int id) async {
    try {
      print(id);
      final _response = await _client.post(BASE_URL + 'getUserProfileView',
          body: {'profile_id': UserData.userId.toString(), 'user_id' : id.toString()});
      print(jsonDecode(_response.body));
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        print(decodedResponse);
        return ResponseObject(
            id: ResponseCode.SUCCESSFUL,
            object: UserProfileViewModel.fromJson(decodedResponse));
      } else {
        return ResponseObject(
            id: ResponseCode.FAILED,
            object: 'Status code for request ${_response.statusCode}');
      }
    } catch (e) {
      return ResponseObject(id: ResponseCode.FAILED, object: e.toString());
    }
  }

  // update user details
  Future<ResponseObject> updateProfileData() async {
    try {
      final _response = await _client.post(BASE_URL + 'updateProfile',
          body: {
            'user_id': UserData.userId.toString(),
            'name' : UpdateUserData.name,
            'gender' : UpdateUserData.gender,
            'address' : UpdateUserData.address,
            'zip_code' : UpdateUserData.zipCode,
            'division' : UpdateUserData.division,
            'bloodGroup' : UpdateUserData.bloodGroup,
            'contactVisible' : UpdateUserData.contactVisible,
          });
      print(jsonDecode(_response.body));
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        print(decodedResponse);
        if (decodedResponse['error'] == false){
          HiveServices.addStringData(name: 'name', data: UpdateUserData.name);
          return ResponseObject(
              id: ResponseCode.SUCCESSFUL,
              object: ProfileModel.fromJson(decodedResponse));
        } else {
          return ResponseObject(
              id: ResponseCode.FAILED,
              object: 'Profile update failed! Try again.');
        }
      } else {
        return ResponseObject(
            id: ResponseCode.FAILED,
            object: 'Status code for request ${_response.statusCode}');
      }
    } catch (e) {
      return ResponseObject(id: ResponseCode.FAILED, object: e.toString());
    }
  }
}
