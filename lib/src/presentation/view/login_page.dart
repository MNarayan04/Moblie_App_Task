import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackerkernel_task/src/data/data_sources/shared_pref.dart';
import 'package:hackerkernel_task/src/data/repos/network/user_repository.dart';
import 'package:hackerkernel_task/src/presentation/view/dashboard.dart';
import 'package:hackerkernel_task/src/presentation/view/forget_page.dart';
import 'package:hackerkernel_task/src/presentation/view/register.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isUserFound = true;
  String value = '';

  checkUserCredentials(String email, String password) async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      bool loginStatus = await UserRepository().login(email, password);
      SharedPref().setLoginStatus(loginStatus);
      if (loginStatus) {
        isUserFound = true;
      } else {
        isUserFound = false;
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Empty Field',
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: size.height - 50,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Lottie.network(
                  'https://lottie.host/794ec8b2-fc5f-4dfb-b468-8492267f6652/7HOYL5A1R0.json',
                  height: 250,
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 24),
                LoginTextField(
                  prefix: FontAwesomeIcons.at,
                  hintText: 'Email ID',
                  controller: _emailController,
                ),
                const SizedBox(height: 24),
                LoginTextField(
                  hintText: 'Password',
                  prefix: FontAwesomeIcons.key,
                  controller: _passwordController,
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: !isUserFound,
                  child: Text(
                    'User not found!',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.red,
                        ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 73, 184),
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    checkUserCredentials(
                      _emailController.text,
                      _passwordController.text,
                    );
                    isUserFound
                        ? Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ),
                            (route) => false)
                        : null;
                  },
                  child: Container(
                    height: 64,
                    width: size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 73, 184),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const Divider(),
                    Container(
                      height: 48,
                      width: 48,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Text(
                        'OR',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: const Color.fromARGB(255, 181, 187, 196),
                              fontSize: 20,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 64,
                  width: size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 237, 244, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const FaIcon(FontAwesomeIcons.google),
                      Center(
                        child: Text(
                          'Login with Google',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 110, 117, 128),
                              ),
                        ),
                      ),
                      const SizedBox(width: 24),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New to Logistics?',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: const Color.fromARGB(255, 181, 187, 196),
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        ' Register',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: const Color.fromARGB(255, 0, 75, 187),
                                ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginTextField extends StatefulWidget {
  const LoginTextField({
    super.key,
    required this.prefix,
    required this.hintText,
    required this.controller,
  });

  final IconData prefix;
  final String hintText;
  final TextEditingController controller;
  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;

  bool isHide = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(
          widget.prefix,
          color: const Color.fromARGB(255, 181, 187, 196),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.hintText == "Email ID" ? false : isHide,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: const Color.fromARGB(255, 68, 69, 71),
                  fontWeight: FontWeight.bold,
                ),
            onChanged: (value) {
              widget.hintText == 'Email ID'
                  ? value.isEmpty
                      ? isEmailEmpty = true
                      : isEmailEmpty = false
                  : value.isEmpty
                      ? isPasswordEmpty = true
                      : isPasswordEmpty = false;
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 181, 187, 196),
                fontSize: 16,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 181, 187, 196),
                  width: 2,
                ),
              ),
              error: Visibility(
                visible: widget.hintText == 'Email ID'
                    ? isEmailEmpty
                    : isPasswordEmpty,
                child: const Text('Empty Field'),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.hintText == 'Email ID'
                      ? isEmailEmpty
                          ? Colors.red
                          : Colors.blue
                      : isPasswordEmpty
                          ? Colors.red
                          : Colors.blue,
                ),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: widget.hintText == 'Email ID'
                      ? isEmailEmpty
                          ? Colors.red
                          : Colors.blue
                      : isPasswordEmpty
                          ? Colors.red
                          : Colors.blue,
                ),
              ),
              suffixIcon: Visibility(
                visible: widget.hintText == 'Password',
                child: IconButton(
                  icon: FaIcon(
                    isHide ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                    color: const Color.fromARGB(255, 181, 187, 196),
                  ),
                  onPressed: () {
                    isHide = !isHide;
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
