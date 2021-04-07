class DonorModel {
  bool error;
  List<Donor> donors;

  DonorModel({this.error, this.donors});

  DonorModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['donors'] != null) {
      donors = new List<Donor>();
      json['donors'].forEach((v) {
        donors.add(new Donor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.donors != null) {
      data['donors'] = this.donors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Donor {
  int id;
  String name;
  String phone;
  String gender;
  String email;
  String address;
  String bloodGroup;
  int socialLogin;
  String socialId;
  String image;
  int contactVisiable;
  int donorMode;
  String zipCode;
  String division;
  String lastDonation;

  Donor(
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

  Donor.fromJson(Map<String, dynamic> json) {
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
    data['lastDonation'] = this.lastDonation;
    return data;
  }
}
