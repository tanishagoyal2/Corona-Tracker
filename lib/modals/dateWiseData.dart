class DateWiseData{
  var totalCases1;
  var deaths1;
  var recovered1;
  var critical1;
  DateWiseData({this.totalCases1,this.deaths1,this.recovered1,this.critical1});

factory DateWiseData.fromJson(Map<String,dynamic> json)=>DateWiseData(
  totalCases1:json['total_cases'],
  deaths1:json['deaths'],
  recovered1:json['recovered'],
  critical1:json['critical'],
);
}