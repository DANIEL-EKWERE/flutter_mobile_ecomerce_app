import 'package:ecommerce1/controller/api_service.dart';
import 'package:ecommerce1/models/login_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // final bool isVisible = false;
  // bool isChecked = false;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final bool isVisible = false;
  // final bool isChecked = true;
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
//     final bool isVisible = false;
    bool isChecked = true;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child:
            ListView(physics: const NeverScrollableScrollPhysics(), children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(133, 53, 132, 47),
                    child: Image.asset(
                      "assest/images/Quick_Buy_Logo.png",
                      width: 90,
                      height: 56,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Log In',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email Address',
                      labelText: 'Email Address',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _password,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.visibility_outlined),
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Forgot Password',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xffFEB700)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isChecked = newValue!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Text('Remember me'),
                      const SizedBox(
                        height: 47,
                      ),
                    ],
                  ),
                  Consumer(
                    builder: (BuildContext context, value, Widget? child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xff0183AC),
                          fixedSize: const Size(500, 52),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                        ),
                        onPressed: () async {
                          Navigator.pushReplacementNamed(
                              context, "/App_Layout");


  // commented out BELOW  
                            final apiService = Provider.of<ProductProvider>(
                                context,
                                listen: false);
                            final login = LoginModel(
                                username: _email.text, password: _password.text);
                            try {
                              await apiService.login(login).then((value) =>
                                  Navigator.pushReplacementNamed(
                                      context, "/App_Layout"));
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: Text(e.toString()),
                                      actions: [
                                        InkWell(
                                          child: const Text('ok'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }


                          // commented out ABOUT
                        },
                        child: const Text('Log In'),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: RichText(
                        text: TextSpan(
                            text: 'Have an account already?  ',
                            style: TextStyle(color: Colors.black87),
                            children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer(),
                              text: 'Sign Up',
                              style: TextStyle(color: Color(0xff0183AC)))
                        ])),
                  )
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
