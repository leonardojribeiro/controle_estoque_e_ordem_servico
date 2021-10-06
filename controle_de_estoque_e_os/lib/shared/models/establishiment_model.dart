class EstalishimentModel {
  EstalishimentModel({
    this.id,
    this.displayName,
  });

  factory EstalishimentModel.fromMap(Map<String, dynamic> map) {
    return EstalishimentModel(
      id: map['id'],
      displayName: map['displayName'],
    );
  }

  final String? id;
  final String? displayName;

  EstalishimentModel copyWith({
    String? id,
    String? displayName,
  }) {
    return EstalishimentModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
    };
  }

  @override
  String toString() => 'EstalishimentModel(id: $id, displayName: $displayName)';
}
