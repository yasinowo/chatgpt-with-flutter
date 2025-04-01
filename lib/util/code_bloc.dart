import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart'; // برای کپی کردن متن

class CodeBlock extends StatelessWidget {
  final String code;

  const CodeBlock({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          // color: Colors.grey[200], // رنگ پس‌زمینه بلاک کد
          child: Text(code),
        ),
        ElevatedButton(
          onPressed: () {
            FlutterClipboard.copy(code); // کپی کردن کد
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('کد کپی شد')),
            );
          },
          child: Text('کپی کد'),
        ),
      ],
    );
  }
}
