class EmailModel {
  bool error;
  String message;
  List<User> user;

  EmailModel({this.error, this.message, this.user});

  EmailModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['user'] != null) {
      user = new List<User>();
      json['user'].forEach((v) {
        user.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
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

  User(
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
        this.division});

  User.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['address'] = this.address;
    data['bloodGroup'] = this.bloodGroup;
    data['socialLogin'] = this.socialLogin;
    data['socialId'] = this.socialId;
    data['image'] = this.image;
    data['contactVisiable'] = this.contactVisiable;
    data['donorMode'] = this.donorMode;
    data['zipCode'] = this.zipCode;
    data['division'] = this.division;
    return data;
  }
}
