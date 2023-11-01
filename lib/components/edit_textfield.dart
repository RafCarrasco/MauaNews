import 'package:flutter/material.dart';

class EditTextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const EditTextFieldWidget({
    Key? key,
    required this.label,
    required this.text,
    required this.onChanged
  }) : super(key: key);

  @override
  State<EditTextFieldWidget> createState() => _EditTextFieldWidgetState();
}

class _EditTextFieldWidgetState extends State<EditTextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.label,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
      ),
      SizedBox(height: 8),
      TextField(
        controller: controller,
        decoration: InputDecoration(
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
          ),  
        ),
      ),
    ],
  );
}