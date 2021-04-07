import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:organize_flutter_project/src/business_logic/models/donor_model.dart';
import 'package:organize_flutter_project/src/business_logic/models/request_model.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';
import 'package:organize_flutter_project/src/views/ui/profile.dart';
import 'package:organize_flutter_project/src/views/ui/user_profile.dart';

import 'contants.dart';

class RoundedRaisedButton extends StatelessWidget {
  RoundedRaisedButton({@required this.text,
    @required this.textColor,
    @required this.imageLink,
    @required this.onTap,
    @required this.backgroundColor});

  final Function onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 190,
        child: RaisedButton(
          elevation: 4,
          color: backgroundColor,
          onPressed: onTap,
          child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }
}

class RoundedBorderedRaisedButton extends StatelessWidget {
  RoundedBorderedRaisedButton({@required this.text,
    @required this.textColor,
    @required this.imageLink,
    @required this.onTap,
    @required this.backgroundColor});

  final Function onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: kBorderGreyColor, width: 1)),
        color: backgroundColor,
        onPressed: onTap,
        child: imageLink == null
            ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: FontWeight.bold),
            ))
            : Row(
          children: <Widget>[
            Image.asset(imageLink,
                fit: BoxFit.scaleDown, width: 22, height: 22),
            Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class RoundedBorderedRaisedButtonSmall extends StatelessWidget {
  RoundedBorderedRaisedButtonSmall({@required this.text,
    @required this.textColor,
    @required this.imageLink,
    @required this.onTap,
    @required this.backgroundColor});

  final Function onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: kBorderGreyColor, width: 1)),
        color: backgroundColor,
        onPressed: onTap,
        child: imageLink == null
            ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: FontWeight.bold),
            ))
            : Row(
          children: <Widget>[
            Image.asset(imageLink,
                fit: BoxFit.scaleDown, width: 22, height: 22),
            Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class RoundedGradientColorButton extends StatelessWidget {
  RoundedGradientColorButton({@required this.text, @required this.onTap});

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: kPurpleColor,
            gradient: LinearGradient(colors: [
              const Color(0xFFFF2156),
              const Color(0xFFFF4D4D),
            ]),
            borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '$text',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kWhiteColor,
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedTextField extends StatelessWidget {
  RoundedTextField({@required this.hint,
    @required this.controller,
    @required this.textInputType});

  final String hint;
  final TextEditingController controller;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
          fontSize: 14,
          color: kBlackColor,
          letterSpacing: 0.3,
          fontWeight: FontWeight.w400),
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        fillColor: kGreyColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide.none,
        ),
        hintText: '$hint',
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

showErrorToast(String message) {
  BotToast.showText(
      text: message,
      borderRadius: BorderRadius.circular(30),
      contentColor: kDarkPurpleColor,
      duration: Duration(seconds: 3),
      textStyle: TextStyle(color: kWhiteColor));
}

showSuccessToast(String message) {
  BotToast.showText(
      text: message,
      borderRadius: BorderRadius.circular(30),
      contentColor: Colors.green,
      duration: Duration(seconds: 3),
      textStyle: TextStyle(color: kWhiteColor));
}

class ActivityCard extends StatelessWidget {
  ActivityCard({
    @required this.userName,
    @required this.userId,
    @required this.id,
    @required this.reactionFunction,
    @required this.gender,
    @required this.userImage,
    @required this.location,
    @required this.image,
    @required this.descriptions,
    @required this.time,
    @required this.reacts,
    @required this.state,
  });

  final String userName, gender, userImage, location, image, descriptions, time;
  final int reacts, id, userId, state;
  final Function reactionFunction;
  bool changeIcon = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhiteColor,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    if (userId == UserData.userId) {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Profile()
                      ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserProfile(id: userId)));
                    }
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: kPurpleColor,
                    backgroundImage: userImage == null
                        ? gender == 'Male' ? AssetImage(
                        'assets/images/user-boy.png')
                        : AssetImage('assets/images/user-img.jpg') : NetworkImage(
                        IMG_BASE_URL + userImage),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: Text('$userName',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      onTap: () {
                        if (userId == UserData.userId) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Profile()
                          ));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserProfile(id: userId)));
                        }
                      },
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: kBorderGreyColor,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text('${time.split(' ')[1]}    ${time.split(' ')[0]}',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: kBorderGreyColor)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                        Icons.location_on,
                        color: kBorderGreyColor,
                        size: 16,
                      ),
                        SizedBox(width: 5),
                        Container(
                          width: 250,
                          child: Text('$location',
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: kBorderGreyColor)),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          image == null
              ? Container()
              : Image.network(IMG_BASE_URL+image,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 290,
              fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text(
                  '$descriptions',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: kTextGreyColor, fontSize: 12),
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        if (state == 0 && changeIcon == false) {
                          reactionFunction(id);
                          changeIcon = true;
                        }
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: changeIcon == false ? state == 1 ? Icon(Icons
                              .favorite, color: Colors.red, size: 20) : Icon(
                              Icons.favorite_border, size: 20) : Icon(Icons
                              .favorite, color: Colors.red, size: 20),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 1, color: kGreyColor)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '$reacts',
                      style: TextStyle(
                          color: kBorderGreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.share, size: 20),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 1, color: kGreyColor)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    @required this.message,
    @required this.id,
    @required this.name,
    @required this.time,
    @required this.image,
    @required this.ignoreFunction,
    @required this.gender,
    @required this.responseFunction,
  });

  final String image, time, message, name, gender;
  final int id;
  final Function ignoreFunction, responseFunction;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        color: kWhiteColor,
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                          radius: 30,
                          backgroundImage: image == null ? gender == 'Male' ?
                          AssetImage('assets/images/user-boy.png') : AssetImage(
                              'assets/images/user-girl.png') :
                          NetworkImage(IMG_BASE_URL + image)
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '$name',
                            style: TextStyle(fontSize: 14, color: kBlackColor),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Icon(Icons.access_time,
                                  size: 18, color: kBorderGreyColor),
                              SizedBox(width: 10),
                              Text(
                                '${time.split(' ')[1]}    ${time.split(
                                    ' ')[0]}',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: kBlackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$message',
                            style: TextStyle(fontSize: 10, color: kBlackColor),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                  ButtonBar(
                    buttonPadding: EdgeInsets.all(0),
                    children: <Widget>[
                      FlatButton(
                        child: Text('Ignore'),
                        onPressed: () {
                          ignoreFunction(id, 2);
                        },
                        textColor: kBorderGreyColor,
                        padding: EdgeInsets.all(8),
                      ),
                      SizedBox(width: 10),
                      FlatButton(
                        child: Text('Response'),
                        onPressed: () {
                          responseFunction(id, 1);
                        },
                        textColor: kDarkPurpleColor,
                        padding: EdgeInsets.all(8),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 5),
    ]);
  }
}

