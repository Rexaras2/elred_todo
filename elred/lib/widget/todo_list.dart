import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/task_model.dart';
import '../ui/edit_task.dart';

class TodoList extends StatelessWidget {
  final User user;

  const TodoList(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('tasks')
          .where('userId', isEqualTo: user.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Task> list = snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          return Task.fromMap(data, document.id);
        }).toList();

        return ListView.separated(
          itemCount: list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.ac_unit,
                            color: Colors.blue,
                            size: 40,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(list[index].description),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditTaskPage(user, list[index]),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_sweep_outlined,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete task?'),
                                  content: const Text(
                                      'This action cannot be undone.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('tasks')
                                            .doc(list[index].id)
                                            .delete();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
        );
      },
    );
  }
}
