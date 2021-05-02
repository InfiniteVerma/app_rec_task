import 'package:app_rec_task/models/equipment.dart';
import 'package:flutter/material.dart';
import '../http_service.dart';

class InsertEquipment extends StatefulWidget {
  @override
  _InsertEquipmentState createState() => _InsertEquipmentState();
}

class _InsertEquipmentState extends State<InsertEquipment> {
  String title = "", desc, location, phoneNumber;
  Equipment equipment = Equipment();
  final HttpService httpService = HttpService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                inputWidget('Location', (val) {
                  setState(() {
                    equipment.location = val;
                  });
                }),
                inputWidget('Phone Number', (val) {
                  setState(() {
                    equipment.phoneNumber = int.parse(val);
                  });
                }),
                ElevatedButton(
                  onPressed: () async {
                    final form = _formKey.currentState;

                    if (form.validate()) {
                      form.save();
                      equipment.date = DateTime.now().toString();
                      print(equipment);
                      await httpService.insertEquipment(equipment);
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
