// class MessageModel {
//   final String id;
//   final String conversationId;
//   final String senderId;
//   final String message;
//   final bool seen;
//   final String createdAt;
//   final String updatedAt;

//   MessageModel({
//     required this.id,
//     required this.conversationId,
//     required this.senderId,
//     required this.message,
//     required this.seen,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory MessageModel.fromJson(Map<String, dynamic> json) {
//     return MessageModel(
//       id: json['_id'],
//       conversationId: json['conversationId'],
//       senderId: json['senderId'],
//       message: json['message'],
//       seen: json['seen'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'conversationId': conversationId,
//       'senderId': senderId,
//       'message': message,
//       'seen': seen,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//     };
//   }
// }

class MessageModel {
  String? userId;
  List<Messages>? messages;

  MessageModel({this.userId, this.messages});

  MessageModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? sId;
  String? conversationId;
  String? senderId;
  String? message;
  bool? seen;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Messages(
      {this.sId,
      this.conversationId,
      this.senderId,
      this.message,
      this.seen,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Messages.fromJson(Map<String, dynamic> json) {
    // sId = json['_id'];
    // conversationId = json['conversationId'];
    // senderId = json['senderId'];
    // message = json['message'];
    // seen = json['seen'];
    // createdAt = json['createdAt'];
    // updatedAt = json['updatedAt'];
    // iV = json['__v'];

    sId = json['_id'] ?? '';
    conversationId = json['conversationId'] ?? '';
    senderId = json['senderId'] ?? '';
    message = json['message'] ?? '';
    seen = json['seen'] ?? false;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    iV = json['__v'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['conversationId'] = this.conversationId;
    data['senderId'] = this.senderId;
    data['message'] = this.message;
    data['seen'] = this.seen;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
