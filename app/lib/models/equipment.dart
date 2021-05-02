class Equipment {
  String id;
  String title;
  String desc;
  String location;
  String date;
  int phoneNumber;
  String img;
  String type;

  Equipment(
      {this.id,
      this.title,
      this.desc,
      this.location,
      this.date,
      this.type,
      this.phoneNumber,
      this.img});

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
        id: json['_id'] as String,
        title: json['title'] as String,
        desc: json['desc'] as String,
        location: json['location'] as String,
        date: json['date'] as String,
        phoneNumber: json['phoneNumber'] as int,
        img: json['img'] as String,
        type: json['type'] as String);
  }

  @override
  String toString() {
    print(
        "Title:$title\tDesc:$desc\tLocation:$location\tDate:$date\tPno:$phoneNumber\tImage:$img\Type:$type");
  }
}
