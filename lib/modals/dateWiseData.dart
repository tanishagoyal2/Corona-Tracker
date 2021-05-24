class DateWiseData{
  var totalCases1;
  var deaths1;
  var recovered1;
  var critical1;

  /*var totalCases2;
  var deaths2;
  var recovered2;
  var critical2;

  var totalCases3;
  var deaths3;
  var recovered3;
  var critical3;

  var totalCases4;
  var deaths4;
  var recovered4;
  var critical4;

  var totalCases5;
  var deaths5;
  var recovered5;
  var critical5;
*/
  //DateWiseData({this.totalCases1,this.deaths1,this.recovered1,this.critical1,this.totalCases2,this.deaths2,this.recovered2,this.critical2,this.totalCases3,this.deaths3,this.recovered3,this.critical3,this.totalCases4,this.deaths4,this.recovered4,this.critical4,this.totalCases5,this.deaths5,this.recovered5,this.critical5});
  DateWiseData({this.totalCases1,this.deaths1,this.recovered1,this.critical1});

factory DateWiseData.fromJson(Map<String,dynamic> json)=>DateWiseData(
  totalCases1:json['total_cases'],
  deaths1:json['deaths'],
  recovered1:json['recovered'],
  critical1:json['critical'],
);
  /*DateWiseData(List list1){
    totalCases1=list1[0]['total_cases'];
    deaths1=list1[0]['deaths'];
    recovered1=list1[0]['recovered'];
    critical1=list1[0]['critical'];
    totalCases2=list1[1]['total_cases'];
    deaths2=list1[1]['deaths'];
    recovered2=list1[1]['recovered'];
    critical2=list1[1]['critical'];
  }*/
}