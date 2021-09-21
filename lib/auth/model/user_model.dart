class UserModel {
  int id;
  String name;
  String avatar;
  String email;
  String password;
  String emailVerifiedAt;
  String providerFacebookId;
  String providerGoogleId;
  int isVerify;
  String phone;

  UserModel(
      {
        this.id,
        this.name,
        this.avatar,
        this.email,
        this.password,
        this.emailVerifiedAt,
        this.providerFacebookId,
        this.providerGoogleId,
        this.isVerify,
        this.phone,
      });
}