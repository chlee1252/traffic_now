class UserPlace {
  DateTime date;
  String startPoint;
  String dest;
  String startID;
  String destID;
  String estTime;
  int estValue;
  bool turnON;

  UserPlace({DateTime date, String startPoint, String dest, String startID, String destID, int estValue, bool turnON=false}) {
    this.date = date;
    this.startPoint = startPoint;
    this.dest = dest;
    this.startID = startID;
    this.destID = destID;
    this.turnON = turnON;
    this.estValue = estValue;
  }

  formatURL() {
    return this.dest.replaceAll(' ', '+').replaceAll(',', '');
  }

  supportJSON() {
    Map<String, dynamic> map = new Map();
    map['date'] = this.date.toString();
    map['start'] = this.startPoint;
    map['dest'] = this.dest;
    map['startID'] = this.startID;
    map['destID'] = this.destID;
    map['turnON'] = this.turnON;

    return map;
  }

}