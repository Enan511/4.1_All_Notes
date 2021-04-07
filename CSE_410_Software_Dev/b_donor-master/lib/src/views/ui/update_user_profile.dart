import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:organize_flutter_project/src/business_logic/models/profile_model.dart';
import 'package:organize_flutter_project/src/business_logic/services/repository.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/reusable_widgets.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({this.userAllData, this.getProfileData});
  final UserAllData userAllData;
  final Function getProfileData;
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool isGenderMale = true, isVisible = false, inProgress = false;
  String _donorBloodGroup = 'A+', _division = 'Dhaka';
  TextEditingController _nameController, _emailController, _addressController, _zipController;

  @override
  void initState() {
    super.initState();
      _emailController = TextEditingController(text: widget.userAllData.email);
    _nameController = TextEditingController(text: widget.userAllData.name);
    _addressController = TextEditingController(text: widget.userAllData.address);
    _zipController = TextEditingController(text: widget.userAllData.zipCode);
    _donorBloodGroup = widget.userAllData.bloodGroup;
    _division = widget.userAllData.division;
    this.isGenderMale = widget.userAllData.gender == 'Male';
    this.isVisible = widget.userAllData.contactVisiable == 1;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          title: Text('Update Profile',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlackColor)),
          backgroundColor: kWhiteColor,
          leading: BackButton(
            color: kPurpleColor,
          ),
          elevation: 0,
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
                  SizedBox(height: 10),
                  RoundedTextField(
                    hint: 'Name',
                    controller: _nameController,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _addressController,
                    style: TextStyle(
                        fontSize: 14,
                        color: kBlackColor,
                        letterSpacing: 0.3,
                        fontWeight: FontWeight.w400),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      fillColor: kGreyColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        borderSide:
                        BorderSide.none,
                      ),
                      hintText: 'Address',
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        borderSide:
                        BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: kGreyColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal : 16.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _division,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              underline: SizedBox(),
                              style: TextStyle(color: kBlackColor, fontSize: 14, fontFamily: 'Montserrat'),
                              onChanged: (String newValue) {
                                setState(() {
                                  _division = newValue;
                                });
                              },
                              items: <String>['Dhaka', 'Barisal', 'Chittagong', 'Khulna', 'Mymensingh', 'Rajshahi', 'Rangpur', 'Sylhet']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: RoundedTextField(
                          hint: 'ZIP',
                          textInputType: TextInputType.number,
                          controller: _zipController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Gender',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            isGenderMale = true;
                          });
                        },
                        child: isGenderMale
                            ? Image.asset('assets/images/male-selected.png',
                                fit: BoxFit.scaleDown, width: 48, height: 69)
                            : Image.asset('assets/images/male-normal.png'),
                      ),
                      SizedBox(width: 15),
                      Container(
                        width: 2,
                        height: 38,
                        color: kBorderGreyColor,
                      ),
                      SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isGenderMale = false;
                          });
                        },
                        child: !isGenderMale
                            ? Image.asset('assets/images/famale-selected.png',
                                fit: BoxFit.scaleDown, width: 48, height: 69)
                            : Image.asset('assets/images/female-normal.png'),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Select Blood Group',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: kGreyColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal : 16.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _donorBloodGroup,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        underline: SizedBox(),
                        style: TextStyle(color: kBlackColor, fontSize: 14, fontFamily: 'Montserrat'),
                        onChanged: (String newValue) {
                          setState(() {
                            _donorBloodGroup = newValue;
                          });
                        },
                        items: <String>['A+', 'A-', 'B-', 'B+', 'O+', 'O-', 'AB-', 'AB+']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Checkbox(
                        value: isVisible,
                        checkColor: kWhiteColor,
                        activeColor: kBlackColor,
                        onChanged: (val) {
                          setState(() {
                            isVisible = val;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Do you want to make your contact number visible for other',
                          style: TextStyle(color: kBlackColor, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  RoundedGradientColorButton(
                    text: 'UPDATE',
                    onTap: () {
                      if (_nameController.text.trim().isNotEmpty){
                          if (_addressController.text.trim().isNotEmpty){
                            if (_zipController.text.trim().isNotEmpty){
                              UpdateUserData.name = _nameController.text.trim();
                              UpdateUserData.address = _addressController.text.trim();
                              UpdateUserData.zipCode = _zipController.text.trim();
                              UpdateUserData.division = _division;
                              UpdateUserData.gender = isGenderMale ? 'Male' : 'Female';
                              UpdateUserData.bloodGroup = _donorBloodGroup;
                              UpdateUserData.contactVisible = isVisible ? 1.toString() : 0.toString();
                              updateUser();
                            } else {
                              showErrorToast('Enter zip code!');
                            }
                          } else {
                            showErrorToast('Enter your address!');
                          }
                      } else {
                        showErrorToast('Enter your full name!');
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void updateUser() async{
    setState(() {
      inProgress = true;
    });
    var _response = await repository.updateProfileData();
    if (_response.id == ResponseCode.SUCCESSFUL) {
      widget.getProfileData();
      Navigator.pop(context);
    } else {
      setState(() {
        inProgress = false;
      });
      showErrorToast(_response.object);
    }
  }
}

