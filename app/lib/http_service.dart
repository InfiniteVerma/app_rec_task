import 'dart:convert';

import 'package:http/http.dart';
import 'models/equipment.dart';

class HttpService {
  final Uri url = Uri.parse('https://dry-plains-59279.herokuapp.com/equipment');

  Future<List<Equipment>> getEquipments() async {
    Response res = await get(url);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Equipment> equipments = body
          .map(
            (dynamic item) => Equipment.fromJson(item),
          )
          .toList();

      return equipments;
    } else {
      throw "Unable";
    }
  }

  Future<void> insertEquipment(Equipment equipment) async {
    Response res = await post(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode(<String, String>{
      'title': equipment.title,
      'desc': equipment.desc,
      'location': equipment.location,
      'phoneNumber': equipment.phoneNumber.toString(),
      'date': equipment.date
    }),);

    if (res.statusCode == 200) {
      print("Created");
      return Equipment.fromJson(jsonDecode(res.body));
    } else {
      throw "Unable to create post.";
    }
  }
}
