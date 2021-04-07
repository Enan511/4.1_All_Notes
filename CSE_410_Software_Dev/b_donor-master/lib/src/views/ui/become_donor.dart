import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:organize_flutter_project/src/business_logic/services/firebase_services/firebase_services.dart';
import 'package:organize_flutter_project/src/business_logic/services/repository.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';
import 'package:organize_flutter_project/src/views/ui/home.dart';
import 'package:organize_flutter_project/src/views/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/reusable_widgets.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';


class BecomeDonor extends StatefulWidget {
  @override
  _BecomeDonorState createState() => _BecomeDonorState();
}

class _BecomeDonorState extends State<BecomeDonor> {
  bool isGenderMale = true, isVisible = false, inProgress = false;
  String _donorBloodGroup = 'A+', _division = 'Dhaka';
  final bloodGroups = ["A+", "A-", "B-", "B+", "O+", "O-", "AB-", "AB+"];
  TextEditingController _nameController, _emailController, _addressController, _zipController;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  double _latitude, _longitude;

  @override
  void initState() {
    super.initState();
    if (RegisterUserData.email != null){
      _emailController = TextEditingController(text: RegisterUserData.email);
    } else {
      _emailController = TextEditingController();
    }
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _zipController = TextEditingController();
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
          title: Text('Become Donor',
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
                  // RoundedTextField(
                  //   hint: 'E-Mail',
                  //   controller: _emailController,
                  //   textInputType: TextInputType.emailAddress,
                  // ),
                  TextField(
                    controller: _addressController,
                    onTap: _handlePressButton,
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
                  GroupButton(
                    spacing: 5,
                    isRadio: true,
                    direction: Axis.horizontal,
                    onSelected: (index, isSelected) =>
                        _donorBloodGroup = bloodGroups[index],
                    buttons: bloodGroups,
                    selectedTextStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    unselectedTextStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    selectedColor: kPurpleColor,
                    unselectedColor: kWhiteColor,
                    selectedBorderColor: kPurpleColor,
                    unselectedBorderColor: Colors.grey[300],
                    borderRadius: BorderRadius.circular(0),
                    selectedShadow: <BoxShadow>[
                      BoxShadow(color: Colors.transparent)
                    ],
                    unselectedShadow: <BoxShadow>[
                      BoxShadow(color: Colors.transparent)
                    ],
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
                    text: 'DONE',
                    onTap: () async {
                      if (_nameController.text.trim().isNotEmpty){
                          if (_addressController.text.trim().isNotEmpty){
                            if (_zipController.text.trim().isNotEmpty){
                              if (mounted) {
                                setState(() {
                                  inProgress = true;
                                });
                              }
                              final _result =
                                  await FirebaseServices.registerNewUserData(
                                      _nameController.text.trim(),
                                      _zipController.text.trim(),
                                      _addressController.text,
                                      UserData.userId.toString(),
                                      _donorBloodGroup,
                                      _division,
                                      isGenderMale ? 'male' : 'female',
                                      isVisible
                                  );
                              if (mounted) {
                                setState(() {
                                  inProgress = false;
                                });
                              }
                              if (_result) {
                                UserData.userId = FirebaseAuth.instance.currentUser.uid;
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (route) => false);
                              }
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

  // register new user data
  void registerUser() async{
    var _response = await repository.register();
    if (_response.id == ResponseCode.SUCCESSFUL) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Home()), (route) => false);
    } else {
      setState(() {
        inProgress = false;
      });
      showErrorToast(_response.object);
    }
  }

  // check email is exists or not
  checkEmailExists() async{
    setState(() {
      inProgress = true;
    });
    var _response = await repository.checkEmailExists(RegisterUserData.email, EmailExistCheck.ExistsCheck);
    if (_response.id == ResponseCode.SUCCESSFUL) {
      if (_response.object == 'not exists'){
        registerUser();
      } else {
        setState(() {
          inProgress = false;
        });
        showErrorToast('Email already registered!');
      }
    } else {
      setState(() {
        inProgress = false;
      });
      showErrorToast(_response.object);
    }
  }

  // get places data
  Future<void> _handlePressButton() async {

    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: GOOGLE_MAP_KEY,
      onError: (value) => print(value.errorMessage),
      mode: Mode.overlay,
      language: "en",
      components: [Component(Component.country, "bd")],
    );
    _addressController.text = p.description;
    _getLatLng(p);
  }

  // get lat long of the selected address from google place api
  void _getLatLng(Prediction prediction) async {
    GoogleMapsPlaces _places = new
    GoogleMapsPlaces(apiKey: GOOGLE_MAP_KEY);  //Same API_KEY as above
    PlacesDetailsResponse detail =
    await _places.getDetailsByPlaceId(prediction.placeId);
    _latitude = detail.result.geometry.location.lat;
    _longitude = detail.result.geometry.location.lng;
    String address = prediction.description;
    print(_latitude);
    print(_longitude);
    print(address);
  }

}

