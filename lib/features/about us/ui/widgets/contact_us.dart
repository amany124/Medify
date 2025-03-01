import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_styles.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xffcbe7f5),
            //Colors.blue[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Contact Us',
            style: AppStyles.bold22.copyWith(
              color: Colors.black,
            ),
          ),
        ),
        const Gap(3),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blue,
                ),
              ),
              const Gap(10),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.green,
                ),
              ),
              const Gap(10),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.envelope,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}