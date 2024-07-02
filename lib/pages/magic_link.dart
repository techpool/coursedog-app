import 'package:coursedog_app/components/common/top_bar.dart';
import 'package:coursedog_app/notifiers/user.dart';
import 'package:coursedog_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:provider/provider.dart';

class MagicLink extends StatelessWidget {
  const MagicLink({super.key});

  @override
  Widget build(BuildContext context) {
    LoadingState loginState = Provider.of<UserNotifier>(context).loginState;
    bool isLoggingIn = loginState == LoadingState.loading;

    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56.0),
            child: TopBar(
              title: 'Magic Code',
            )),
        body: SafeArea(
          minimum: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: Theme.of(context).primaryColor,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: false,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  alignment: Alignment.centerLeft,
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Verification Code"),
                            content: Text('Code entered is $verificationCode'),
                          );
                        });
                  }, // end onSubmit
                ),
                const Gap(20.0),
                const Text('Enter the code sent to your email'),
                const Gap(20.0),
                TextButton.icon(
                  onPressed: () async {
                    // Check if mounted
                    if (!context.mounted) return;

                    // Android: Will open mail app or show native picker.
                    // iOS: Will open mail app if single mail app found.
                    var result = await OpenMailApp.openMailApp();

                    // If no mail apps found, show error
                    if (!result.didOpen && !result.canOpen && context.mounted) {
                      showNoMailAppsDialog(context);

                      // iOS: if multiple mail apps found, show dialog to select.
                      // There is no native intent/default app system in iOS so
                      // you have to do it yourself.
                    } else if (!result.didOpen &&
                        result.canOpen &&
                        context.mounted) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return MailAppPickerDialog(
                            mailApps: result.options,
                          );
                        },
                      );
                    }
                  },
                  icon: const Icon(Icons.email),
                  label: const Text('Open Email App'),
                )
              ],
            )),
            ButtonBar(
              children: [
                TextButton.icon(
                  label: const Text('Resend Code'),
                  icon: isLoggingIn
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.refresh),
                  onPressed: () {
                    Provider.of<UserNotifier>(context, listen: false)
                        .resendMagicLink();
                  },
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary),
                    onPressed: () {
                      Get.toNamed('/home');
                    },
                    child: const Text('Submit')),
              ],
            )
          ]),
        ));
  }
}

void showNoMailAppsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Open Mail App"),
        content: const Text("No mail apps installed"),
        actions: <Widget>[
          TextButton(
            child: const Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}
