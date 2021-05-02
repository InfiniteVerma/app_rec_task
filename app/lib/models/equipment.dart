class Equipment {
  int id;
  String title;
  String desc;
  String location;
  String date;
  int phoneNumber;

  Equipment({this.id, this.title, this.desc, this.location, this.date, this.phoneNumber});

  factory Equipment.fromJson(Map<String, dynamic> json){
    return Equipment(
      id : json['id'] as int,
      title: json['title'] as String,
      desc: json['desc'] as String,
      location: json['location'] as String,
      date: json['date'] as String,
      phoneNumber: json['phoneNumber'] as int
    );
  }
}
