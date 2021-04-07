import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:organize_flutter_project/src/business_logic/services/firebase_services/firebase_services.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';
import 'package:organize_flutter_project/src/views/ui/become_donor.dart';
import 'package:organize_flutter_project/src/views/ui/home.dart';
import 'package:organize_flutter_project/src/views/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/reusable_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_core/firebase_core.dart';

class VerifyMobileNumber extends StatefulWidget {
  @override
  _VerifyMobileNumberState createState() => _VerifyMobileNumberState();
}

class _VerifyMobileNumberState extends State<VerifyMobileNumber> {
  TextEditingController otpTextController = TextEditingController(text: '');
  TextEditingController _phoneNumberController;
  final focusNode = FocusNode();
  String phoneNo, smsCode, verificationId;
  PhoneAuthCredential _phoneAuthCredential;
  FirebaseApp defaultApp;
  bool inProgress = false;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
  }

  Future<void> _submitPhoneNumber() async {
    setState(() {
      inProgress = true;
    });
    String phoneNumber = "+8801" + _phoneNumberController.text.toString().trim();
    print(phoneNumber);

    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      this._phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
    }

    void verificationFailed(Exception error) {
      print(error);
    }

    void codeSent(String verificationId, [int code]) {
      setState(() {
        inProgress = false;
      });
      print('codeSent');
      otpTextController = TextEditingController(text: '');
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)), //this right here
              child: Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(margin: EdgeInsets.only(left: 16),
                          child: Text('Confirm verification code',
                              style: TextStyle(
                                  fontSize: 14, color: kBlackColor))),
                      SizedBox(height: 10),
                      _buildPinCodeView(
                          otpTextController, focusNode,
                          TextInputAction.done),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            child: Text('Re-send', style: TextStyle(
                                color: kPurpleColor, fontSize: 15)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _submitPhoneNumber();
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                                signIn();
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
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(minutes: 2),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
  
  signIn(){
    setState(() {
      inProgress = true;
    });
    FirebaseAuth.instance
        .signInWithCredential(_phoneAuthCredential)
        .then((value) async {
          UserData.userId = value.user.uid;
          final _result = await FirebaseServices.checkDocExist(value.user.uid);
          print(_result);
          if (_result) {
            UserData.userId = FirebaseAuth.instance.currentUser.uid;
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BecomeDonor()));
          }
    }).catchError((onError){
      setState(() {
        inProgress = false;
      });
      print(onError.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        leading: BackButton(
          color: kPurpleColor,
        ),
      ),
      backgroundColor: kWhiteColor,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Verify Number',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: kBlackColor))),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        '+8801',
                        style: TextStyle(
                            fontSize: 14,
                            color: kBlackColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: kGreyColor,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _phoneNumberController,
                      style: TextStyle(
                          fontSize: 14,
                          color: kBlackColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500),
                      maxLength: 9,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: kGreyColor,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide:
                          BorderSide.none,
                        ),
                        hintText: 'Enter your phone number',
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: RoundedGradientColorButton(
                onTap: () {
                  if (_phoneNumberController.text.trim().length == 9){
                    _submitPhoneNumber();
                  } else {
                    showErrorToast('Enter your valid phone number!');
                  }
                },
                text: 'GET OTP',
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPinCodeView(TextEditingController textEditingController,
      FocusNode focusNode, TextInputAction textInputAction) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: PinCodeTextField(
        length: 6,
        textInputType: TextInputType.number,
        obsecureText: false,
        animationType: AnimationType.none,
        validator: (v) {},
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.circle,
            fieldWidth: 30,
            borderWidth: 1,
            inactiveFillColor: Colors.transparent,
            inactiveColor: kBorderGreyColor,
            activeColor: Colors.black,
            activeFillColor: Colors.transparent,
            selectedColor: kPurpleColor,
            selectedFillColor: Colors.transparent),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),
        controller: textEditingController,
        autoDismissKeyboard: false,
        autoFocus: true,
        onCompleted: (v) {
          print("Completed");
          //otp = v;
          // _verifyOtp();
        },
        onChanged: (value) {
          print(value);
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          return true;
        },
      ),
    );
  }
}