class DonorCard extends StatelessWidget {
  const DonorCard({
    @required this.donor,
    @required this.requestToDonor,
  });

  final Donor donor;
  final Function requestToDonor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 5),
        Container(
          color: kWhiteColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: kGreyColor,
                      radius: 50,
                      backgroundImage: donor.image == null ? donor.gender == 'Male' ?  AssetImage(
                          'assets/images/user-boy.png') : AssetImage(
                          'assets/images/user-girl.png') : NetworkImage(IMG_BASE_URL+ donor.image),
                    ),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${donor.name}',
                          style: TextStyle(
                              fontSize: 14, color: kBlackColor),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on,
                                size: 18,
                                color: kBorderGreyColor),
                            SizedBox(width: 10),
                            Text(
                              '${donor.address}, ${donor.division}, ${donor.zipCode}',
                              maxLines: 4,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: kBlackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RoundedBorderedRaisedButton(
                          backgroundColor: kWhiteColor,
                          onTap: () {
                            requestToDonor(donor.id);
                          },
                          imageLink: null,
                          textColor: kPurpleColor,
                          text: 'Ask For Help',
                        )
                      ],
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${donor.bloodGroup}',
                          style: TextStyle(
                              color: kPurpleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              width: 1, color: kBorderGreyColor)),
                    ),
                  ],
                ),
              ),
              donor.lastDonation == null ? Container() : Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                    vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xFFFF3643),
                      const Color(0xFFFF4383),
                    ])),
                child: Text(
                  'Last date of donation ${donor.lastDonation}',
                  style:
                  TextStyle(fontSize: 12, color: kWhiteColor),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class RequestCard extends StatelessWidget {
  const RequestCard({
    @required this.id,
    @required this.user,
    @required this.bloodType,
    @required this.bloodGroup,
    @required this.location,
    @required this.responseFunction,
  });

  final UserDetails user;
  final String bloodType, bloodGroup, location;
  final int id;
  final Function responseFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: kWhiteColor,
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: kGreyColor,
                      backgroundImage: user.image == null
                          ? user.gender == 'Male'
                          ? AssetImage('assets/images/user-boy.png')
                          : AssetImage('assets/images/user-girl.png')
                          : NetworkImage(IMG_BASE_URL + user.image),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${user.name}',
                            maxLines: 1,
                            style: TextStyle(fontSize: 13, color: kBlackColor),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Icon(Icons.location_on,
                                  size: 18, color: kBorderGreyColor),
                              SizedBox(width: 10),
                              Text(
                                '$location',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: kBlackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RoundedBorderedRaisedButtonSmall(
                            backgroundColor: kWhiteColor,
                            onTap: responseFunction,
                            imageLink: null,
                            textColor: kPurpleColor,
                            text: user.id == UserData.userId ? 'Cancel' : 'Response',
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: 8, right: 4, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              gradient: LinearGradient(colors: [
                                const Color(0xFFFF215D),
                                const Color(0xFFFF4D4D),
                              ])),
                          child: Text(
                            'Requested',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '$bloodGroup',
                              style: TextStyle(
                                  color: kPurpleColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  width: 1, color: kBorderGreyColor)),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.only(
                              left: 8, right: 4, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              gradient: LinearGradient(colors: [
                                const Color(0xFFFF215D),
                                const Color(0xFFFF4D4D),
                              ])),
                          child: Text(
                            '$bloodType',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}