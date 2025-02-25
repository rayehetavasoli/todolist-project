import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_proj/utility/utility.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:notes_proj/services/notification_service.dart';
import '../models/task.dart';
import '../models/task_type.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var text1 = FocusNode();
  var text2 = FocusNode();

  final taskTitleController = new TextEditingController();
  final taskBodyController = new TextEditingController();

  int _selectedTsakTypeItem = 0;

  DateTime? dateTime = DateTime.now();
  DateTime? pickedDate;
  final box = Hive.box<Task>("tasksBox");
  @override
  void initState() {
    super.initState();
    text1.addListener(() {
      setState(() {});
    });
    text1.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _getDeveloperInfoBox(),
            taskTitleTextField(),
            taskBodyTextField(),
            datePickerButton(),
            timePicker(),
            taskTypeListWrapper(),
            addTaskButton(context),
          ],
        ),
      ),
    );
  }

  SliverPadding _getDeveloperInfoBox() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            "dev: Rayehe Tavasoli"
             ,style: const TextStyle(
              fontFamily: 'sm',
              color: Color(0xff18DAA3),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      )
    );
  }

  SliverPadding taskTitleTextField() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            controller: taskTitleController,
            focusNode: text1,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'GB',
            ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 3.0,
                  color: Color(0xff18DAA3),
                ),
              ),
              contentPadding: EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 3.0,
                  color: Color(0xffC5C5C5),
                ),
              ),
              labelText: 'عنوان تسک',
              labelStyle: TextStyle(
                color: text1.hasFocus ? Color(0xff18DAA3) : Color(0xffC5C5C5),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'GB',
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverPadding taskBodyTextField() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverToBoxAdapter(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            controller: taskBodyController,
            focusNode: text2,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'GB',
            ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 3.0,
                  color: Color(0xff18DAA3),
                ),
              ),
              contentPadding: EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 3.0,
                  color: Color(0xffC5C5C5),
                ),
              ),
              labelText: 'متن تسک',
              labelStyle: TextStyle(
                color: text2.hasFocus ? Color(0xff18DAA3) : Color(0xffC5C5C5),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'GB',
              ),
            ),
            minLines: 2,
            maxLines: 3,
          ),
        ),
      ),
    );
  }

  Widget datePickerButton() {
  return SliverToBoxAdapter(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff18DAA3),
          minimumSize: Size(200, 48),
        ),
        onPressed: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: dateTime ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Color(0xff18DAA3), // رنگ اصلی
                    onPrimary: Colors.white, // رنگ نوشته‌ها
                    surface: Colors.white,
                  ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child!,
              );
            },
          );

          setState(() {
            dateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              dateTime?.hour ?? 0,
              dateTime?.minute ?? 0,
            );
          });
                },
        child: Text(
          dateTime == null
              ? "انتخاب تاریخ"
              : "تاریخ انتخاب شده: ${dateTime!.year}/${dateTime!.month}/${dateTime!.day}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}


  Widget timePicker() {
    return SliverToBoxAdapter(
      child: CustomHourPicker(
        title: 'زمان تسک رو انتخاب کن',
        titleStyle: TextStyle(
          color: Color(0xff18DAA3),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        negativeButtonText: "لغو کن",
        negativeButtonStyle: TextStyle(
          color: Color.fromARGB(255, 205, 13, 13),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        positiveButtonText: "انتخاب زمان",
        positiveButtonStyle: TextStyle(
          color: Color(0xff18DAA3),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        elevation: 2,
        onNegativePressed: (context) {},
        onPositivePressed: (context, time) {
          dateTime = time;
        },
      ),
    );
  }

  Widget taskTypeListWrapper() {
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        margin: EdgeInsets.only(left: 20, right: 15),
        child: ListView.builder(
          itemCount: getTaskTypeList().length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedTsakTypeItem = index;
                });
              },
              child: TaskTypeItem(
                taskType: getTaskTypeList()[index],
                index: index,
                selectedItemList: _selectedTsakTypeItem,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget addTaskButton(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
      sliver: SliverToBoxAdapter(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff18DAA3),
            minimumSize: Size(200, 48),
          ),
          onPressed: () async {
            await addTask();
            Navigator.pop(context);
          },
          child: Text(
            "اضافه کردن تسک",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
void scheduleTaskNotification(Task task) {
  NotificationService().scheduleNotification(
    task.key ?? 0, // شناسه نوتیفیکیشن
    task.title,
    task.body,
    task.time, // زمانی که کاربر انتخاب کرده
  );
}

  Future<void> addTask() async {
    if (dateTime == null) {
      return;
    }
    String taskTitle = taskTitleController.text;
    String taskSubTitle = taskBodyController.text;

    var task = Task(
      
      title: taskTitle,
      body: taskSubTitle,
      isDone: false,
      date: pickedDate!, 
      time: dateTime!,
      taskType: getTaskTypeList()[_selectedTsakTypeItem],
    );

    int? taskKey = await box.add(task); 
    scheduleTaskNotification(task.copyWith(key: taskKey));
  }

  @override
  void dispose() {
    super.dispose();

    text1.dispose();
    text2.dispose();
  }
}

class TaskTypeItem extends StatelessWidget {
  TaskTypeItem({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectedItemList,
  });

  final TaskType taskType;
  final int index;
  final int selectedItemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: selectedItemList == index ? 3 : 0.5,
          color: selectedItemList == index ? Color(0xff18DAA3) : Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            taskType.photo,
            fit: BoxFit.cover,
          ),
          Text(
            taskType.name,
            style: TextStyle(
              color: selectedItemList == index ? Color(0xff18DAA3) : Colors.black,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}