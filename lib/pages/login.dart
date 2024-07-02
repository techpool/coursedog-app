import 'package:coursedog_app/components/common/logo.dart';
import 'package:coursedog_app/notifiers/user.dart';
import 'package:coursedog_app/utils/api.dart';
import 'package:coursedog_app/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri privacyPolicyUrl =
    Uri.parse('https://www.coursedog.com/company/privacy-policy');
final Uri termsOfServiceUrl =
    Uri.parse('https://www.coursedog.com/company/privacy-policy');

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';

  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {
        _email = emailController.text;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoadingState loginState = Provider.of<UserNotifier>(context).loginState;
    bool isLoggingIn = loginState == LoadingState.loading;
    bool isLoaded = loginState == LoadingState.loaded;
    List<String> schools = Provider.of<UserNotifier>(context).schools;

    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CoursedogLogo()],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: TextField(
                      controller: emailController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        error: isLoaded && schools.isEmpty
                            ? Text('Please enter a valid email',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error))
                            : null,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary),
                      onPressed: _email.isEmpty || isLoggingIn
                          ? null
                          : () {
                              Provider.of<UserNotifier>(context, listen: false)
                                  .fetchSchoolsForEmail(emailController.text);
                              Get.toNamed('/magic-link');
                            },
                      child: isLoggingIn
                          ? const CircularProgressIndicator()
                          : const Text('Login')),
                ])),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'By logging in, you agree to our ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Terms of Service',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(termsOfServiceUrl);
                        },
                    ),
                    const TextSpan(
                      text: ' and ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(privacyPolicyUrl);
                        },
                    ),
                    const TextSpan(
                      text: '.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )),
          ])),
    );
  }
}
