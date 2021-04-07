import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organize_flutter_project/src/business_logic/services/hive_services/hive_services.dart';
import 'package:organize_flutter_project/src/business_logic/utils/api_response_object.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';

class UserAuthAPIServices {
  final _client = http.Client();

  // check into api that phone number is already registered or not
  Future<ResponseObject> phoneExistsOrNot(String phone) async {
    try {
      var _response =
      await _client.post(BASE_URL + 'checkPhoneExists', body: {'phone': phone});
      print(jsonDecode(_response.body));
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        print(decodedResponse);
        if (decodedResponse['error'] == false) {
          return ResponseObject(
              id: ResponseCode.SUCCESSFUL, object: 'not exists');
        } else {
          HiveServices.addIntegerData(
              name: 'id', data: int.parse(decodedResponse['user'][0]['id'].toString()));
          HiveServices.addStringData(
              name: 'email', data: decodedResponse['user'][0]['email'].toString());
          HiveServices.addStringData(
              name: 'name', data: decodedResponse['user'][0]['name'].toString());
          HiveServices.addStringData(
              name: 'phone', data: decodedResponse['user'][0]['phone'].toString());
          // UserData.userId = int.parse(decodedResponse['user'][0]['id'].toString());
          UserData.email = decodedResponse['user'][0]['email'].toString();
          UserData.name = decodedResponse['user'][0]['name'].toString();
          UserData.phone = decodedResponse['user'][0]['phone'].toString();
          return ResponseObject(
              id: ResponseCode.SUCCESSFUL, object: 'exists');
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

  // check into api that email is already registered or not
  Future<ResponseObject> emailExistsOrNot(String email, EmailExistCheck emailExistCheck) async {
    try {
      var _response =
      await _client.post(BASE_URL + 'checkEmailExists', body: {'email': email});
      print(jsonDecode(_response.body));
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        print(decodedResponse);
        if (decodedResponse['error'] == false) {
          return ResponseObject(id: ResponseCode.SUCCESSFUL, object: 'not exists');
        } else {
          if (emailExistCheck == EmailExistCheck.LoginCheck) {
            HiveServices.addIntegerData(
                name: 'id', data: int.parse(decodedResponse['user'][0]['id'].toString()));
            HiveServices.addStringData(
                name: 'email', data: decodedResponse['user'][0]['email']);
            HiveServices.addStringData(
                name: 'name', data: decodedResponse['user'][0]['name'].toString());
            HiveServices.addStringData(
                name: 'phone', data: decodedResponse['user'][0]['phone'].toString());
            // UserData.userId = int.parse(decodedResponse['user'][0]['id'].toString());
            UserData.email = decodedResponse['user'][0]['email'];
            UserData.name = decodedResponse['user'][0]['name'];
            UserData.phone = decodedResponse['user'][0]['phone'];
            return ResponseObject(
                id: ResponseCode.SUCCESSFUL, object: 'exists');
          } else {
            return ResponseObject(
                id: ResponseCode.SUCCESSFUL, object: 'exists');
          }
        }
      } else {
        return ResponseObject(
            id: ResponseCode.FAILED,
            object: 'Status code for request ${_response.statusCode}');
      }
    } catch (e) {
      print('Here accuors!');
      return ResponseObject(id: ResponseCode.FAILED, object: e.toString());
    }
  }

  // register new user
  Future<ResponseObject> register() async {
    try {
      final socialRegisterBody = {
        'email' : RegisterUserData.email,
        'name' : RegisterUserData.name,
        'phone' : RegisterUserData.phone,
        'gender' : RegisterUserData.gender,
        'address' : RegisterUserData.address,
        'bloodGroup' : RegisterUserData.bloodGroup,
        'socialLogin' : RegisterUserData.socialLogin,
        'contactVisible' : RegisterUserData.contactVisible,
        'zip_code' : RegisterUserData.zipCode,
        'division' : RegisterUserData.division,
        'socialId' : RegisterUserData.socialId,
      };
      final registerBody = {
        'email' : RegisterUserData.email,
        'name' : RegisterUserData.name,
        'phone' : RegisterUserData.phone,
        'gender' : RegisterUserData.gender,
        'address' : RegisterUserData.address,
        'bloodGroup' : RegisterUserData.bloodGroup,
        'socialLogin' : RegisterUserData.socialLogin,
        'contactVisible' : RegisterUserData.contactVisible,
        'zip_code' : RegisterUserData.zipCode,
        'division' : RegisterUserData.division,
      };
      var _response = RegisterUserData.socialLogin == '0' ? await _client.post(BASE_URL + 'register', body: registerBody) :  await _client.post(BASE_URL + 'register', body: socialRegisterBody);
      print(jsonDecode(_response.body));
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        print(decodedResponse);
        if (decodedResponse['error'] == false) {
          HiveServices.addIntegerData(name: 'id', data: int.parse(decodedResponse['id']));
          HiveServices.addStringData(name: 'email', data: RegisterUserData.email);
          HiveServices.addStringData(name: 'name', data: RegisterUserData.name);
          HiveServices.addStringData(name: 'phone', data: RegisterUserData.phone);
          // UserData.userId = int.parse(decodedResponse['id']);
          UserData.email = RegisterUserData.email;
          UserData.name = RegisterUserData.name;
          UserData.phone = RegisterUserData.phone;
          print('Error here');
          return ResponseObject(id: ResponseCode.SUCCESSFUL, object: 'Registration successful!');
        } else {
          return ResponseObject(id: ResponseCode.FAILED, object: 'Registration failed!');
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