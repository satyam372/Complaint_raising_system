class User {
  String id_no;
  String user_id;
  String pass;

  User(this.id_no, this.user_id, this.pass);

  Map<String, dynamic> toJson() {
    return {
      'id_no': id_no,
      'user_id': user_id,
      'pass': pass,
    };
  }
}



