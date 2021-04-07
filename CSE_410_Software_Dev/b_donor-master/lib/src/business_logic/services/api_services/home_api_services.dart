import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:organize_flutter_project/src/business_logic/models/home_model.dart';
import 'package:organize_flutter_project/src/business_logic/models/notification_model.dart';
import 'package:organize_flutter_project/src/business_logic/utils/api_response_object.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';
import 'package:path/path.dart';

class HomeAPIServices {
  final _client = http.Client();

  // check into api that email is already registered or not
  Future<ResponseObject> getHomeData() async {
    try {
      var _response = await _client.post(BASE_URL + 'getHomeData',
          body: {'user_id': UserData.userId.toString()});
      print(jsonDecode(_response.body));
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        print(decodedResponse);
        return ResponseObject(
            id: ResponseCode.SUCCESSFUL, object: HomeModel.fromJson(decodedResponse));
      } else {
        return ResponseObject(
            id: ResponseCode.FAILED,
            object: 'Status code for request ${_response.statusCode}');
      }
    } catch (e) {
      return ResponseObject(id: ResponseCode.FAILED, object: e.toString());
    }
  }

  // get all my notifications
  Future<ResponseObject> getAllNotifications() async {
    try {
      var _response = await _client.post(BASE_URL + 'getAllMyRequest',
          body: {'user_id': UserData.userId.toString()});
      print(jsonDecode(_response.body));
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        print(decodedResponse);
        return ResponseObject(
            id: ResponseCode.SUCCESSFUL, object: NotificationModel.fromJson(decodedResponse));
      } else {
        return ResponseObject(
            id: ResponseCode.FAILED,
            object: 'Status code for request ${_response.statusCode}');
      }
    } catch (e) {
      return ResponseObject(id: ResponseCode.FAILED, object: e.toString());
    }
  }

  // response to request
  Future<ResponseObject> responsePersonalNotifications(int requestId, int response) async {
    try {
      print(requestId);
      print(response);
      var _response = await _client.post(BASE_URL + 'responseToIndivisualRequest',
          body: {'request_id': requestId.toString(), 'user_response' : response.toString()});
      print(jsonDecode(_response.body));
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        print(decodedResponse);
        if (decodedResponse['error'] == false){
          return ResponseObject(
              id: ResponseCode.SUCCESSFUL, object: 'Response done');
        } else {
          return ResponseObject(
              id: ResponseCode.FAILED, object: 'Response to notification failed! Try again.');
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

  // change donor mode
  Future<ResponseObject> changeDonorMode(int status) async {
    try {
      var _response = await _client.post(BASE_URL + 'donorMode',
          body: {'user_id': UserData.userId.toString(), 'mode': status.toString()});
      print(jsonDecode(_response.body));
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        print(decodedResponse);
        return ResponseObject(
            id: ResponseCode.SUCCESSFUL, object: 'Donor mode changed!');
      } else {
        return ResponseObject(
            id: ResponseCode.FAILED,
            object: 'Status code for request ${_response.statusCode}');
      }
    } catch (e) {
      return ResponseObject(id: ResponseCode.FAILED, object: e.toString());
    }
  }

  // react to a activity
  Future<ResponseObject> reactToActivity(int id) async {
    try {
      var _response = await _client.post(BASE_URL + 'reactToActivity',
          body: {'user_id': UserData.userId.toString(), 'id': id.toString()});
      print(jsonDecode(_response.body));
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        print(decodedResponse);
        return ResponseObject(
            id: ResponseCode.SUCCESSFUL, object: 'React done!');
      } else {
        return ResponseObject(
            id: ResponseCode.FAILED,
            object: 'Status code for request ${_response.statusCode}');
      }
    } catch (e) {
      return ResponseObject(id: ResponseCode.FAILED, object: e.toString());
    }
  }

  // add new activity
  Future<ResponseObject> addNewActivity({String address, File image, String description}) async {
    try {
      Uri uri = Uri.parse(BASE_URL + 'addNewActivity');
      var request = new http.MultipartRequest("POST", uri);

      request.headers['Accept'] = 'application/json';

      request.fields['user_id'] = UserData.userId.toString();
      request.fields['address'] = address;
      request.fields['description'] = description;
      if (image != null){
        final activityPhoto = await _getMultipartFile(
            image, "activity_photo");
        request.files.add(activityPhoto);
      }

      print(request.headers);
      print(request.fields);
      print(request.files);
      var _response = await request.send();
      print(_response.statusCode.toString());

      final responseData =
      await _response.stream.transform(utf8.decoder).join();
      final responseJson = json.decode(responseData);
      print(responseJson);

      if (_response.statusCode == 200 || _response.statusCode == 201) {
        if (responseJson['error'] == false) {
          return ResponseObject(
              id: ResponseCode.SUCCESSFUL, object: 'Activity added!');
        } else {
          return ResponseObject(
              id: ResponseCode.FAILED, object: 'Activity add failed! Try again.');
        }
      } else {
        return ResponseObject(
            id: ResponseCode.FAILED, object: 'Activity add failed! Try again.');
      }
    } catch (e) {
      return ResponseObject(id: ResponseCode.FAILED, object: e.toString());
    }
  }

  Future<http.MultipartFile> _getMultipartFile(
      File file, String attribute) async {
    var stream = new http.ByteStream(file.openRead());
    stream.cast();
    var length = await file.length();

    final multipartFile = new http.MultipartFile(
      attribute,
      stream,
      length,
      filename: basename(file.path),
    );

    return multipartFile;
  }
}
