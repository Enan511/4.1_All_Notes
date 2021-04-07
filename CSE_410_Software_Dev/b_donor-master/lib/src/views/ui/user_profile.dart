import 'package:flutter/material.dart';
import 'package:organize_flutter_project/src/business_logic/models/user_profile_view_model.dart';
import 'package:organize_flutter_project/src/business_logic/services/repository.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/reusable_widgets.dart';

class UserProfile extends StatefulWidget {
  UserProfile({this.id});
  final int id;
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserProfileViewModel _profileModel;
  bool inProgress = false;
  List<Column> cards = List();

  // react to a activity
  reactToActivity(int id) async {
    setState(() {
      inProgress = true;
    });
    var _response = await repository.reactToActivity(id);
    if (_response.id == ResponseCode.SUCCESSFUL) {
      getAnotherProfileData();
    } else {
      setState(() {
        inProgress = false;
      });
      showErrorToast(_response.object);
    }
  }

  getAnotherProfileData() async {
    setState(() {
      inProgress = true;
    });
    final _response = await repository.getAnotherProfile(widget.id);
    if (_response.id == ResponseCode.SUCCESSFUL) {
      cards.clear();
      _profileModel = _response.object;
      for (int i=0; i<_profileModel.activities.length; i++){
        cards.add(Column(
          children: <Widget>[
            ActivityCard(
              userId: _profileModel.userData.id,
              id: _profileModel.activities[i].activity.id,
              reactionFunction: reactToActivity,
              gender: _profileModel.userData.gender,
              userImage: _profileModel.userData.image,
              userName: _profileModel.userData.name,
              descriptions: _profileModel.activities[i].activity.description,
              image: _profileModel.activities[i].activity.image,
              location: _profileModel.activities[i].activity.address,
              reacts: _profileModel.activities[i].reacts,
              time: _profileModel.activities[i].activity.time,
              state:  _profileModel.activities[i].state,
            ),
            SizedBox(height: 5),
          ],
        ));
      }
      setState(() {
        inProgress = false;
      });
    } else {
      setState(() {
        inProgress = false;
      });
      showErrorToast(_response.object);
    }
  }

  @override
  void initState() {
    super.initState();
    getAnotherProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBgColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        leading: BackButton(color: kSoftBlueColor),
        title: Text(_profileModel == null ? 'username' : _profileModel.userData.name, style: TextStyle(fontSize: 14, color: kBlackColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: kWhiteColor,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border:Border.all(width: 4, color: kShadowBlueColor)
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: kSoftBlueColor,
                      backgroundImage: _profileModel == null
                          ? AssetImage('assets/images/user-boy.png')
                          : _profileModel.userData.image == null
                          ? _profileModel.userData.gender == 'Male'
                          ? AssetImage('assets/images/user-boy.png')
                          : AssetImage('assets/images/user-girl.png')
                          : NetworkImage(IMG_BASE_URL +
                          _profileModel.userData.image),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: MediaQuery.of(context).size.width - 170,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text( _profileModel == null
                    ? '0'
                        : _profileModel.totalDonate
                        .toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: kPurpleColor)),
                                SizedBox(height: 5),
                                Text('Donated', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: kBlackColor)),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(_profileModel == null
                            ? '0'
                                : _profileModel.totalRequest
                                .toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: kPurpleColor)),
                                SizedBox(height: 5),
                                Text('Requests', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: kBlackColor)),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Icon(Icons.favorite_border, size: 25, color: kPurpleColor),
                                SizedBox(height: 5),
                                Text(_profileModel == null
                                    ? '0'
                                    : _profileModel.totalLove.toString(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: kBlackColor)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFFFF2156),
                                        const Color(0xFFFF4D4D),
                                      ]
                                  )
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.star, color: kWhiteColor, size: 20),
                                  SizedBox(width: 5),
                                  Text( _profileModel == null
                                      ? 'DONOR'
                                      : _profileModel.totalDonate >= 3
                                      ? 'HERO DONOR'
                                      : 'DONOR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: kWhiteColor)),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: kBorderGreyColor, width: 2)
                              ),
                              child: Row(
                                children: <Widget>[
                                  Text('CONTACT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: kPurpleColor)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: kWhiteColor,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: kBorderGreyColor, size: 20),
                      SizedBox(width: 10),
                      Text(_profileModel == null
                          ? 'Dhaka, Bangladesh'
                          : _profileModel.userData.address +
                          ', ' +
                          _profileModel.userData.division +
                          ', ' +
                          _profileModel.userData.zipCode, style: TextStyle(fontSize: 12, color: kBlackColor, fontWeight: FontWeight.w500))
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              color: kWhiteColor,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('RECENT ACTIVITY', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: kBlackColor)),
                ],
              ),
            ),
            SizedBox(height: 5),
            _profileModel == null ? Container() : Column(
              children: cards,
            )
          ],
        ),
      ),
    );
  }
}
