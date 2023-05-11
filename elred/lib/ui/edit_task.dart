import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/task_model.dart';

class EditTaskPage extends StatefulWidget {
  final User user;
  final Task task;

  const EditTaskPage(this.user, this.task, {super.key});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    nameController.text = widget.task.name;
    descriptionController.text = widget.task.description;
    _selectedDate = widget.task.date;
    super.initState();
  }

  void _updateTask() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance
          .collection('tasks')
          .doc(widget.task.id)
          .update({
        'name': nameController.text,
        'description': descriptionController.text,
        'date': _selectedDate,
      });
      Navigator.pop(context);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null && selectedDate != _selectedDate) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E3191),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3191),
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                  labelStyle: TextStyle(color: Colors.white60),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task name';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    labelText: 'Task Description',
                    labelStyle: TextStyle(color: Colors.white60)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task description';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Task Date: ${DateFormat.yMd().format(_selectedDate)}',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateTask,
                child: const Text('Update Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
