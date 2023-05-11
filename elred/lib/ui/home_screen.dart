import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widget/snackbar.dart';
import 'add_task_screen.dart';
import '../main.dart';
import '../widget/todo_list.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAfoNp7XOcoPrIHQlZNhOdizjyji2WFVEipA&usqp=CAU',
                  ),
                  fit: BoxFit.fill,
                )),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 1,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 8.0, left: 20, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.menu_sharp,
                            color: Colors.white,
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, bottom: 25, right: 8, top: 15),
                            child: GestureDetector(
                                onTap: () async {
                                  await auth.signOut();
                                  await googleSignIn.signOut();
                                  snackBar('successfully logout', context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Row(
                                      children: const [
                                        Text(
                                          'Sign Out ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.design_services_outlined,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Your',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 35),
                              ),
                              Text(
                                'Tasks',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 35),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                '24',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 35),
                              ),
                              Text(
                                'Personal',
                                style: TextStyle(
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                '15',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 35),
                              ),
                              Text(
                                'Business',
                                style: TextStyle(
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'March 16, 2023',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '65% done',
                            style: TextStyle(
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text('INBOX'),
            ),
            Expanded(child: SingleChildScrollView(child: TodoList(user))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        tooltip: 'Add Task',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage(user)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
