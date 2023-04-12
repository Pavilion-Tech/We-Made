class ChatHisModel {
  String? message;
  bool? status;
  List<ChatHisData>? data;

  ChatHisModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ChatHisData>[];
      json['data'].forEach((v) {
        data!.add(ChatHisData.fromJson(v));
      });
    }
  }

}

class ChatHisData {
  String? id;
  int? status;
  String? userName;
  String? userPhone;
  String? userAddress;
  String? userImage;
  LastMessage? lastMessage;
  String? providerName;
  String? specialRequestAudioFile;
  String? createdAt;


  ChatHisData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    userAddress = json['user_address'];
    userImage = json['user_image'];
    lastMessage = json['last_message'] != null
        ? new LastMessage.fromJson(json['last_message'])
        : null;
    providerName = json['provider_name'];
    specialRequestAudioFile = json['special_request_audio_file'];
    createdAt = json['created_at'];
  }

}

class LastMessage {
  String? id;
  int? messageType;
  String? sender;
  String? createdAt;
  String? message;

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageType = json['message_type'];
    sender = json['sender'];
    createdAt = json['created_at'];
    message = json['message'];
  }

}
