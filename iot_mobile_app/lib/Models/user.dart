class User {
  final String name;
  final String email;
  final String phone;
  final String addr;

  User(this.name, this.email, this.phone, this.addr);

  User.fromJson(Map<String, dynamic> json)
      : name = json['EmpName'],
        email = json['Email'],
        phone = json['MobileNo'],
        addr = json['Address'];

  Map<String, dynamic> toJson() => {
        'EmpName': name.toString(),
        'Email': email.toString(),
        'MobileNo': phone.toString(),
        'Address': addr.toString(),
      };
}
