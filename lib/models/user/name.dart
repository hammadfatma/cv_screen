class Name {
  String? firstname;
  String? lastname;

  Name({this.firstname, this.lastname});

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        firstname: json['firstname'] as String?,
        lastname: json['lastname'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
      };
}
