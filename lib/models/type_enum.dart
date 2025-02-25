import 'package:hive_flutter/hive_flutter.dart';

part 'type_enum.g.dart';

@HiveType(typeId: 6)
enum TaskEnum {
  @HiveField(0)
  banking,
  @HiveField(1)
  working,
  @HiveField(2)
  focusing,
  @HiveField(3)
  commuting,
  @HiveField(4)
  dating,
  @HiveField(5)
  training,
}
