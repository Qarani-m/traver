class BookingModel {
  String? personResponsible;
  String? phoneNumber;
  String? emailAddress;
  String? dates;
  String? idNumber;
  String? numberOfMembers;
  String? numberOfChildren;
  String? pwdNumber;
  String? destinationId;
  String? name;
  String? price;

  BookingModel(
      {this.personResponsible,
      this.phoneNumber,
      this.emailAddress,
      this.dates,
      this.idNumber,
      this.numberOfChildren,
      this.numberOfMembers,
      this.destinationId,
      this.name,
      this.price,
      this.pwdNumber});

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      personResponsible: json['personResponsible'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      emailAddress: json['emailAddress'] as String?,
      dates: json['dates'] as String?,
      idNumber: json['idNumber'] as String?,
      numberOfMembers: json['numberOfMembers'] as String?,
      numberOfChildren: json['numberOfChildren'] as String?,
      pwdNumber: json['pwdNumber'] as String?,
      destinationId: json['destinationId'] as String?,
      price: json['price'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personResponsible'] = personResponsible;
    data['phoneNumber'] = phoneNumber;
    data['emailAddress'] = emailAddress;
    data['dates'] = dates;
    data['idNumber'] = idNumber;
    data['idNumber'] = idNumber;
    data['numberOfChildren'] = numberOfChildren;
    data['pwdNumber'] = pwdNumber;
    data['destinationId'] = destinationId;
    data['price'] = price;
    data['name'] = name;
    return data;
  }
}
