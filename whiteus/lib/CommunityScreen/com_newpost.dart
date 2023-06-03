import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewPost extends StatelessWidget {
  final String name;
  const NewPost({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final textController = TextEditingController();

    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height / 3 + bottomInset,
      color: Colors.white,
      child: Padding(
        padding:
            EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottomInset),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: TextField(
              controller: textController,
              expands: true,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Write Your contents!',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                filled: true,
                fillColor: Colors.black38,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance.collection('Community').add({
                    'name': name,
                    'time':
                        "${DateTime.now().year}년 ${DateTime.now().month}월 ${DateTime.now().day}일",
                    'contents': textController.text,
                    'recommendNum': 0,
                    'recommendList': <String>[],
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: const Text("Upload")),
          ),
          const SizedBox(
            height: 10,
          )
        ]),
      ),
    ));
  }
}
