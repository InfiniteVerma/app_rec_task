import 'dart:io';
import 'package:app_rec_task/constants.dart';
import 'package:app_rec_task/screens/widgets/buildDropDown.dart';
import 'dart:async';
import 'package:app_rec_task/models/equipment.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../http_service.dart';

class InsertEquipment extends StatefulWidget {
  @override
  _InsertEquipmentState createState() => _InsertEquipmentState();
}

class _InsertEquipmentState extends State<InsertEquipment> {
  String title = "", desc, location, phoneNumber;
  Equipment equipment = Equipment();
  final HttpService httpService = HttpService();
  File _image;
  final picker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffD9E5D6),
        appBar: AppBar(
          title: Text("Insert Equipment"),
          backgroundColor: Color(0xffF08080),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                inputWidget('Title', (val) {
                  setState(() {
                    equipment.title = val;
                  });
                }),
                inputWidget('Description', (val) {
                  setState(() {
                    equipment.desc = val;
                  });
                }),
                buildDropdown(
                  'State',
                  indiaStates,
                  equipment.location,
                  (newValue) {
                    setState(() => equipment.location = newValue);
                  },
                ),
                buildDropdown('Type', typesOfEquipment, equipment.type, (val) {
                  setState(() {
                    equipment.type = val;
                  });
                }),
                inputWidget('Phone Number', (val) {
                  setState(() {
                    equipment.phoneNumber = int.parse(val);
                  });
                }),
                GestureDetector(
                  onTap: getImage,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Text(
                      'Upload Image',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xffD9E5D6),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: Colors.black45)),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final form = _formKey.currentState;

                    if (form.validate()) {
                      form.save();
                      equipment.date = DateTime.now().toString();
                      print(equipment);
                      httpService.upload(_image, equipment);
                      // await httpService.insertEquipment(equipment);
                      Navigator.of(context).pop();
                    } else {
                      print("Error");
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Text(
                      'Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xffF08080).withOpacity(0.8),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: Colors.black45)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Padding inputWidget(String label, Function onsaved) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
          onChanged: (value) {
            debugPrint('Something happned in $label!');
          },
          validator: (value) {
            if (value.length != 10 && label == 'Phone Number') {
              return 'Phone Number must be 10 digits long';
            }
            if (value.isEmpty) {
              return 'Please enter $label';
            }
          },
          onSaved: onsaved,
          decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ))),
    );
  }
}
