import 'package:flutter/material.dart';
import 'package:notes_proj/screens/edit_task_screen.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

// ignore: must_be_immutable
class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});
  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Widget getTaskItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.task.isDone = isChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 132,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _getTaskContent(widget.task),
        ),
      ),
    );
  }

  Row _getTaskContent(Task tsk) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      activeColor: Color(0xff18DAA3),
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                          widget.task.isDone = isChecked;
                          widget.task.save();
                        });
                      },
                    ),
                  ),
                  Text(
                    // "تمرین زبان انگلیسی",
                    tsk.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Text(
                // "باید زبان بخونم",
                tsk.body,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
              Spacer(),
              getTaskBadges(),
            ],
          ),
        ),
        SizedBox(width: 20),
        Image.asset(
          tsk.taskType.photo,
          fit: BoxFit.fill,
        ),
      ],
    );
  }

  Row getTaskBadges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xff18DAA3),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
                child: Row(
                  children: [
                    Text(
                        getFormattedDate(widget.task.date),
                        style: TextStyle(
                          color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    getHour(widget.task.time.hour) + ':' + getHour(widget.task.time.minute),  // زمان تسک
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                    SizedBox(width: 10),
                    Image.asset("assets/images/icon_time.png"),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
        Column(
          children: [
            Container(
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xffe2f6f1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 15),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return EditTaskScreen(tsk: widget.task);
                        },
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ویرایش',
                        style: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 12,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                      SizedBox(width: 5),
                      Image.asset("assets/images/icon_edit.png"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  String getFormattedDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}
  String getHour(int hour) {
    return hour < 10 ? '0${hour}' : hour.toString();
  }
}
