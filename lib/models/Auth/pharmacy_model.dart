class PharmacyModel {
  String? pharmacyId;
  String? pharmacyName;
  String? email;

  PharmacyModel(
      {this.pharmacyId, this.pharmacyName,this.email});

  PharmacyModel.fromJson(Map<String, dynamic> json) {
    pharmacyId = json['pharmacyId'];
    pharmacyName = json['pharmacyName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pharmacyId'] = this.pharmacyId;
    data['pharmacyName'] = this.pharmacyName;
    data['email'] = this.email;
    return data;
  }
}



/*
{
    "pharmacyId": "",
    "pharmacyName": "",
    "firstName": "",
    "lastName": "",
    "email": ""
}
 */