
class LocationString{

   String? userlatitude;
  String? userlongitude;

  LocationString({
    required this.userlatitude,
    required this.userlongitude,
  });

   Map<String, dynamic> toMap() {
     return {
       'userlatitude': userlatitude,
       'userlongitude': userlongitude,
     };
   }

   factory LocationString.fromJson(Map<String, dynamic> map) {
     return LocationString(
         userlatitude: map['userlatitude'],
         userlongitude: map['userlongitude']
     );
   }

   /*@override
  String toString() {
    return 'LocationString{userLatitude: $userlatitude, userLongitude: $userlongitude}';
  }*/
}