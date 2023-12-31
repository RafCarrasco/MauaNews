import 'package:flutter/material.dart';
import 'package:mauanews/utils/colors.dart';

class EditTextFieldWidget extends StatefulWidget {
    final TextEditingController controller;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const EditTextFieldWidget({
    Key? key,
    required this.controller,
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
  Widget build(BuildContext context){
    return Container(
      width: 450,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(color: textColor,fontWeight: FontWeight.normal, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(color:secondTextColor),
            cursorColor: secondTextColor,
            controller: widget.controller,
            decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: textBoxes),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: textBoxes),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            fillColor: textBoxes,
            filled: true,
            hintStyle: TextStyle(color: secondTextColor),
          ),
          ),
        ],
      ),
    );
  }
}