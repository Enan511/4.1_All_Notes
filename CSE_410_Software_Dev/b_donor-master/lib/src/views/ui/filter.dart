import 'package:flutter/material.dart';
import 'package:organize_flutter_project/src/business_logic/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/contants.dart';
import 'package:organize_flutter_project/src/views/utils/reusable_widgets.dart';

enum FilterType {
  AllDonor,
  AllRequest
}

class Filter extends StatefulWidget {
  Filter({this.filterType, this.callBack});
  final FilterType filterType;
  final Function callBack;
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String _donorBloodGroup = 'All', _division = 'All';

  @override
  void initState() {
    if (widget.filterType == FilterType.AllDonor){
      if (AllDonorFilter.bloodGroup != null){
        _donorBloodGroup = AllDonorFilter.bloodGroup;
      }
      if (AllDonorFilter.division != null){
        _division = AllDonorFilter.division;
      }
    }
    if (widget.filterType == FilterType.AllRequest){
      if (AllRequestFilter.bloodGroup != null){
        _donorBloodGroup = AllRequestFilter.bloodGroup;
      }
      if (AllRequestFilter.division != null){
        _division = AllRequestFilter.division;
      }
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        leading: BackButton(color: kPurpleColor),
        title: Text('Filter', style: TextStyle(color: kBlackColor, fontSize: 18)),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                  items: <String>['All', 'A+', 'A-', 'B-', 'B+', 'O+', 'O-', 'AB-', 'AB+']
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
            Text('Division',
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
                  items: <String>['All', 'Dhaka', 'Barisal', 'Chittagong', 'Khulna', 'Mymensingh', 'Rajshahi', 'Rangpur', 'Sylhet']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            RoundedGradientColorButton(
              onTap: (){
                if (widget.filterType == FilterType.AllDonor){
                  if (_donorBloodGroup != 'All') {
                    AllDonorFilter.bloodGroup = _donorBloodGroup;
                  } else {
                    AllDonorFilter.bloodGroup = null;
                  }
                  if (_division != 'All') {
                    AllDonorFilter.division = _division;
                  } else {
                    AllDonorFilter.division = null;
                  }
                }
                if (widget.filterType == FilterType.AllRequest){
                  if (_donorBloodGroup != 'All') {
                    AllRequestFilter.bloodGroup = _donorBloodGroup;
                  } else {
                    AllRequestFilter.bloodGroup = null;
                  }
                  if (_division != 'All') {
                    AllRequestFilter.division = _division;
                  } else {
                    AllRequestFilter.division = null;
                  }
                }
                widget.callBack();
                Navigator.pop(context);
              },
              text: 'APPLY',
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
