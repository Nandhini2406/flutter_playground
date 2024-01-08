import 'package:flutter/material.dart';
import 'package:flutter_playground/customWidgets/styledText.dart';

class ResultSummary extends StatelessWidget {
  const ResultSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;
  get textSize => 16.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: summaryData.map((data) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 9, 141, 127),
                        shape: BoxShape.circle,
                      ),
                      child: StyledText(
                        ((data['question_index'] as int) + 1).toString(),
                        textColor: Colors.black,
                        textSize: 16.0,
                        textAlign: TextAlign.start,
                        textWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StyledText(
                            data['question'] as String,
                            textColor: Colors.black87,
                            textSize: textSize,
                            textWeight: FontWeight.w600,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 4),
                          StyledText(
                            data['user_answer'] as String,
                            textColor: const Color.fromARGB(255, 255, 0, 89),
                            textSize: textSize,
                            textWeight: FontWeight.w400,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 4),
                          StyledText(
                            data['correct_answer'] as String,
                            textColor: const Color.fromARGB(255, 7, 231, 209),
                            textSize: textSize,
                            textWeight: FontWeight.w400,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    data['user_answer'] == data['correct_answer']
                        ? const Icon(
                            Icons.thumb_up_alt,
                            color: Colors.green,
                            size: 30.0,
                          )
                        : const Icon(
                            Icons.thumb_down_sharp,
                            color: Colors.red,
                            size: 27.0,
                          ),
                  ],
                );
              }).toList()),
        ),
      ),
    );
  }
}
