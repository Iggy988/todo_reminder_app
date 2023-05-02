// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_reminder_app/controllers/task_controller.dart';
import 'package:todo_reminder_app/ui/theme.dart';
import 'package:todo_reminder_app/ui/widgets/button.dart';
import 'package:todo_reminder_app/ui/widgets/input_field.dart';

import '../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  String _seletedRepeat = 'Nikad';
  List<String> repeatList = [
    'Nikad',
    'Dnevno',
    'Sedmično',
    'Mjesečno',
  ];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Get.isDarkMode ? Colors.black54 : Colors.white,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dodaj napomenu',
                style: headingStyle,
              ),
              MyInputField(
                title: 'Naziv',
                hint: 'Dodaj naziv zadatka',
                controller: _titleController,
              ),
              MyInputField(
                title: 'Zabilješka',
                hint: 'Dodaj zabilješku',
                controller: _noteController,
              ),
              MyInputField(
                title: 'Datum',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: 'Početak',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyInputField(
                      title: 'Kraj',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(
                title: 'Podsjetnik',
                hint: '$_selectedRemind minuta prije',
                widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    underline: Container(
                      height: 0,
                    ),
                    // loop through remindList (return type je string)
                    items:
                        remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRemind = int.parse(newValue!);
                      });
                    }),
              ),
              MyInputField(
                title: 'Ponavljanje',
                hint: _seletedRepeat,
                widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    underline: Container(
                      height: 0,
                    ),
                    // loop through remindList (return type je string)
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value!,
                            style: const TextStyle(color: Colors.grey)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _seletedRepeat = newValue!;
                      });
                    }),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(
                    label: 'Kreiraj',
                    onTap: () => _validateDate(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        'Obavezno',
        'Sva polja su obavezna!',
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(Icons.warning_amber_rounded),
        colorText: Colors.red,
        backgroundColor: Colors.white,
      );
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _seletedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
    print('My id is'+ '$value');
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Boja',
          style: titleStyle,
        ),
        const SizedBox(height: 8),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : yellowClr,
                    child: _selectedColor == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Get.isDarkMode ? Colors.black : Colors.white,
        statusBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
      ),
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/jovana.jpg'),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print('Time canceled');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        //_startTime --> 10:30 AM
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _getDateFromUser() async {
    //kad user izabere date bice snimljen u varijablu
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    } else {}
  }
}
