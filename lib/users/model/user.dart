class User
{
  // int u_id;
  String u_name;
  String u_email;
  String u_password;

  User(
    // this.u_id,
    this.u_name,
    this.u_email,
    this.u_password,
  );

  factory User.fromJson(Map<String, dynamic>json)=>User
  (
    // int.parse(json["u_id"]), 
    json["u_name"], 
    json["u_email"], 
    json["u_password"],
  );

  Map<String, dynamic> toJson()=>
  {
    // 'u_id':u_id.toString(),
    'u_name':u_name,
    'u_email':u_email,
    'u_password':u_password,
  };
}