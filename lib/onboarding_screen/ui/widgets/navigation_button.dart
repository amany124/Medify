import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.arrow_back,
          //     color: Colors.blue,
          //   ),
          // ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff0062ff),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              child: Row(
                children: [
                  Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Gap(6),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
