class SignUpBody{
  String name;
  String phone;
  String email;
  String password;
  SignUpBody({ required this.name, required this.password,
    required this.phone, required this.email});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["f_name"] = this.name;
    data["phone"] = this.phone;
    data["email"] = this.email;
    data["password"] = this.password;
    return data;

  }

}