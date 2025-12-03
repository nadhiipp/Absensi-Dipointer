class UserModel {
  final String id;
  final String name;
  final String email;
  final String nip;
  final String department;
  final String position;
  final String? photoUrl;
  
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.nip,
    required this.department,
    required this.position,
    this.photoUrl,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      nip: json['nip'] ?? '',
      department: json['department'] ?? '',
      position: json['position'] ?? '',
      photoUrl: json['photoUrl'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'nip': nip,
      'department': department,
      'position': position,
      'photoUrl': photoUrl,
    };
  }
  
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? nip,
    String? department,
    String? position,
    String? photoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      nip: nip ?? this.nip,
      department: department ?? this.department,
      position: position ?? this.position,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
