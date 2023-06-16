import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../provider/service_provider.dart';
import '../utils/app_style.dart';

class CardTodoWidget extends ConsumerWidget {
  const CardTodoWidget({
    super.key,
    required this.getIndex,
  });
  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);

    return todoData.when(
      data: (todoData) {
        final getCategory = todoData[getIndex].category;
        Color categoryColor = Colors.white;
        switch (getCategory) {
          case 'Learning':
            categoryColor = Colors.green;

            break;
          case 'Working':
            categoryColor = Colors.blue.shade700;
            break;
          case 'General':
            categoryColor = Colors.amber.shade700;
            break;
        }
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                width: 30,
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: IconButton(
                            onPressed: () {
                              ref.read(serviceProvider).deleteTask(
                                    todoData[getIndex].docId,
                                  );
                            },
                            icon: Icon(Icons.delete),
                          ),
                          title: Text(todoData[getIndex].titleTask,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: todoData[getIndex].isDone
                                      ? TextDecoration.lineThrough
                                      : null)),
                          subtitle: Text(todoData[getIndex].description,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey)),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.blue,
                              shape: CircleBorder(),
                              value: todoData[getIndex].isDone,
                              onChanged: (value) {
                                return ref.read(serviceProvider).updateTask(
                                    todoData[getIndex].docId, value);
                              },
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -12),
                          child: Container(
                            child: Column(
                              children: [
                                Divider(
                                  thickness: 1.5,
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Day',
                            ),
                            Gap(12),
                            Text(todoData[getIndex].dateTask),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
        );
      },
      error: (error, stack) => Text(error.toString()),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
