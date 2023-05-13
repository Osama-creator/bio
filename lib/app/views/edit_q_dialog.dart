// import 'package:bio/app/data/models/question_model.dart';
// import 'package:bio/app/views/text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class EditQuestionDialog extends StatelessWidget {
//   final Question initialQuestion;
//   final bool isNew;
//   final Function(Question) onSubmit;

//   const EditQuestionDialog({
//     Key? key,
//     required this.initialQuestion,
//     required this.isNew,
//     required this.onSubmit,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController questionController =
//         TextEditingController(text: initialQuestion.question ?? '');
//     TextEditingController rightAnswerController =
//         TextEditingController(text: initialQuestion.rightAnswer ?? '');
//     TextEditingController wrongAnswer1Controller =
//         TextEditingController(text: initialQuestion.wrongAnswers?[0] ?? '');
//     TextEditingController wrongAnswer2Controller =
//         TextEditingController(text: initialQuestion.wrongAnswers?[1] ?? '');
//     TextEditingController wrongAnswer3Controller =
//         TextEditingController(text: initialQuestion.wrongAnswers?[2] ?? '');

//     return AlertDialog(
//       title: Text(isNew ? 'Add Question' : 'Edit Question'),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(
//               width: context.width * 0.8,
//               child: MyTextFeild(
//                 controller: questionController,
//                 hintText: "السؤال",
//                 labelText: "السؤال",
//               ),
//             ),
//             MyTextFeild(
//               labelText: "الإجابه الصحيحه",
//               controller: rightAnswerController,
//               hintText: "الإجابه الصحيحه",
//             ),
//             MyTextFeild(
//               controller: wrongAnswer1Controller,
//               labelText: "الإجابه الخاطئه 1",
//               hintText: "الإجابه الخاطئه 1",
//             ),
//             MyTextFeild(
//               controller: wrongAnswer2Controller,
//               labelText: "الإجابه الخاطئه 2",
//               hintText: "الإجابه الخاطئه 2",
//             ),
//             MyTextFeild(
//               controller: wrongAnswer3Controller,
//               labelText: "الإجابه الخاطئه 3",
//               hintText: "الإجابه الخاطئه 3",
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context, false);
//           },
//           child: const Text('الغاء'),
//         ),
//         TextButton(
//           onPressed: () {
//             Question newQuestion = Question(
//               id: initialQuestion.id ?? '',
//               question: questionController.text,
//               rightAnswer: rightAnswerController.text,
//               wrongAnswers: [
//                 wrongAnswer1Controller.text,
//                 wrongAnswer2Controller.text,
//                 wrongAnswer3Controller.text,
//               ],
//             );
//             onSubmit(newQuestion);
//             Navigator.pop(context, true);
//           },
//           child: Text(isNew ? 'Add' : 'Save'),
//         ),
//       ],
//     );
//   }
// }
