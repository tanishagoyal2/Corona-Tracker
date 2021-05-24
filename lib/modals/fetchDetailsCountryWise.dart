import 'package:get/get.dart';

class FetchDetails {
  var country;
  var statusCode;
  var type;
  var data = [];
  var stotal_cases;
  var sactive_cases;
  var sdeaths;
  var srecovered;
  var scritical;
  var stested;
  var sdeath_ratio;
  var srecovery_ratio;

  var ctotal_cases;
  var cactive_cases;
  var cdeaths;
  var crecovered;
  var ccritical;
  var ctested;
  var cdeath_ratio;
  var crecovery_ratio;


  FetchDetails(
      {this.country,
      this.statusCode,
      this.type,
      this.data,
      this.sactive_cases,
      this.scritical,
      this.sdeath_ratio,
      this.sdeaths,
      this.srecovered,
      this.srecovery_ratio,
      this.stested,
      this.stotal_cases,
        this.cactive_cases,
        this.ccritical,
        this.cdeath_ratio,
        this.cdeaths,
        this.crecovered,
        this.crecovery_ratio,
        this.ctested,
        this.ctotal_cases
      });

  factory FetchDetails.fromJson(Map<String, dynamic> json) => FetchDetails(
      statusCode: json['status'],
      type: json['type'],
      sactive_cases: json['data']['summary']['active_cases'],
      stotal_cases: json['data']['summary']['total_cases'],
      sdeaths: json['data']['summary']['deaths'],
      srecovered: json['data']['summary']['recovered'],
      scritical: json['data']['summary']['critical'],
      stested: json['data']['summary']['tested'],
      sdeath_ratio: json['data']['summary']['death_ratio'],
      srecovery_ratio: json['data']['summary']['recovery_ratio'],

    cactive_cases: json['data']['change']['active_cases'],
    ctotal_cases: json['data']['change']['total_cases'],
    cdeaths: json['data']['change']['deaths'],
    crecovered: json['data']['change']['recovered'],
    ccritical: json['data']['change']['critical'],
    ctested: json['data']['change']['tested'],
    cdeath_ratio: json['data']['change']['death_ratio'],
    crecovery_ratio: json['data']['change']['recovery_ratio'],
  );
}
