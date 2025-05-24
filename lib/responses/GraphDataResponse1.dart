class GraphDataResponse1 {
  List<GraphData1>? data;
  GraphDataResponse1(
      {this.data});

  GraphDataResponse1.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GraphData1>[];
      json['data'].forEach((v) {
        data!.add(new GraphData1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GraphData1 {
  double? achived;
  double? pending;
  double? overachived;
  int? month;

  GraphData1(
      {
        this.achived,
        this.pending,
        this.overachived,
        this.month});
  GraphData1.fromJson(Map<String, dynamic> json) {
    achived = json['achived'];
    pending = json['pending'];
    overachived = json['overachived'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['achived'] = this.achived;
    data['pending'] = this.pending;
    data['overachived'] = this.overachived;
    data['month'] = this.month;
    return data;
  }
}
