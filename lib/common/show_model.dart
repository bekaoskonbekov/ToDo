import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/provider/service_provider.dart';
import 'package:todo/utils/app_style.dart';
import 'package:todo/widgets/date_time_widgte.dart';
import 'package:todo/widgets/radio_widget.dart';

import '../provider/date_time_provider.dart';
import '../provider/radio_provider.dart';
import '../widgets/textfield_widget.dart';

class AddNewTaskModel extends ConsumerStatefulWidget {
  const AddNewTaskModel({
    super.key,
  });

  @override
  ConsumerState<AddNewTaskModel> createState() => _AddNewTaskModelState();
}

class _AddNewTaskModelState extends ConsumerState<AddNewTaskModel> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final datProvider = ref.watch(dateProvider);
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'New Task Todo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              thickness: 1.2,
              color: Colors.grey.shade200,
            ),
            Gap(6),
            Text('Title task', style: APPStyle.headingOne),
            TextFieldWidget(
              hintText: 'Add Task Name',
              maxLines: 1,
              txtController: titleController,
            ),
            Gap(12),
            Text('Description', style: APPStyle.headingOne),
            TextFieldWidget(
              hintText: 'Add Descriptions',
              maxLines: 5,
              txtController: descriptionController,
            ),
            const Gap(12),
            Text('Category', style: APPStyle.headingOne),
            Row(
              children: [
                Expanded(
                  child: RadioWidget(
                    cteColor: Colors.green,
                    titleRadio: 'LRN',
                    valueInput: 1,
                    onChangedValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 1),
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    cteColor: Colors.blue,
                    titleRadio: 'WRK',
                    valueInput: 2,
                    onChangedValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 2),
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    cteColor: Colors.amberAccent,
                    titleRadio: 'GEN',
                    valueInput: 3,
                    onChangedValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 3),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DateTimeWidget(
                  iconSection: CupertinoIcons.calendar,
                  title: 'Date',
                  valueTitle: datProvider,
                  onTap: () async {
                    final getValue = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2025));
                    if (getValue != null) {
                      final format = DateFormat.yMd();
                      ref.read(dateProvider.notifier).update((state) {
                        return format.format(getValue);
                      });
                    }
                  },
                ),
                DateTimeWidget(
                  iconSection: CupertinoIcons.time,
                  title: 'Time',
                  valueTitle: ref.watch(timeProvider),
                  onTap: () async {
                    final getTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (getTime != null) {
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => getTime.format(context));
                    }
                  },
                ),
              ],
            ),
            Gap(20),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue.shade800,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.blue.shade800),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 14)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancle'))),
                Gap(20),
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.blue.shade800),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 14)),
                        onPressed: () {
                          final getRadioValue = ref.read(radioProvider);
                          String category = '';
                          switch (getRadioValue) {
                            case 1:
                              category = 'Learning';
                              break;
                            case 2:
                              category = 'Working';
                              break;
                            case 3:
                              category = 'General';
                          }

                          ref.read(serviceProvider).addNewTask(TodoModel(
                              titleTask: titleController.text,
                              description: descriptionController.text,
                              dateTask: ref.read(dateProvider),
                              timeTask: ref.read(timeProvider),
                              category: category,
                              isDone: false));
                          print('DAte');
                          titleController.clear();
                          descriptionController.clear();
                          ref.read(radioProvider.notifier).update((state) => 0);
                          Navigator.pop(context);
                        },
                        child: Text('Create'))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
