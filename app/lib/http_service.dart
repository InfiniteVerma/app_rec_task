import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart';
import 'models/equipment.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

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

  upload(File imageFile, Equipment equipment) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("https://dry-plains-59279.herokuapp.com/equipment");

    equipment.date = DateTime.now().toString();
    // create multipart request
    var request = new http.MultipartRequest("POST", uri)
      ..fields['title'] = equipment.title
      ..fields['desc'] = equipment.desc
      ..fields['location'] = equipment.location
      ..fields['date'] = equipment.date
      ..fields['phoneNumber'] = equipment.phoneNumber.toString()
      ..fields['type'] = equipment.type;

    // multipart that takes file
    var multipartFile = new http.MultipartFile('img', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}
