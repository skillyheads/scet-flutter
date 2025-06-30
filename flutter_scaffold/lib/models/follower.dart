class Follower {
  final String id;
  final String name;
  final String mobileNumber;
  final String? avatarAsset;

  Follower({
    required this.id,
    required this.name,
    required this.mobileNumber,
    this.avatarAsset,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobileNumber': mobileNumber,
      'avatarAsset': avatarAsset,
    };
  }

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      id: json['id'],
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      avatarAsset: json['avatarAsset'],
    );
  }

  Follower copyWith({
    String? id,
    String? name,
    String? mobileNumber,
    String? avatarAsset,
  }) {
    return Follower(
      id: id ?? this.id,
      name: name ?? this.name,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      avatarAsset: avatarAsset ?? this.avatarAsset,
    );
  }
}
