import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist_project/models/task_type.dart';

part "task.g.dart";

@HiveType(typeId: 4)
class Task extends HiveObject {
  Task({
    this.key, // اضافه کردن شناسه برای مدیریت بهتر
    required this.title,
    required this.body,
    required this.isDone,
    required this.date,
    required this.time,
    required this.taskType,
  });

  @HiveField(6)
  int? key; // فیلد key که به درستی تعریف شده است.

  @HiveField(0)
  String title;

  @HiveField(1)
  String body;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  DateTime time;

  @HiveField(5)
  TaskType taskType;

  // اضافه کردن متد copyWith
  Task copyWith({
    int? key,
    String? title,
    String? body,
    bool? isDone,
    DateTime? date,
    DateTime? time,
    TaskType? taskType,
  }) {
    return Task(
      key: this.key, // حفظ شناسه اصلی برای مدیریت داده‌ها
      title: title ?? this.title,
      body: body ?? this.body,
      isDone: isDone ?? this.isDone,
      date: date ?? this.date,
      time: time ?? this.time,
      taskType: taskType ?? this.taskType,
    );
  }
}
