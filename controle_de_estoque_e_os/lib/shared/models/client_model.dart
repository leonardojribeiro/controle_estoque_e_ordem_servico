class ClientModel {
  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'],
      cpf: map['cpf'],
      fullName: map['fullName'],
      telephone: map['telephone'],
      whatsapp: map['whatsapp'],
      fullAddress: map['fullAddress'],
    );
  }

  ClientModel({
    this.id,
    this.cpf,
    this.fullName,
    this.telephone,
    this.whatsapp,
    this.fullAddress,
  });

  final String? id;
  final String? cpf;
  final String? fullName;
  final String? telephone;
  final String? whatsapp;
  final String? fullAddress;

  ClientModel copyWith({
    String? id,
    String? cpf,
    String? fullName,
    String? telephone,
    String? whatsapp,
    String? fullAddress,
  }) {
    return ClientModel(
      id: id ?? this.id,
      cpf: cpf ?? this.cpf,
      fullName: fullName ?? this.fullName,
      telephone: telephone ?? this.telephone,
      whatsapp: whatsapp ?? this.whatsapp,
      fullAddress: fullAddress ?? this.fullAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (fullName != null) 'cpf': cpf,
      if (fullName != null) 'fullName': fullName,
      if (telephone != null) 'telephone': telephone,
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (fullAddress != null) 'fullAddress': fullAddress,
    };
  }

  @override
  String toString() {
    return 'ClientModel(id: $id, cpf: $cpf, fullName: $fullName, telephone: $telephone, whatsapp: $whatsapp, fullAddress: $fullAddress)';
  }
}
