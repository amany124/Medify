import 'package:flutter/material.dart';
import 'package:medify/features/chat/ui/widgets/customPrefixIcon.dart';
import 'package:medify/features/chat/ui/widgets/custumCircleButton.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: 290,
              height: 58,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1.5,
                    blurRadius: 1,
                    offset: const Offset(
                        3, 4), // changes the position of the shadow
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 5),
                child: TextField(
                  //textAlign: TextAlign.justify,
                  decoration: InputDecoration(
                    prefixIcon: customPrefixIcon(),
                    hintText: 'Type your message here ...',
                    hintStyle: TextStyle(
                      fontSize: 18,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        custumCircleButton(),
      ],
    );
  }
}
