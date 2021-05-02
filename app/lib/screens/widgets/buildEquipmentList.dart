import 'package:app_rec_task/models/equipment.dart';
import 'package:app_rec_task/screens/equipmentDetail.dart';
import 'package:flutter/material.dart';

Expanded buildEquipmentList(List<Equipment> equipments) {
  return Expanded(
    child: ListView.builder(
        itemCount: equipments.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EquipmentDetail(
                      equipment: equipments[index],
                    ))),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xfff8ad9d).withOpacity(0.9),
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
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            child: Text('Subtitle',
                                style: TextStyle(fontSize: 15)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "+91 " + equipments[index].phoneNumber.toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
  );
}
