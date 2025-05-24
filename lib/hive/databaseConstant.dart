class DataBaseConstants{

  //user location table
  static const String locationTable="UserLocation";
  static const String userLatitude="userlatitude";
  static const String userLongitude="userlongitude";
  static const String userLocationCreated="date";



  static const String dailyVisitFeedbackTable="DailyVisitFeedback";
  static const String dailyVisitIdTable="UserVisitId";
  static const String dailyPointsTravelledTable="DailyPoints";
  static const String tableplant="AllPlants";
  static const String tableTrackTarget="DailyTrackTarget";



  //https://stackoverflow.com/questions/63103065/flutter-sqflite-databaseexceptionno-such-table-project

  /*static const tableUserLocation = """
  CREATE TABLE IF NOT EXISTS UserLocation (
        id TEXT PRIMARY key,
        userlatitude TEXT,
        userlongitude TEXT
      );""";*/
}