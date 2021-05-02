import 'package:app_rec_task/models/equipment.dart';
import 'package:flutter/material.dart';

class EquipmentDetail extends StatelessWidget {
  const EquipmentDetail({Key key, this.equipment}) : super(key: key);

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(equipment.date);
    var mydate = date.year.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.day.toString();

    return Scaffold(
        appBar: AppBar(title: Text('Test')),
        body: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                height: 200,
                decoration: BoxDecoration(border: Border.all()),
                child: Center(
                  child: Text('Image'),
                ),
              ),
              buildTextContainer("Title", equipment.title),
              buildTextContainer("Desc", equipment.desc),
              buildTextContainer("Location", equipment.location),
              buildTextContainer("Phone", equipment.phoneNumber.toString()),
              buildTextContainer("Date", mydate),
            ],
          ),
        ));
  }

  Container buildTextContainer(String key, String text) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              key,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              text,
              style: TextStyle(fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }
}
