import 'package:flutter/material.dart';

import '../../../../../common/common.dart';

class ChangeUserInfoDialog extends StatefulWidget {
  final String dataInit;
  final String title;
  const ChangeUserInfoDialog({
    required this.dataInit,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeUserInfoDialog> createState() => _ChangeUserInfoDialogState();
}

class _ChangeUserInfoDialogState extends State<ChangeUserInfoDialog> {
  TextEditingController textController = TextEditingController();
  FocusNode firstFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    textController.text = widget.dataInit;
    Future.delayed(Duration.zero, () {
      firstFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.title,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: textController,
              focusNode: firstFocusNode,
              cursorColor: AppColors.black,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buttonCustom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  title: const Text(
                    'Không',
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                _buttonCustom(
                  gradient: AppColors.blueGradient,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  title: const Text(
                    'Xác nhận',
                  ),
                  onTap: () {
                    Navigator.of(context).pop(textController.text);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonCustom({
    required VoidCallback onTap,
    required Widget title,
    required EdgeInsetsGeometry padding,
    Gradient? gradient,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(4),
          gradient: gradient,
        ),
        alignment: Alignment.center,
        child: title,
      ),
    );
  }
}
