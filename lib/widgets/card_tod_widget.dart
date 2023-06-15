import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../provider/service_provider.dart';

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
        return Container(
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
                  color: Colors.red,
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
                          title: Text(todoData[getIndex].titleTask),
                          subtitle: Text(todoData[getIndex].description),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.blue,
                              shape: CircleBorder(),
                              value: todoData[getIndex].isDone,
                              onChanged: (value) {},
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
                            Text('Today'),
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
