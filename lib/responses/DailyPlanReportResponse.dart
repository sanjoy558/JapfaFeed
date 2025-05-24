class DailyPlanReportResponse {
  String? totalCustomers;
  String? totalVisitedCustomers;
  String? totalCancelCustomers;
  String? visitDate;

  DailyPlanReportResponse(
      {
        this.totalCustomers,
        this.totalVisitedCustomers,
        this.totalCancelCustomers,
        this.visitDate});

  DailyPlanReportResponse.fromJson(Map<String, dynamic> json) {
    totalCustomers = json['totalCustomers'];
    totalVisitedCustomers = json['totalVisitedCustomers'];
    totalCancelCustomers = json['totalCancelCustomers'];
    visitDate = json['visitDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCustomers'] = this.totalCustomers;
    data['totalVisitedCustomers'] = this.totalVisitedCustomers;
    data['totalCancelCustomers'] = this.totalCancelCustomers;
    data['visitDate'] = this.visitDate;
    return data;
  }
}
