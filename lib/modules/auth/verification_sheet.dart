import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../shared/images/images.dart';
import '../../widgets/default_button.dart';
import '../../widgets/otp_widget.dart';
import 'confirm_dialog.dart';

class VerificationSheet extends StatefulWidget {
  const VerificationSheet({Key? key}) : super(key: key);

  @override
  State<VerificationSheet> createState() => _VerificationSheetState();
}

class _VerificationSheetState extends State<VerificationSheet> {
  
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();

  int _start = 60;

  bool timerFinished = false;

  Timer? timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            timerFinished = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 360,
        child: Stack(
          children: [
            Image.asset(Images.backGround,fit: BoxFit.cover,width: double.infinity,height: double.infinity,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tr('verify'),
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0,bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OTPWidget(
                          controller: c1,
                        ),
                        OTPWidget(
                          controller: c2,
                        ),
                        OTPWidget(
                          controller: c3,
                        ),
                        OTPWidget(
                          controller: c4,
                        ),
                      ],
                    ),
                  ),
                  DefaultButton(
                      text: tr('verify'),
                      onTap: (){
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context)=>ConfirmDialog()
                        );
                      }
                  ),
                  if (!timerFinished)
                    Text(
                      '00:$_start',
                    ),
                  if (timerFinished)
                    InkWell(
                      onTap: () {
                        timer;
                        _start = 60;
                        timerFinished = false;
                        startTimer();
                      },
                      child: Text(
                        tr('try_again'),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
