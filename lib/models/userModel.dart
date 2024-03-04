class UserModel {

  int? id;
  String? firstName, lastName, email, phoneNumber;
  bool? isBLocked;
  String? createdAt,updatedAt;

  UserModel.fromJSON(Map<String,dynamic> map) {
      id = map['id'];
      firstName = map['firstName'];
      lastName = map['lastName'];
      email = map['email'];
      phoneNumber = map['phoneNumber'];
      isBLocked = map['isBLocked'];
      createdAt = map['created_at'];
      updatedAt = map['updated_at'];
  }

  Map<String,dynamic> toJSON(){
    return {
      "id":id,
      "firstName":firstName,
      "lastName":lastName,
      "email":email,
      "phoneNumber":phoneNumber,
      "isBLocked":isBLocked,
      "created_at":createdAt,
      "updated_at":updatedAt
    };
  }
}