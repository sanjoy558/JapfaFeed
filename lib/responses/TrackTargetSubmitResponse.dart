class TrackTargetSubmitResponse {
  List<String>? success;

  TrackTargetSubmitResponse({this.success});

  TrackTargetSubmitResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    return data;
  }
}
