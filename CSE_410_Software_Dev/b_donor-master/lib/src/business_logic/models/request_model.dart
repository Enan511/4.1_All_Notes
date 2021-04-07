class RequestModel {
  bool error;
  int totalRequests;
  List<Requests> requests;

  RequestModel({this.error, this.totalRequests, this.requests});

  RequestModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    totalRequests = json['totalRequests'];
    if (json['requests'] != null) {
      requests = new List<Requests>();
      json['requests'].forEach((v) {
        requests.add(new Requests.fromJson(v));
      });
    }
  }
}

class Requests {
  Request request;
  UserDetails user;

  Requests({this.request, this.user});

  Requests.fromJson(Map<String, dynamic> json) {
    request =
    json['request'] != null ? new Request.fromJson(json['request']) : null;
    user = json['user'] != null ? new UserDetails.fromJson(json['user']) : null;
  }
}

class Request {
  int id;
  String address;
  String bloodFor;
  int units;
  String contact;
  String bloodGroup;
  int responseId;
  String time;
  int userId;
  int hide;
  String bloodType;
  String division;

  Request(
      {this.id,
        this.address,
        this.bloodFor,
        this.units,
        this.contact,
        this.bloodGroup,
        this.responseId,
        this.time,
        this.userId,
        this.hide,
        this.bloodType});

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    bloodFor = json['bloodFor'];
    units = json['units'];
    contact = json['contact'];
    bloodGroup = json['bloodGroup'];
    responseId = json['responseId'];
    time = json['time'];
    userId = json['userId'];
    hide = json['hide'];
    division = json['division'];
    bloodType = json['bloodType'];
  }
}

class UserDetails {
  int id;
  String name;
  String phone;
  String gender;
  String email;
  String address;
  String bloodGroup;
  int socialLogin;
  Null socialId;
  Null image;
  int contactVisiable;
  int donorMode;
  String zipCode;
  String division;
  Null lastDonation;

  UserDetails(
      {this.id,
        this.name,
        this.phone,
        this.gender,
        this.email,
        this.address,
        this.bloodGroup,
        this.socialLogin,
        this.socialId,
        this.image,
        this.contactVisiable,
        this.donorMode,
        this.zipCode,
        this.division,
        this.lastDonation});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
    email = json['email'];
    address = json['address'];
    bloodGroup = json['bloodGroup'];
    socialLogin = json['socialLogin'];
    socialId = json['socialId'];
    image = json['image'];
    contactVisiable = json['contactVisiable'];
    donorMode = json['donorMode'];
    zipCode = json['zipCode'];
    division = json['division'];
    lastDonation = json['lastDonation'];
  }

}
