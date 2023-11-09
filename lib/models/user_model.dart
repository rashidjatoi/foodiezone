class UserModel {
  final String username;
  final String email;
  final String dateofbith;
  final String address;
  final String gender;
  final String phone;
  final String cninc;
  final String userId;

  UserModel(
      {required this.username,
      required this.email,
      required this.dateofbith,
      required this.address,
      required this.gender,
      required this.phone,
      required this.cninc,
      required this.userId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': userId,
      'dateofbith': dateofbith,
      'address': address,
      'gender': gender,
      'phone': phone,
      'cninc': cninc,
      'userId': userId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      cninc: map['cninc'] as String,
      dateofbith: map['dateofbith'] as String,
      gender: map['gender'] as String,
      phone: map['phone'] as String,
    );
  }
}
