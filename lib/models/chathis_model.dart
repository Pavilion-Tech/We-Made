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
    providerName = json['provider_name'];
    specialRequestAudioFile = json['special_request_audio_file'];
    createdAt = json['created_at'];
  }

}
