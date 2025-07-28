class StartConversationModel {
  final String id;
  final String renterId;
  final String userId;
  final List<String> participants;
  final DateTime lastUpdated;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  StartConversationModel({
    required this.id,
    required this.renterId,
    required this.userId,
    required this.participants,
    required this.lastUpdated,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory StartConversationModel.fromJson(Map<String, dynamic> json) {
    return StartConversationModel(
      id: json['_id'],
      renterId: json['renterId'],
      userId: json['userId'],
      participants: List<String>.from(json['participants']),
      lastUpdated: DateTime.parse(json['lastUpdated']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'renterId': renterId,
      'userId': userId,
      'participants': participants,
      'lastUpdated': lastUpdated.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
