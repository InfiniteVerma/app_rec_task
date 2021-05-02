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

  Future<List<Equipment>> _refreshEquipmentList(BuildContext context) {
    return httpService.getEquipments();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () => _refreshEquipmentList(context),
        child: FutureBuilder(
          future: httpService.getEquipments(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Equipment>> snapshot) {
            if (snapshot.hasData) {
              print("ja");
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
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                equipments[index].title,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(equipments[index].location),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(equipments[index]
                                          .phoneNumber
                                          .toString()),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
