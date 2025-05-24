class FeedBackSubmitResponse {
  int? id;
  String? comment;
  String? rating;
  String? custId;
  String? createdDate;
  String? feedbackDate;

  FeedBackSubmitResponse(
      {this.id,
        this.comment,
        this.rating,
        this.custId,
        this.createdDate,
        this.feedbackDate});

  FeedBackSubmitResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
    custId = json['cust_id'];
    createdDate = json['created_date'];
    feedbackDate = json['feedback_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['cust_id'] = this.custId;
    data['created_date'] = this.createdDate;
    data['feedback_date'] = this.feedbackDate;
    return data;
  }
}
