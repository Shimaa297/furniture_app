class UserModel{

  String uid;
  String username;
  String phone;
  String email;
  String photo;
  bool state;

  UserModel({
    this.uid,
    this.phone,
    this.email,
    this.username,
    this.photo,
    this.state
  });

    UserModel.fromJson(Map<String , dynamic> json){
        uid = json['uid'];
        phone= json['phone'];
        email= json['email'];
        username= json['username'];
        photo= json['photo'];
        state= json['state'];
  }

  Map<String, dynamic> myMap () {
      return {
        'email' : email,
        'username' : username,
        'photo' : photo,
        'uid' : uid,
        'phone' : phone
      };
  }
}