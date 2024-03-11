// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../resources/hive/hive_resources.dart';
import '../../pages/initial/initial_page.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 40.sp),
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () async {
           await Permission.storage.request();
           await Permission.accessMediaLocation.request();
            await Permission.notification.request();
           await Permission.manageExternalStorage.request();
          
         

            ///---! Don't Show this screen after restarting app
            MyHiveBoxes.settingBox
                .put(MyHiveKeys.showOnBoardingScreenHiveKey, false);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const InitialPage(),
              ),
            );
          },
          child: const Text(
            "Skip",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
