
class VisitIdString{

   String? id;

   VisitIdString({
    required this.id,
  });

   Map<String, dynamic> toMap() {
     return {
       'id': id
     };
   }

   factory VisitIdString.fromJson(Map<String, dynamic> map) {
     return VisitIdString(
         id: map['id']
     );
   }

   /*@override
  String toString() {
    return 'LocationString{userLatitude: $userlatitude, userLongitude: $userlongitude}';
  }*/
}