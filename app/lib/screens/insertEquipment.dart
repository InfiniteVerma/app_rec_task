import 'dart:io';
import 'package:app_rec_task/constants.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:ffi';
import 'dart:async';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
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

  upload(File imageFile) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("https://dry-plains-59279.herokuapp.com/equipment");

    equipment.date = DateTime.now().toString();
    // create multipart request
    var request = new http.MultipartRequest("POST", uri)
      ..fields['title'] = equipment.title
      ..fields['desc'] = equipment.desc
      ..fields['location'] = equipment.location
      ..fields['date'] = equipment.date
      ..fields['phoneNumber'] = equipment.phoneNumber.toString();

    // multipart that takes file
    var multipartFile = new http.MultipartFile('img', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Insert Equipment")),
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
                ElevatedButton(
                  onPressed: getImage,
                  child: Text('Upload Image'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final form = _formKey.currentState;

                    if (form.validate()) {
                      form.save();
                      equipment.date = DateTime.now().toString();
                      print(equipment);
                      upload(_image);
                      // await httpService.insertEquipment(equipment);
                      Navigator.of(context).pop();
                    } else {
                      print("Error");
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ));
  }

  Padding buildDropdown(
      String hintText, List<String> listItems, String val, Function onchanged) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: DropdownButtonFormField(
        hint: Text(hintText),
        items: listItems.map((String category) {
          return new DropdownMenuItem(
              value: category,
              child: Row(
                children: <Widget>[
                  Text(category),
                ],
              ));
        }).toList(),
        onChanged: onchanged,
        value: val,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
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
