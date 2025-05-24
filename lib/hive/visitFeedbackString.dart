class VisitFeedBackString {
  double? distance;
  String? flockNumber;
  double? latitude;
  double? longitude;
  String? operationType;
  String? remark;
  String? routeId;
  String? superVisorId;
  String? timeStamp;
  String? visitDate;

  VisitFeedBackString(
      {required this.distance,
      required this.flockNumber,
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
      'flockNumber': flockNumber,
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

  factory VisitFeedBackString.fromJson(Map<String, dynamic> map) {
    return VisitFeedBackString(
      distance: map['distance'],
      flockNumber: map['flockNumber'],
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
