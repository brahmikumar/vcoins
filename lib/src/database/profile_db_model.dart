class ProfileModel {
  int? id;
  late String name;
  late String emailId;
  late String address;

  ProfileModel(this.name, this.emailId, this.address);
  ProfileModel.withId(this.id, this.name, this.emailId, this.address);

  //model to map
  Map<String, dynamic> toProfileMap(){
    Map<String, dynamic> profileMap = {};

    if(id != null){
      profileMap["id"] = id;
    }

    profileMap["name"] = name;
    profileMap["emailId"] = emailId;
    profileMap["address"] = address;

    return profileMap;
  }

  //map to model
  ProfileModel.fromProfileMap(Map<String,dynamic> profileMap){
    id = profileMap["id"];
    name = profileMap["name"];
    emailId = profileMap["emailId"];
    address = profileMap["address"];
  }

}