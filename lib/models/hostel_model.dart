class HostelModel {
  final String hostelName;
  final String hostelType;
  final String hostelLocation;
  final String description;
  final String roomType;
  final String noOfRoom;
  final String wifiAvailable;
  final String bathroomAvailable;
  final String parkingvailable;
  final String foodServicesAvailable;
  final String transportavailable;
  final String userId;

  HostelModel({
    required this.hostelName,
    required this.userId,
    required this.hostelType,
    required this.hostelLocation,
    required this.description,
    required this.roomType,
    required this.noOfRoom,
    required this.wifiAvailable,
    required this.bathroomAvailable,
    required this.parkingvailable,
    required this.foodServicesAvailable,
    required this.transportavailable,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hostelName': hostelName,
      'userId': userId,
      'hostelType': hostelType,
      'hostelLocation': hostelLocation,
      'description': description,
      'roomType': roomType,
      'noOfRoom': noOfRoom,
      'wifiAvailable': wifiAvailable,
      'bathroomAvailable': bathroomAvailable,
      'parkingvailable': parkingvailable,
      'foodServicesAvailable': foodServicesAvailable,
      'transportavailable': transportavailable,
    };
  }

  factory HostelModel.fromMap(Map<String, dynamic> map) {
    return HostelModel(
      userId: map['userId'] as String,
      hostelName: map['hostelName'] as String,
      hostelType: map['hostelType'] as String,
      hostelLocation: map['hostelLocation'] as String,
      description: map['description'] as String,
      roomType: map['roomType'] as String,
      noOfRoom: map['noOfRoom'] as String,
      wifiAvailable: map['wifiAvailable'] as String,
      bathroomAvailable: map['bathroomAvailable'] as String,
      parkingvailable: map['parkingvailable'] as String,
      foodServicesAvailable: map['foodServicesAvailable'] as String,
      transportavailable: map['transportavailable'] as String,
    );
  }
}
