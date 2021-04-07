import 'dart:io';

import 'package:organize_flutter_project/src/business_logic/services/api_services/donor_api_services.dart';
import 'package:organize_flutter_project/src/business_logic/services/api_services/home_api_services.dart';
import 'package:organize_flutter_project/src/business_logic/services/api_services/profile_api_services.dart';
import 'package:organize_flutter_project/src/business_logic/services/api_services/request_api_services.dart';
import 'package:organize_flutter_project/src/business_logic/services/api_services/user_auth_api_services.dart';
import 'package:organize_flutter_project/src/business_logic/utils/api_response_object.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';

class _Repository {
  final UserAuthAPIServices _userAuthAPIServices = UserAuthAPIServices();
  final HomeAPIServices _homeAPIServices = HomeAPIServices();
  final DonorAPIServices _donorAPIServices = DonorAPIServices();
  final RequestAPIServices _requestAPIServices = RequestAPIServices();
  final ProfileAPIServices _profileAPIServices = ProfileAPIServices();

  Future<ResponseObject> checkEmailExists(
          String email, EmailExistCheck emailExistCheck) async =>
      _userAuthAPIServices.emailExistsOrNot(email, emailExistCheck);

  Future<ResponseObject> checkPhoneExists(String phone) async =>
      _userAuthAPIServices.phoneExistsOrNot(phone);

  Future<ResponseObject> register() async => _userAuthAPIServices.register();

  Future<ResponseObject> getHomeData() async => _homeAPIServices.getHomeData();

  Future<ResponseObject> changeDonorMode(int status) async =>
      _homeAPIServices.changeDonorMode(status);

  Future<ResponseObject> getAllNotifications() async =>
      _homeAPIServices.getAllNotifications();

  Future<ResponseObject> responsePersonalNotifications(
          int requestId, int response) async =>
      _homeAPIServices.responsePersonalNotifications(requestId, response);

  Future<ResponseObject> reactToActivity(int id) async =>
      _homeAPIServices.reactToActivity(id);

  Future<ResponseObject> activityAdd(
          {String address, File image, String description}) async =>
      _homeAPIServices.addNewActivity(
          address: address, image: image, description: description);

  Future<ResponseObject> getAllDonor() async => _donorAPIServices.getAllDonor();
  Future<ResponseObject> askForHelp(int requestTo, String message) async => _donorAPIServices.askForHelp(requestTo, message);
  Future<ResponseObject> getAllRequest() async => _requestAPIServices.getAllRequest();
  Future<ResponseObject> responseToRequest(int id) async => _requestAPIServices.responseToRequest(id);
  Future<ResponseObject> cancelRequest(int id) async => _requestAPIServices.cancelRequest(id);
  Future<ResponseObject> getProfileData() async => _profileAPIServices.getProfileData();
  Future<ResponseObject> updateProfileData() async => _profileAPIServices.updateProfileData();
  Future<ResponseObject> getAnotherProfile(int id) async => _profileAPIServices.getAnotherProfileData(id);
  Future<ResponseObject> createNewRequest(String address, String bloodFor, String bloodType, int units, String bloodGroup, String contact, String division) async => _requestAPIServices.createNewRequest(address, bloodFor, bloodType, units, bloodGroup, contact, division);
}

final repository = _Repository();
