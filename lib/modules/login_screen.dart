import 'package:flutter/material.dart';
import 'package:saas/shared/components/components.dart';
import 'package:saas/shared/styles/colors.dart';
import 'home_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isPassword = true;
  bool get isEmail{
    String p = '[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(emailController.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultLightColor,
      body: CustomScrollView(
        slivers:[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40,),
                  Row(
                    children:[
                      Image.asset('assets/images/login.png',
                        width: 175,
                        height: 175,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  const SizedBox(height: 20,),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: defaultBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal:35,
                            vertical: 20
                        ),
                        child: Column(
                          children: [
                            const Text('  Sign In',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 20,),
                            defaultTextField(
                              textEditingController: emailController,
                              textInputType: TextInputType.emailAddress,
                              hintText: 'E-mail',
                              preIcon: Icons.email,
                              validator: (emailController){
                                if(emailController.toString().isEmpty) {
                                  return 'Your Email is empty!';
                                } else if(!isEmail) {
                                  return 'Check Your Email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15.0,),
                            defaultTextField(
                              textEditingController: passwordController,
                              textInputType: TextInputType.visiblePassword,
                              hintText: 'Password',
                              preIcon: Icons.lock,
                              isPassword: isPassword,
                              suffixIcon: isPassword? Icons.visibility : Icons.visibility_off,
                              /*suffixPressed: (){
                                      setState(() {
                                        isPassword = !isPassword;
                                      });
                                    },*/
                              validator: (passwordController){
                                if(passwordController.toString().isEmpty) {
                                  return 'Your password is empty!';
                                } else if(passwordController.toString().length<=6) {
                                  return 'Password must be greater than 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20,),
                            defaultButton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>const HomeScreen()),
                                  );
                                }
                              },
                              text: 'login'.toUpperCase(),
                            ),
                            Row(
                              children:[TextButton(
                                onPressed: (){},
                                child: const Text(
                                  'Forget Your Password?',
                                  style: TextStyle(color: Colors.black87,
                                  ),
                                ),
                              ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}