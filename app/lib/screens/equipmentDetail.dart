import 'package:app_rec_task/models/equipment.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EquipmentDetail extends StatelessWidget {
  const EquipmentDetail({Key key, this.equipment}) : super(key: key);

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(equipment.date);
    var mydate = date.year.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.day.toString();

    return Scaffold(
        backgroundColor: Color(0xffD9E5D6),
        appBar: AppBar(
          backgroundColor: Color(0xffF08080),
          title: Text('Test'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  equipment.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                height: 200,
                child: Center(
                  child: Image.network(
                    "https://dry-plains-59279.herokuapp.com/" + equipment.img,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // border: Border.all(color: Colors.black54),
                  // borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  equipment.desc,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        Padding(
                          padding: const EdgeInsets.all(2),
                        ),
                        Text(
                          equipment.location,
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        Padding(
                          padding: const EdgeInsets.all(2),
                        ),
                        Text(
                          mydate,
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              GestureDetector(
                onTap: () {
                  print("call number");
                  _makingPhoneCall(equipment.phoneNumber.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff8ad9d),
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  // width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone),
                      Padding(
                        padding: const EdgeInsets.all(3),
                      ),
                      Text(
                        equipment.phoneNumber.toString(),
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _makingPhoneCall(phoneNo) async {
    String url = 'tel:+91' + phoneNo;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Container buildTextContainer(String key, String text, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
