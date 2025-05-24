class PointsTravelledString {
  double? distance;
  double? latitude;
  double? longitude;
  String? operationType;
  String? remark;
  String? routeId;
  String? superVisorId;
  String? timeStamp;
  String? visitDate;

  PointsTravelledString(
      {required this.distance,
      required this.latitude,
      required this.longitude,
      required this.operationType,
      required this.remark,
      required this.routeId,
      required this.superVisorId,
      required this.timeStamp,
      required this.visitDate});

  Map<String, dynamic> toMap() {
    return {
      'distance': distance,
      'latitude': latitude,
      'longitude': longitude,
      'operationType': operationType,
      'remark': remark,
      'routeId': routeId,
      'superVisorId': superVisorId,
      'timeStamp': timeStamp,
      'visitDate': visitDate
    };
  }

  factory PointsTravelledString.fromJson(Map<String, dynamic> map) {
    return PointsTravelledString(
      distance: map['distance'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      operationType: map['operationType'],
      remark: map['remark'],
      routeId: map['routeId'],
      superVisorId: map['superVisorId'],
      timeStamp: map['timeStamp'],
      visitDate: map['visitDate']
    );
  }

/*@override
  String toString() {
    return 'LocationString{userLatitude: $userlatitude, userLongitude: $userlongitude}';
  }*/
}
