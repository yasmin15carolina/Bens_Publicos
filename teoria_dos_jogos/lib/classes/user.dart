import 'package:fl_chart/fl_chart.dart';

class User {
  var id;
  var name;
  var age;
  var gender;
  var cours;
  var imgPath;
  var educationLevel;
  var occupation;
  var experiment;
  var device;
  DateTime? start;

  List<FlSpot> cooperateList = [];
  List<FlSpot> defectList = [];

  User(
      {this.name,
      this.age,
      this.cours,
      this.gender,
      this.imgPath,
      this.educationLevel,
      this.occupation});
}
