import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_proj/screens/add_task_screen.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../models/task.dart';
import '../utility/utility.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({
    super.key,
    this.tsk,
  });
  final Task? tsk;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  Task? tsk;
  var text1 = FocusNode();
  var text2 = FocusNode();

  int? _selectedTsakTypeItem;

  TextEditingController? taskTitleController;
  TextEditingController? taskBodyController;
  DateTime? dateTime;

  final box = Hive.box<Task>("tasksBox");
  @override
  void initState() {
    super.initState();
    tsk = widget.tsk;

    _selectedTsakTypeItem =
        getTaskTypeList().indexWhere((el) => el.taskEnum == widget.tsk!.taskType.taskEnum);
            dateTime = widget.tsk!.time;
    print(_selectedTsakTypeItem);
    text1.addListener(() {
      setState(() {});
    });
    text1.addListener(() {
      setState(() {});
    });

    taskTitleController = TextEditingController(text: widget.tsk!.title);
    taskBodyController = TextEditingController(text: widget.tsk!.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _getDeveloperInfoBox(),
            getTaskTitleTextField(),
            getTaskBodyTextField(),
            getDatePickerButton(),
            getTimePicker(),
            taskTypeListWrapper(),
            getSaveButton(context),
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
            "dev: Rayehe Tavasoli",
            style: const TextStyle(
              fontFamily: 'sm',
              color: Color(0xff18DAA3),
            ),
            textAlign: TextAlign.center,
          ),
        ),
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
                selectedItemList: _selectedTsakTypeItem!,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getSaveButton(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
      sliver: SliverToBoxAdapter(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff18DAA3),
            minimumSize: Size(200, 48),
          ),
          onPressed: () async {
            await editTask();
            Navigator.pop(context);
          },
          child: Text(
            "ثبت تغییرات تسک",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

Widget getDatePickerButton() {
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
            initialDate: dateTime ?? widget.tsk!.time,
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
              pickedDate!.year,
              pickedDate.month,
              pickedDate.day,
              dateTime?.hour ?? widget.tsk!.time.hour,
              dateTime?.minute ?? widget.tsk!.time.minute,
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


  Widget getTimePicker() {
    return SliverToBoxAdapter(
      child: CustomHourPicker(
        date: widget.tsk!.time, 
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
          widget.tsk!.time = time; 
        },
      ),
    );
  }

  SliverPadding getTaskBodyTextField() {
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

  SliverPadding getTaskTitleTextField() {
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

  Future<void> editTask() async {
    String taskTitle = taskTitleController!.text;
    String taskSubTitle = taskBodyController!.text;

    widget.tsk!.body = taskSubTitle;
    widget.tsk!.title = taskTitle;
    if (dateTime != null) {
    widget.tsk!.time = dateTime!;
  }
    widget.tsk!.taskType = getTaskTypeList()[_selectedTsakTypeItem!];
    await widget.tsk!.save();
  }

  @override
  void dispose() {
    super.dispose();

    text1.dispose();
    text2.dispose();
  }
}
