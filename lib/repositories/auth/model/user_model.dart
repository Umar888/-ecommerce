class UserModel {
  bool? status;
  String? message;
  String? name;
  String? email;
  String? uid;

  UserModel({this.status, this.message, this.name, this.email, this.uid});

  UserModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    message = json['message'];
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['uid'] = uid;
    return data;
  }
}