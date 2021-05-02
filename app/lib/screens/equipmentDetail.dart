import 'package:app_rec_task/models/equipment.dart';
import 'package:flutter/material.dart';

class EquipmentDetail extends StatelessWidget {
  const EquipmentDetail({Key key, this.equipment}) : super(key: key);

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Test')),
        body: Container(
          child: Column(
            children: [
              Container(
                child: Text(equipment.title),
              ),
              Container(
                child: Text(equipment.desc),
              ),
              Container(
                child: Text(equipment.location),
              ),
              Container(
                child: Text(equipment.date),
              ),
            ],
          ),
        ));
  }
}
