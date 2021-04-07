import 'package:flutter/material.dart';
import 'package:organize_flutter_project/src/views/utils/contants.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhiteColor,
        leading: BackButton(color: kPurpleColor),
        title: Text('About',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: kBlackColor)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                  'People will be connecting with each other to find or donate blood for saving life. An app to remove all blood donating/receiving crisis including features of getting user updates, health suggestions, which will create an environment of the best blood donating social platform at any emergency.',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: kBlackColor)),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Text('Contributors',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: kBlackColor)),
              SizedBox(height: 20),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: kGreyColor,
                  backgroundImage: AssetImage('assets/images/3.jpg'),
                ),
                title: Text('Mehedi Ul Hasnain Antor'),
                subtitle: Text('Email : muh.antor@gmail.com'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: kGreyColor,
                  backgroundImage: AssetImage('assets/images/2.jpg'),
                ),
                title: Text('Rashik Rahman'),
                subtitle: Text('Email : 17201012@uap-bd.edu'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: kGreyColor,
                  backgroundImage: AssetImage('assets/images/1.jpg'),
                ),
                title: Text('Md Rafat Jamader Maraz'),
                subtitle: Text('Email : razhossain201@gmail.com'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
