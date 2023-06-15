import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo/utils/app_style.dart';

class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget({
    super.key,
    required this.iconSection,
    required this.title,
    required this.valueTitle,
    required this.onTap,
  });
  final IconData iconSection;
  final String title;
  final String valueTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: APPStyle.headingOne,
          ),
          Gap(6),
          Material(
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Icon(iconSection),
                      Gap(12),
                      Text(valueTitle),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
