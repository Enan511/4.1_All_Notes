import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:group_button/group_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:organize_flutter_project/src/business_logic/services/repository.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/reusable_widgets.dart';
import 'package:google_maps_webservice/places.dart';

class AddNewRequest extends StatefulWidget {
  AddNewRequest(this.getAllRequest);
  final Function getAllRequest;
  @override
  _AddNewRequestState createState() => _AddNewRequestState();
}

class _AddNewRequestState extends State<AddNewRequest> {
  String _donorBloodGroup = 'A+';
  String _division = 'Dhaka';
  String _bloodType = 'Blood';
  final bloodGroups = ["A+", "A-", "B-", "B+", "O+", "O-", "AB-", "AB+"];
  bool inProgress = false;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _addressController, _bloodForController,
      _amountController, _contactNumberController;
  double _latitude, _longitude;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _bloodForController = TextEditingController();
    _amountController = TextEditingController();
    _contactNumberController =
        TextEditingController(text: UserData.phone.split('01')[1]);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _bloodForController.dispose();
    _amountController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  // insert a new request
  addNewRequest() async {
    setState(() {
      inProgress = true;
    });
    var _response = await repository.createNewRequest(
        _addressController.text.trim(),
        _bloodForController.text.trim(),
        _bloodType,
        int.parse(_amountController.text.trim()),
        _donorBloodGroup,
        '+8801' + _contactNumberController.text.trim(),
        _division
    );
    if (_response.id == ResponseCode.SUCCESSFUL) {
      widget.getAllRequest();
      _addressController.text = '';
      _contactNumberController.text = '';
      _amountController.text = '';
      _bloodForController.text = '';
      setState(() {
        inProgress = false;
      });
      showSuccessToast(_response.object);
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
        title: Text('Request for Blood',
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
                Text('Address Preference',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                TextField(
                  onTap: _handlePressButton,
                  controller: _addressController,
                  style: TextStyle(
                      fontSize: 14,
                      color: kBlackColor,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w500),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: kGreyColor,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Address',
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text('Division',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: kGreyColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _division,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      underline: SizedBox(),
                      style: TextStyle(
                          color: kBlackColor,
                          fontSize: 14,
                          fontFamily: 'Montserrat'),
                      onChanged: (String newValue) {
                        setState(() {
                          _division = newValue;
                        });
                      },
                      items: <String>[
                        'Dhaka',
                        'Barisal',
                        'Chittagong',
                        'Khulna',
                        'Mymensingh',
                        'Rajshahi',
                        'Rangpur',
                        'Sylhet'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text('Blood for',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                RoundedTextField(
                  controller: _bloodForController,
                  hint: 'Father, mother or friend',
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 30),
                Text('Amount',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RoundedTextField(
                        controller: _amountController,
                        hint: 'Max 10 units',
                        textInputType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: kGreyColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _bloodType,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            underline: SizedBox(),
                            style: TextStyle(
                                color: kBlackColor,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                            onChanged: (String newValue) {
                              setState(() {
                                _bloodType = newValue;
                              });
                            },
                            items: <String>['Blood', 'Plasma', 'Platelet']
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
                  ],
                ),
                SizedBox(height: 30),
                Text('Contact',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                Row(
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
                        controller: _contactNumberController,
                        style: TextStyle(
                            fontSize: 14,
                            color: kBlackColor,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                        maxLength: 9,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: kGreyColor,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            borderSide: BorderSide.none,
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
                SizedBox(height: 20),
                Text('Select Blood Group',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
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
                SizedBox(height: 40),
                RoundedGradientColorButton(
                  text: 'SUBMIT',
                  onTap: () {
                    if (_addressController.text.trim().isNotEmpty){
                      if (_bloodForController.text.trim().isNotEmpty){
                        if (_amountController.text.trim().isNotEmpty && int.parse(_amountController.text.trim()) < 11){
                          if (_contactNumberController.text.trim().length >= 9){
                              addNewRequest();
                          } else {
                            showErrorToast('Enter your valid phone!');
                          }
                        } else {
                          showErrorToast('Enter your amount less than 10!');
                        }
                      } else {
                        showErrorToast('Enter your blood for field!');
                      }
                    } else {
                      showErrorToast('Enter your address!');
                    }
                  },
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
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
