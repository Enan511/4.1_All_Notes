class HomeModel {
  int donorMode;
  int totalRequest;
  int totalDonor;
  int totalNotifications;
  List<RecentActivities> recentActivities;

  HomeModel(
      {this.donorMode,
        this.totalRequest,
        this.totalDonor,
        this.totalNotifications,
        this.recentActivities});

  HomeModel.fromJson(Map<String, dynamic> json) {
    donorMode = json['donorMode'];
    totalRequest = json['totalRequest'];
    totalDonor = json['totalDonor'];
    totalNotifications = json['totalNotifications'];
    if (json['recentActivities'] != null) {
      recentActivities = new List<RecentActivities>();
      json['recentActivities'].forEach((v) {
        recentActivities.add(new RecentActivities.fromJson(v));
      });
    }
  }
}

class RecentActivities {
  Activity activity;
  User user;
  int reacts;
  int state;

  RecentActivities({this.activity, this.user, this.reacts, this.state});

  RecentActivities.fromJson(Map<String, dynamic> json) {
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    reacts = json['reacts'];
    state = json['state'];
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
  String socialId;
  String image;
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
}
