import 'package:app_rec_task/models/equipment.dart';
import 'package:app_rec_task/screens/equipmentDetail.dart';
import 'package:flutter/material.dart';

class EquipmentList extends StatefulWidget {
  @override
  _EquipmentListState createState() => _EquipmentListState();
}

class _EquipmentListState extends State<EquipmentList> {
  List<Equipment> _list = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list.add(Equipment(
        id: 1,
        title: "TItle1",
        desc: "Desc1",
        imageUrl: "www.google.com",
        date: "today"));
    _list.add(Equipment(
        id: 2,
        title: "TItle2",
        desc: "Desc2",
        imageUrl: "www.google.com",
        date: "today"));
    _list.add(Equipment(
        id: 3,
        title: "TItle3",
        desc: "Desc3",
        imageUrl: "www.google.com",
        date: "today"));
    _list.add(Equipment(
        id: 4,
        title: "TItle4",
        desc: "Desc4",
        imageUrl: "www.google.com",
        date: "today"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print("AT item: $index");
                Navigator.push(context, MaterialPageRoute(builder: (context) => EquipmentDetail(equipment: _list[index])));
              },
              child: ListTile(
                title: Text(_list[index].title),
              ),
            );
          }),
    );
  }
}
