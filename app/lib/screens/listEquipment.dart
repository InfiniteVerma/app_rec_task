import 'package:app_rec_task/models/equipment.dart';
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
    _list.add(Equipment(id: 1, title: "TItle1", desc: "Desc1"));
    _list.add(Equipment(id: 2, title: "TItle2", desc: "Desc2"));
    _list.add(Equipment(id: 3, title: "TItle3", desc: "Desc3"));
    _list.add(Equipment(id: 4, title: "TItle4", desc: "Desc4"));
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
              },
              child: ListTile(
                title: Text(_list[index].title),
              ),
            );
          }),
    );
  }
}
