import 'package:appreposteria/src/other/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingAlertDialog extends StatelessWidget
{
  final String message;
  const LoadingAlertDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {

      return AlertDialog(
      key: key,
      content: Text(message,textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold)),
      actions: [  
            CircularProgressIndicator(
              backgroundColor: AppColors.kCategorypinkColor,
            ),      ],
    );

  }
}