import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:organize_flutter_project/src/business_logic/services/firebase_services/firebase_services.dart';
import 'package:organize_flutter_project/src/business_logic/services/repository.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/reusable_widgets.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class PostActivity extends StatefulWidget {
  PostActivity({@required this.getHomeData});

  final Function getHomeData;

  @override
  _PostActivityState createState() => _PostActivityState();
}

class _PostActivityState extends State<PostActivity> {
  TextEditingController _addressController, _descriptionController;
  File _imageFile;
  final picker = ImagePicker();
  bool inProgress = false;
  double _latitude, _longitude;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future getImage() async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
            title: Text('Upload Image'),
            content: Container(
              height: 130,
              margin: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.camera),
                      title: Text('Camera'),
                      onTap: () async {
                        Navigator.pop(context);
                        final pickedFile =
                            await picker.getImage(source: ImageSource.camera);
                        if (pickedFile != null) {
                          setState(() {
                            _imageFile = File(pickedFile.path);
                          });
                        }
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.photo),
                      title: Text('Gallery'),
                      onTap: () async {
                        Navigator.pop(context);
                        final pickedFile =
                            await picker.getImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          setState(() {
                            _imageFile = File(pickedFile.path);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            )));
  }

  // post new activity
  postNewActivity() async {
    setState(() {
      inProgress = true;
    });
    var _response = await repository.activityAdd(
        address: _addressController.text.trim(),
        description: _descriptionController.text.trim(),
        image: _imageFile);
    if (_response.id == ResponseCode.SUCCESSFUL) {
      _descriptionController.text = '';
      _addressController.text = '';
      _imageFile = null;
      widget.getHomeData();
      setState(() {
        inProgress = false;
      });
      showSuccessToast('Your activity has been post!');
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
        title: Text('Post New Activity',
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
                Text('Select Image',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: kGreyColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        _imageFile == null
                            ? 'No image selected'
                            : _imageFile.path.split('/').last,
                        maxLines: 1,
                      )),
                      InkWell(
                        onTap: () {
                          getImage();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              gradient: LinearGradient(colors: [
                                const Color(0xFFFF2156),
                                const Color(0xFFFF4D4D),
                              ])),
                          child: Text('SELECT',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: kWhiteColor)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Text('Activity Description',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor)),
                SizedBox(height: 10),
                Container(
                  height: 300,
                  child: TextField(
                    controller: _descriptionController,
                    selectionHeightStyle: BoxHeightStyle.max,
                    maxLines: 10000,
                    style: TextStyle(color: kBlackColor),
                    decoration: InputDecoration(
                      fillColor: kGreyColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      hintText: 'Write your description here',
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(color: Colors.black54),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                RoundedGradientColorButton(
                  text: 'SUBMIT',
                  onTap: () async {
                    if (_addressController.text.trim().isNotEmpty) {
                      if (_descriptionController.text.trim().isNotEmpty) {
                        if (mounted) {
                          setState(() {
                            inProgress = true;
                          });
                        }
                        final _result =
                        await FirebaseServices.postNewActivity(
                            _addressController.text.trim(),
                            UserData.userId,
                            _descriptionController.text.trim(),
                            _imageFile
                        );
                        if (_result) {
                          _descriptionController.text = '';
                          _addressController.text = '';
                          _imageFile = null;
                          if (mounted) {
                            setState(() {
                              inProgress = false;
                            });
                          }
                          showSuccessToast('Post added!');
                        } else {
                          if (mounted) {
                            setState(() {
                              inProgress = false;
                            });
                          }
                          showErrorToast('New post failed! Try again.');
                        }
                      } else {
                        showErrorToast('Enter your activity description!');
                      }
                    } else {
                      showErrorToast('Enter your activity address!');
                    }
                  },
                )
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
    GoogleMapsPlaces _places =
        new GoogleMapsPlaces(apiKey: GOOGLE_MAP_KEY); //Same API_KEY as above
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
