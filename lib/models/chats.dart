class Chats {
  String? sId;
  SenderId? senderId;
  SenderId? receiverId;
  String? message;
  String? createdAt;

  String? updatedAt;
  int? iV;

  Chats(
      {this.sId,
      this.senderId,
      this.receiverId,
      this.message,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Chats.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderId =
        json['senderId'] != null ? SenderId.fromJson(json['senderId']) : null;
    receiverId = json['receiverId'] != null
        ? SenderId.fromJson(json['receiverId'])
        : null;
    message = json['message'];

    createdAt = json['profile_picture'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    if (senderId != null) {
      data['senderId'] = senderId!.toJson();
    }
    if (receiverId != null) {
      data['receiverId'] = receiverId!.toJson();
    }
    data['message'] = message;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }

  static List<Chats> fromList(List json) {
    print(json);
    List<Chats> chats = [];
    if (json.isEmpty) {
      return chats;
    }
    for (var item in json) {
      chats.add(Chats.fromJson(item));
    }
    print(chats);
    return chats;
  }
}

class SenderId {
  String? sId;
  String? fullName;
  bool? isDriver;
  String? profilePic;
  String? id;

  SenderId({this.sId, this.fullName, this.isDriver, this.id, this.profilePic});

  SenderId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['full_name'];
    isDriver = json['is_driver'];
    profilePic = json['profile_picture'];

    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['full_name'] = fullName;
    data['is_driver'] = isDriver;
    data['profile_picture'] = profilePic;
    data['id'] = id;
    return data;
  }
}
