import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  final User user;

  const AddTaskPage(this.user, {super.key});

  @override
  AddTaskPageState createState() => AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addTask() {
    FirebaseFirestore.instance.collection('tasks').add({
      'userId': widget.user.uid,
      'name': nameController.text,
      'description': descriptionController.text,
      'date': _selectedDate,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E3191),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 22,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.blue,
                        size: 25,
                      ),
                    ),
                    const Text(
                      'Add New task',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Icon(
                      Icons.menu_open_sharp,
                      color: Colors.blue,
                      size: 25,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 32,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.design_services_outlined,
                      color: Colors.blue,
                      size: 35,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Task name',
                          labelStyle: TextStyle(color: Colors.white60)),
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.white60)),
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Due date: ${DateFormat('dd MMM yyyy').format(_selectedDate)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: const Text('Select date'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _addTask,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('Add task'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
