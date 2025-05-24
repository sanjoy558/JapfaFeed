class BrochureResponse {
  int? id;
  String? fileName;
  String? path;
  String? type;
  String? uploadDate;

  BrochureResponse(
      {this.id, this.fileName, this.path, this.type, this.uploadDate});

  BrochureResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['file_name'];
    path = json['path'];
    type = json['type'];
    uploadDate = json['upload_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file_name'] = this.fileName;
    data['path'] = this.path;
    data['type'] = this.type;
    data['upload_date'] = this.uploadDate;
    return data;
  }
}
