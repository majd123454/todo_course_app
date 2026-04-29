import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tasks');
    if (data != null) {
      final List decoded = jsonDecode(data);
      setState(() {
        tasks = decoded.map((t) {
          print(t);
          final timeParts = (t['time'] as String).split(':');
          return Task(
            title: t['title'],
            description: t['description'],
            date: DateTime.parse(t['date']),
            time: TimeOfDay(
              hour: int.parse(timeParts[0]),
              minute: int.parse(timeParts[1]),
            ),
          );
        }).toList();

        print(tasks);
      });
    }
  }

  bool secure = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff63D9F3),
        onPressed: () {
          final TextEditingController titleController = TextEditingController();
          final TextEditingController descController = TextEditingController();
          DateTime? selectedDate;
          TimeOfDay? selectedTime;

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Create New Task',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: titleController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Color(0xff05243E),
                              filled: true,
                              labelText: 'Task Title',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: descController,
                            maxLines: 4,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Color(0xff05243E),
                              filled: true,
                              labelText: 'Description',
                              labelStyle: TextStyle(color: Colors.white),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                          context: context,
                                          initialDate:
                                              selectedDate ?? DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 1000),
                                          ),
                                        );
                                    if (picked != null) {
                                      setModalState(() {
                                        selectedDate = picked;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.calendar_today),
                                  label: Text(
                                    selectedDate == null
                                        ? 'Pick Date'
                                        : DateFormat(
                                            'yyyy/MM/dd',
                                          ).format(selectedDate!),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff1253AA),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final TimeOfDay? pickedTime =
                                        await showTimePicker(
                                          context: context,
                                          initialTime:
                                              selectedTime ?? TimeOfDay.now(),
                                        );
                                    if (pickedTime != null) {
                                      setModalState(() {
                                        selectedTime = pickedTime;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.access_time),
                                  label: Text(
                                    selectedTime == null
                                        ? 'Pick Time'
                                        : selectedTime!.format(context),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff1253AA),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.grey),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Cancel'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (titleController.text.isNotEmpty &&
                                        descController.text.isNotEmpty &&
                                        selectedDate != null &&
                                        selectedTime != null) {
                                      setState(() {
                                        tasks.add(
                                          Task(
                                            title: titleController.text,
                                            description: descController.text,
                                            date: selectedDate!,
                                            time: selectedTime!,
                                          ),
                                        );
                                      });
                                      // saveTasks(tasks);
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Please fill all fields!',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff63D9F3),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Create'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),

      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topEnd,
            end: AlignmentDirectional.bottomStart,
            colors: [Color(0xff1253AA), Color(0xff05243E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: controller,
                        style: TextStyle(color: Colors.white),
                        obscureText: secure,
                        decoration: InputDecoration(
                          hintText: "search for tasks",
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(Icons.search, color: Colors.white),
                          fillColor: Color(0xff05243E).withOpacity(0.6),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff05243E).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 5,
                          ),
                          child: DropdownButton(
                            value: "1",
                            underline: SizedBox.shrink(),
                            style: TextStyle(color: Colors.amber, fontSize: 16),
                            items: [
                              DropdownMenuItem(
                                child: Text("All Tasks"),
                                value: "1",
                              ),
                              DropdownMenuItem(
                                child: Text("Completed"),
                                value: "completed",
                              ),
                              DropdownMenuItem(
                                child: Text("Pending"),
                                value: "pending",
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 46),
              Text(
                "Tasks List",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: tasks.isEmpty
                    ? const Center(
                        child: Text(
                          'No tasks yet',
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${DateFormat('yyyy-MM-dd').format(task.date)} | ${task.time.format(context)}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemCount: tasks.length,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTaskItem(Task task) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "${task.time.hour}:${task.time.minute} AM - ${task.time.hour + 1}:${task.time.minute} AM",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}

Future<void> saveTasks(List<Task> tasks) async {
  final prefs = await SharedPreferences.getInstance();
  final taskList = tasks
      .map(
        (task) => {
          'title': task.title,
          'description': task.description,
          'date': task.date.toIso8601String(),
          'time': '${task.time.hour}:${task.time.minute}',
        },
      )
      .toList();

  await prefs.setString('tasks', jsonEncode(taskList));
}

class Task {
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  String? x;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.x,
  });
}
