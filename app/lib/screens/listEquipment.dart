import 'package:app_rec_task/constants.dart';
import 'package:app_rec_task/http_service.dart';
import 'package:app_rec_task/models/equipment.dart';
import 'package:app_rec_task/screens/widgets/buildDropDown.dart';
import 'package:app_rec_task/screens/widgets/buildEquipmentList.dart';
import 'package:flutter/material.dart';

class EquipmentList extends StatefulWidget {
  @override
  _EquipmentListState createState() => _EquipmentListState();
}

class _EquipmentListState extends State<EquipmentList> {
  final HttpService httpService = HttpService();
  int typeChosen = 0;
  String stateChosen = 'Uttar Pradesh';

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
              List<Equipment> equipments = snapshot.data;
              var equip = equipments
                  .where((e) =>
                      e.type == typesOfEquipment[typeChosen] &&
                      e.location == stateChosen)
                  .toList();
              return Column(
                children: [
                  buildTypeFilter(context),
                  buildDropdown('Choose State', indiaStates, 'Uttar Pradesh',
                      (val) {
                    setState(() {
                      stateChosen = val;
                    });
                  }),
                  buildEquipmentList(equip),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Container buildTypeFilter(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: typesOfEquipment
              .map(
                (e) => GestureDetector(
                    onTap: () {
                      print('$e pressed');
                      setState(() {
                        typeChosen = typesOfEquipment.indexOf(e);
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: typeChosen == typesOfEquipment.indexOf(e)
                                ? Colors.blue[200]
                                : null,
                            border: Border.all()),
                        child: Center(child: Text(e)))),
              )
              .toList()),
    );
  }
}
