class UserModel {

  int? id;
  String? userName,firstName, lastName, email, phoneNumber,profileImage;
  bool? isBLocked;
  String? createdAt,updatedAt;

  UserModel.fromJSON(Map<String,dynamic> map) {
      id = map['id'];
      userName = map['userName'];
      firstName = map['firstName'];
      lastName = map['lastName'];
      email = map['email'];
      profileImage = map['profileImage'];
      phoneNumber = map['phoneNumber'];
      isBLocked = map['isBLocked'];
      createdAt = map['created_at'];
      updatedAt = map['updated_at'];
  }

  Map<String,dynamic> toJSON(){
    return {
      "id":id,
      "userName":userName,
      "firstName":firstName,
      "lastName":lastName,
      "email":email,
      "phoneNumber":phoneNumber,
      "isBLocked":isBLocked,
      "profileImage":profileImage,
      "created_at":createdAt,
      "updated_at":updatedAt
    };
  }
}