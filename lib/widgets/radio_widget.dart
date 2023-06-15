import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget({
    required this.onChangedValue,
    super.key,
    required this.titleRadio,
    required this.cteColor,
    required this.valueInput,
  });
  final String titleRadio;
  final Color cteColor;
  final int valueInput;
  final VoidCallback onChangedValue;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(radioProvider);
    return Theme(
      data: ThemeData(unselectedWidgetColor: cteColor),
      child: RadioListTile(
        activeColor: cteColor,
        contentPadding: EdgeInsets.zero,
        title: Transform.translate(
            offset: Offset(-22, 0),
            child: Text(
              titleRadio,
              style: TextStyle(color: cteColor, fontWeight: FontWeight.w700),
            )),
        value: valueInput,
        groupValue: radio,
        onChanged: (value) => onChangedValue(),
      ),
    );
  }
}
