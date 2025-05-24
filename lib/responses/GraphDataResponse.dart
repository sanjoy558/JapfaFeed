class GraphDataResponse {
  List<GraphData>? data;
  String? message;
  bool? success;
  int? status;

  GraphDataResponse(
      {this.data, this.message, this.success, this.status});

  GraphDataResponse.fromJson(Map<String, dynamic> json) {

    message = json['message'];
    success = json['success'];
    status = json['status'];

    if (json['data'] != null) {
      data = <GraphData>[];
      json['data'].forEach((v) {
        data!.add(new GraphData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GraphData {
  int? month;
  int? year;
  double? actual;
  double? target;

  GraphData(
      {
        this.month,
        this.year,
        this.actual,
        this.target});

  GraphData.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    actual = json['actual'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['year'] = this.year;
    data['actual'] = this.actual;
    data['target'] = this.target;
    return data;
  }
}
