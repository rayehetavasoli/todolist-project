import 'package:notes_proj/models/task_type.dart';
import 'package:notes_proj/models/type_enum.dart';

List<TaskType> getTaskTypeList() {
  return [
    TaskType(
      name: "کار مالی",
      photo: "assets/images/banking.png",
      taskEnum: TaskEnum.banking,
    ),
    TaskType(
      name: "کار اداری",
      photo: "assets/images/hard_working.png",
      taskEnum: TaskEnum.working,
    ),
    TaskType(
      name: "مدیتیشن",
      photo: "assets/images/meditate.png",
      taskEnum: TaskEnum.focusing,
    ),
    TaskType(
      name: "قرار دوستانه",
      photo: "assets/images/social_frends.png",
      taskEnum: TaskEnum.commuting,
    ),
    TaskType(
      name: "دیت",
      photo: "assets/images/work_meeting.png",
      taskEnum: TaskEnum.dating,
    ),
    TaskType(
      name: "ورزش",
      photo: "assets/images/workout.png",
      taskEnum: TaskEnum.training,
    ),
  ];
}
