class UserProfileViewModel {
  int totalDonate;
  int loveState;
  int totalLove;
  int totalRequest;
  UserProfileData userData;
  List<Activities> activities;

  UserProfileViewModel(
      {this.totalDonate,
        this.loveState,
        this.totalLove,
        this.totalRequest,
        this.userData,
        this.activities});

  UserProfileViewModel.fromJson(Map<String, dynamic> json) {
    totalDonate = json['totalDonate'];
    loveState = json['loveState'];
    totalLove = json['totalLove'];
    totalRequest = json['totalRequest'];
    userData = json['userData'] != null
        ? new UserProfileData.fromJson(json['userData'])
        : null;
    if (json['activities'] != null) {
      activities = new List<Activities>();
      json['activities'].forEach((v) {
        activities.add(new Activities.fromJson(v));
      });
    }
  }

}

class UserProfileData {
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

  UserProfileData(
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

  UserProfileData.fromJson(Map<String, dynamic> json) {
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

class Activities {
  int reacts;
  int state;
  Activity activity;

  Activities({this.reacts, this.state, this.activity});

  Activities.fromJson(Map<String, dynamic> json) {
    reacts = json['reacts'];
    state = json['state'];
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reacts'] = this.reacts;
    data['state'] = this.state;
    if (this.activity != null) {
      data['activity'] = this.activity.toJson();
    }
    return data;
  }
}

class Activity {
  int id;
  String address;
  String image;
  String time;
  int userId;
  String description;

  Activity(
      {this.id,
        this.address,
        this.image,
        this.time,
        this.userId,
        this.description});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    image = json['image'];
    time = json['time'];
    userId = json['userId'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['image'] = this.image;
    data['time'] = this.time;
    data['userId'] = this.userId;
    data['description'] = this.description;
    return data;
  }
}
