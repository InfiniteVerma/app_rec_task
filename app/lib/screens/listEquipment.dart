import 'package:app_rec_task/http_service.dart';
import 'package:app_rec_task/models/equipment.dart';
import 'package:app_rec_task/screens/equipmentDetail.dart';
import 'package:flutter/material.dart';

class EquipmentList extends StatefulWidget {
  @override
  _EquipmentListState createState() => _EquipmentListState();
}

class _EquipmentListState extends State<EquipmentList> {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: httpService.getEquipments(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Equipment>> snapshot) {
          if (snapshot.hasData) {
            List<Equipment> equipments = snapshot.data;
            return ListView.builder(
                itemCount: equipments.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EquipmentDetail(
                              equipment: equipments[index],
                            ))),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        equipments[index].title,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
