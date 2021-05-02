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
                  equip.isNotEmpty ? buildEquipmentList(equip) : showEmptyMsg(),
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

  Expanded showEmptyMsg() {
    return Expanded(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: Text(
              "No search results found.\nTry again soon.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          )),
    );
  }

  Container buildTypeFilter(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 5),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                          padding: const EdgeInsets.all(7),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: typeChosen == typesOfEquipment.indexOf(e)
                                ? Color(0xfff8ad9d)
                                : Colors.white,
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), 
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                          child: Center(
                              child: Text(
                            e,
                            style: TextStyle(
                                fontSize: 16,
                                color: typeChosen == typesOfEquipment.indexOf(e)
                                    ? Colors.grey[100]
                                    : null),
                          ))),
                    )),
              )
              .toList()),
    );
  }
}
