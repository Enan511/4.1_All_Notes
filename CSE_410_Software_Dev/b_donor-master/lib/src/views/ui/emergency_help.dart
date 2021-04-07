import 'package:flutter/material.dart';
import 'package:organize_flutter_project/src/views/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/reusable_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhiteColor,
        leading: BackButton(color: kPurpleColor),
        title: Text('Emergency Help', style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: kBlackColor)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Text('National Emergency Service Bangladesh', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: kBlackColor)),
              SizedBox(height: 10),
              Text('999- National Emergency Service is an emergency call center which was initiated by ICT division of Bangladesh and later on handed over to the Bangladesh Police. Fundamentally, emergency police, fire and ambulance service is provided through this service to all the citizen of the country in time of need.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: kBlackColor)),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: kGreyColor,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child: Center(child: Text('999', style: TextStyle(fontWeight: FontWeight.bold, color: kBlackColor, fontSize: 16, letterSpacing: 1),))),
                    InkWell(
                      onTap: () async {
                        const url = "tel:999";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          showErrorToast('Could not launch $url');
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30),),
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFFF2156),
                                  const Color(0xFFFF4D4D),
                                ]
                            )
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.call, color: kWhiteColor, size: 20,),
                            SizedBox(width: 10),
                            Text('CALL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: kWhiteColor)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
