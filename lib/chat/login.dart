// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:learn_app/custom_widget/constant_button.dart';
// import 'package:learn_app/custom_widget/textForm.dart';
// import 'package:learn_app/screens/profile/methods.dart';
// import 'package:learn_app/screens/profile/profile.dart';
//
// import '../../constant.dart';
//
// class LoginScreenFirebase extends StatefulWidget {
//
//   @override
//   _LoginScreenFirebaseState createState() => _LoginScreenFirebaseState();
// }
//
// class _LoginScreenFirebaseState extends State<LoginScreenFirebase> {
//  final _auth = Auth();
//   var formKey = GlobalKey<FormState>();
//
//   bool isPassword = true;
//
//   bool isLoading = false;
//
//   final TextEditingController _email = TextEditingController();
//
//   final TextEditingController _password = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: isLoading? Center(
//         child: CircularProgressIndicator(),
//       ) : Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding:
//             const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Login'.toUpperCase(),
//                     style: Theme.of(context).textTheme.headline3,
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   defaultTextForm(
//                     label: 'Enter Your Email',
//                     controller: _email,
//                     prefixIcon: Icon(
//                       Icons.email,
//                       color: defaultColor,
//                     ),
//                     textInputType: TextInputType.emailAddress,
//                     validate: (String value) {
//                       if (value.isEmpty) {
//                         return 'Email must not be empty';
//                       }
//                     },
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   defaultTextForm(
//                       label: 'Enter Your Password',
//                       controller: _password,
//                       prefixIcon: Icon(
//                         Icons.lock,
//                         color: defaultColor,
//                       ),
//                       suffixIcon: isPassword
//                           ? Icon(Icons.visibility)
//                           : Icon(
//                         Icons.visibility_off_rounded,
//                         color: defaultColor,
//                       ),
//                       suffixPressed: () {
//                         // setState(() {
//                         //   isPassword =! isPassword;
//                         // });
//                       },
//                       textInputType: TextInputType.visiblePassword,
//                       isPassword: isPassword,
//                       validate: (String value) {
//                         if (value.isEmpty) {
//                           return 'PassWord too Short';
//                         }
//                       },
//                       onSubmitted: (value) {
//                         // if (formKey.currentState.validate()) {
//                         //   AppRegisterCubit.get(context).UserRegister(
//                         //     email: emailController.text,
//                         //     password: passwordController.text,
//                         //     name: nameController.text,
//                         //     phone: phoneController.text,
//                         //   );
//                         // }
//                       }),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   defaultButton(
//                       text: 'LOGIN',
//                       function: () async
//                       {
//                         if(_email.text.isNotEmpty &&
//                             _password.text.isNotEmpty)
//                         {
//                           setState(() {
//                             isLoading = true;
//                           });
//
//                          await _auth.SignIn( _email.text, _password.text)
//                               .then((user) {
//                             if(user != null)
//                             {
//                               print('Login Sucessful');
//                               setState(() {
//                                 isLoading = false;
//                               });
//                               navigateTo(context, Profile());
//                             } else{
//                               print('Login Failed');
//                               setState(() {
//                                 isLoading = false;
//                               });
//                             }
//                           });
//                         } else{
//                           print('Please enter Fields');
//                         }
//                       }
//                   ),
//
//                   SizedBox(
//                     height:10,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
