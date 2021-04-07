import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:organize_flutter_project/src/business_logic/models/request_model.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/reusable_widgets.dart';
import '../../business_logic/services/repository.dart';

class ResponseScreen extends StatefulWidget {
  ResponseScreen({this.request, this.userDetails, this.getAllRequest});
  final UserDetails userDetails;
  final Request request;
  final Function getAllRequest;
  @override
  _ResponseScreenState createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  bool inProgress = false;
  bool accepted = false;
  bool visible = true;

  responseToRequest(int id) async {
    setState(() {
      inProgress = false;
    });
    var _response = await repository.responseToRequest(id);
    if (_response.id == ResponseCode.SUCCESSFUL) {
      accepted = true;
      visible = false;
      setState(() {
        inProgress = false;
      });
      widget.getAllRequest();
      showSuccessToast('Thank you for responding! You are a hero.');
    } else {
      setState(() {
        inProgress = false;
      });
      showErrorToast(_response.object);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhiteColor,
        leading: BackButton(color: kPurpleColor),
        title: Text('Request accept' ,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: kBlackColor)),
      ),
      body: ModalProgressHUD(
        inAsyncCall: inProgress,
        color: Colors.black87,
        progressIndicator: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: kPurpleColor,
          ),
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(
            backgroundColor: kWhiteColor,
            valueColor: AlwaysStoppedAnimation<Color>(kBlackColor),
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: kGreyColor,
                      backgroundImage: widget.userDetails.image == null
                          ? widget.userDetails.gender == 'Male'
                          ? AssetImage('assets/images/user-boy.png')
                          : AssetImage('assets/images/user-girl.png')
                          : NetworkImage(IMG_BASE_URL + widget.userDetails.image),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${widget.userDetails.name}',
                            maxLines: 1,
                            style: TextStyle(fontSize: 14, color: kBlackColor),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text('Address Preference',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                Text('${widget.request.address}',
                    style: TextStyle(
                        fontSize: 14,
                        color: kBlackColor)),
                SizedBox(height: 20),
                Text('Division',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                Text('${widget.request.division}',
                    style: TextStyle(
                        fontSize: 14,
                        color: kBlackColor)),
                SizedBox(height: 20),
                Text('Blood for',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                Text('${widget.request.bloodFor}',
                    style: TextStyle(
                        fontSize: 14,
                        color: kBlackColor)),
                SizedBox(height: 20),
                Text('Amount',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                Text('${widget.request.units} units',
                    style: TextStyle(
                        fontSize: 14,
                        color: kBlackColor)),
                SizedBox(height: 20),
                Text('Blood group',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                Text('${widget.request.bloodGroup} units',
                    style: TextStyle(
                        fontSize: 14,
                        color: kBlackColor)),
                SizedBox(height: 20),
                Text('Type',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                Text('${widget.request.bloodType}',
                    style: TextStyle(
                        fontSize: 14,
                        color: kBlackColor)),
                SizedBox(height: 20),
                Text('Contact',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                accepted == false? Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color(0xFFFF3643),
                        const Color(0xFFFF4383),
                      ])),
                  child: Text(
                    'Response to see contact info',
                    style:
                    TextStyle(fontSize: 12, color: kWhiteColor),
                  ),
                ) :
                Text('${widget.request.contact}',
                    style: TextStyle(
                        fontSize: 14,
                        color: kBlackColor)),
                SizedBox(height: 40),
                Visibility(
                  visible: visible,
                  child: RoundedGradientColorButton(
                    text: 'RESPONSE',
                    onTap: () async{
                      await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(20.0)), //this right here
                          child: Container(
                            height: 180,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(margin: EdgeInsets.only(left: 16),
                                      child: Text('Response to request',
                                          style: TextStyle(
                                              fontSize: 14, color: kBlackColor))),
                                  SizedBox(height: 10),
                                  Container(margin: EdgeInsets.only(left: 16),
                                      child: Text('Are you sure that you want to help ?',
                                          style: TextStyle(
                                              fontSize: 12, color: kBlackColor))),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      FlatButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text('CANCEL', style: TextStyle(color: kBorderGreyColor)),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          responseToRequest(widget.request.id);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: kPurpleColor,
                                              gradient: LinearGradient(colors: [
                                                const Color(0xFFFF2156),
                                                const Color(0xFFFF4D4D),
                                              ]),
                                              borderRadius: BorderRadius.circular(
                                                  30)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontSize: 14
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
