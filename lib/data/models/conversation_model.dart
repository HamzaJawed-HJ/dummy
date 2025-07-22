class ConversationModel {
  final String id;
  final String?lastMessage;
  final String lastUpdated;
  final Participant participant;

  ConversationModel({
    required this.id,
    required this.lastMessage,
    required this.lastUpdated,
    required this.participant,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      lastMessage: json['lastMessage'] ?? 'No messages yet',
      lastUpdated: json['lastUpdated'],
      participant: Participant.fromJson(json['participant']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastMessage': lastMessage,
      'lastUpdated': lastUpdated,
      'participant': participant.toJson(),
    };
  }
}

class Participant {
  final String id;
  final String fullName;
  final String profilePicture;

  Participant({
    required this.id,
    required this.fullName,
    required this.profilePicture,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      fullName: json['fullName'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'profilePicture': profilePicture,
    };
  }
}
