import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist_project/models/type_enum.dart';

part 'task_type.g.dart';

@HiveType(typeId: 5)
class TaskType {
  TaskType({
    required this.name,
    required this.photo,
    required this.taskEnum,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String photo;

  @HiveField(2)
  TaskEnum taskEnum;
}
