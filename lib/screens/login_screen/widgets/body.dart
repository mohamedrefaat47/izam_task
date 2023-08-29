import 'package:flutter/material.dart';
import 'package:izam_task/models/user.dart';
import 'package:izam_task/providers/user_provider.dart';
import 'package:izam_task/utils/commons.dart';
import 'package:izam_task/utils/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:izam_task/utils/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:izam_task/utils/custom_widgets/custom_toast/custom_toast.dart';
import 'package:izam_task/utils/custom_widgets/safe_area/page_container.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with ValidationMixin {
  double _height = 0, _width = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserProvider? _userProvider;
  final ValueNotifier<bool> loginLoading = ValueNotifier(false);

  Future<void> _login() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    // start loading
    loginLoading.value = true;

    var userFromDb = _userProvider?.searchUsers(_emailController.text);
    // check if the user exist in db
    if (userFromDb != null) {
      if (userFromDb.password == _passwordController.text) {
        // success login msg user exist + increment number of logins
        Commons.showOverlayToast(
            message:
                "Login success, num of logins : ${userFromDb.numOfLogins! + 1}",
            type: ToastType.success,
            cxt: context);
        await _userProvider?.updateUser(User(
            id: userFromDb.id,
            email: userFromDb.email,
            password: userFromDb.password,
            numOfLogins: userFromDb.numOfLogins! + 1));
      } else {
        // error msg wrong password
        Commons.showOverlayToast(
            message: "Wrong password, try again !",
            type: ToastType.error,
            cxt: context);
      }
    } else {
      // user doesn't exist => add new user
      _userProvider
          ?.addnewUser(User(
              id: _userProvider!.usersList.isEmpty
                  ? 0
                  : _userProvider!.usersList.last.id! + 1,
              email: _emailController.text,
              password: _passwordController.text,
              numOfLogins: 1))
          .then((value) {
        /// success creating new user msg
        Commons.showOverlayToast(
            message: "User added successfully",
            type: ToastType.success,
            cxt: context);
      });
    }
    // end loading
    loginLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    return PageContainer(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            height: _height,
            width: _width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/dLogo.png',
                      fit: BoxFit.fitWidth,
                      width: _width / 2.5,
                    ),
                  ),
                  SizedBox(
                    height: _height / 12,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: _width / 15),
                    padding:
                        EdgeInsets.fromLTRB(_width / 20, 35, _width / 20, 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome, Log In",
                            style: TextStyle(
                                color: Color(0xff213242),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomTextFormField(
                              controller: _emailController,
                              hasHorizontalMargin: false,
                              hintTxt: "Email Address",
                              validation: (val) {
                                return validateUserEmail(val!);
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextFormField(
                            controller: _passwordController,
                            isPassword: true,
                            hasHorizontalMargin: false,
                            validation: (val) {
                              return validatePassword(val!);
                            },
                            hintTxt: "Password",
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  "Forget Password ?",
                                  style: TextStyle(
                                    color: Color(0xff213242),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ValueListenableBuilder<bool>(
                              valueListenable: loginLoading,
                              builder: (_, loading, __) {
                                return loading
                                    ? const CircularProgressIndicator()
                                    : SizedBox(
                                        width: double.infinity,
                                        height: 40,
                                        child: ElevatedButton(
                                            onPressed: () => _login(),
                                            child: const Text(
                                              'login',
                                              style: TextStyle(fontSize: 15),
                                            )));
                              })
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
