class UserPlace {
  DateTime date;
  String startPoint;
  String dest;
  String startID;
  String destID;

  UserPlace({DateTime date, String startPoint, String dest, String startID, String destID}) {
    this.date = date;
    this.startPoint = startPoint;
    this.dest = dest;
    this.startID = startID;
    this.destID = destID;
  }
}