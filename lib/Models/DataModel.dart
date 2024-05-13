
import 'package:hive/hive.dart';
part 'DataModel.g.dart';

@HiveType(typeId: 0)
class DataModel extends HiveObject{
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? father_name;
  @HiveField(2)
  int? age;
  @HiveField(3)
  String? university;
  @HiveField(4)
  String? degree;
  @HiveField(5)
  double? cgpa;
  DataModel({required this.name,required this.father_name,required this.age,required this.university,required this.degree,required this.cgpa});

}