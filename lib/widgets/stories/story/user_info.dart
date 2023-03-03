import 'package:flutter/material.dart';

import '../../../shared/images/images.dart';
import 'models/user_model.dart';

class UserInfo extends StatelessWidget {
  final User user;

  const UserInfo({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 40,width: 40,
          decoration:const BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(Images.story),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            user.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}