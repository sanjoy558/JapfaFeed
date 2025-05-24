class SocialMediaMasterResponse {
  List<SocialMediaMasterObject>? data;
  String? message;
  bool? success;
  int? status;

  SocialMediaMasterResponse(
      {this.data, this.message, this.success, this.status});

  SocialMediaMasterResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SocialMediaMasterObject>[];
      json['data'].forEach((v) {
        data!.add(new SocialMediaMasterObject.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class SocialMediaMasterObject {
  int? id;
  String? socialMedia;
  String? socialMediaLink;
  String? createdDate;
  String? lastModifiedDate;

  SocialMediaMasterObject(
      {this.id,
        this.socialMedia,
        this.socialMediaLink,
        this.createdDate,
        this.lastModifiedDate});

  SocialMediaMasterObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    socialMedia = json['social_media'];
    socialMediaLink = json['social_media_link'];
    createdDate = json['created_date'];
    lastModifiedDate = json['last_modified_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['social_media'] = this.socialMedia;
    data['social_media_link'] = this.socialMediaLink;
    data['created_date'] = this.createdDate;
    data['last_modified_date'] = this.lastModifiedDate;
    return data;
  }
}
