import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist_project/screens/add_task_screen.dart';
import '../models/task.dart';
import '../widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isChecked = false;
  bool isFabVisible = true;

  final box = Hive.box<Task>("tasksBox");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            );
          },
          child: Image.asset("assets/images/icon_add.png"),
          backgroundColor: Color(0xff18DAA3),
        ),
      ),
      backgroundColor: Color(0xffe5e5e5),
      body: _getBody(context),
    );
  }

  Widget _getBody(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, value, child) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            setState(() {
              if (notification.direction == ScrollDirection.forward) {
                isFabVisible = true;
              }
              if (notification.direction == ScrollDirection.reverse) {
                isFabVisible = false;
              }
            });
            return true;
          },
          child: ListView.builder(
            itemBuilder: (context, index) {
              var task = value.values.toList()[index];
              return getListItem(task);
            },
            itemCount: value.values.toList().length,
          ),
        );
      },
    );
  }

  Widget getListItem(Task tsk) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        tsk.delete();
      },
      child: TaskWidget(
        task: tsk,
      ),
    );
  }
}
