import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo/provider/service_provider.dart';

import '../common/show_model.dart';
import '../widgets/card_tod_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade100,
            radius: 25,
            child: Image(image: AssetImage('assets/profile.png')),
          ),
          title: Text(
            'Hello Im',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          subtitle: Text(
            "Beka",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.calendar_month),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notification_add),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today is Task',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Wednesday 11 May',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        context: context,
                        builder: (context) => AddNewTaskModel()),
                    child: Text(
                      '+ New Task',
                      style: TextStyle(color: Colors.grey),
                    )),
              ],
            ),
            Gap(20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: todoData.value!.length,
              itemBuilder: (BuildContext context, int index) {
                return CardTodoWidget(
                  getIndex: index,
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
