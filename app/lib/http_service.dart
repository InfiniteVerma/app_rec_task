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
}
