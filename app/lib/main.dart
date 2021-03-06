import 'package:app_rec_task/screens/insertEquipment.dart';
import 'package:app_rec_task/screens/listEquipment.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD9E5D6),
      appBar: AppBar(
        backgroundColor: Color(0xffF08080),
        title: Text('Test'),
      ),
      body: EquipmentList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          print("Insert button pressed");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => InsertEquipment()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xffF08080),
      ),
    );
  }
}
