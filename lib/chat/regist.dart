// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:learn_app/custom_widget/constant_button.dart';
// import 'package:learn_app/custom_widget/textForm.dart';
// import 'package:learn_app/screens/login_screen.dart';
// import 'package:learn_app/screens/profile/login.dart';
// import 'package:learn_app/screens/profile/methods.dart';
// import 'package:learn_app/screens/profile/profile.dart';
//
// import '../../constant.dart';
//
// class RegistScreen extends StatefulWidget {
//
//   @override
//   _RegistScreenState createState() => _RegistScreenState();
// }
//
// class _RegistScreenState extends State<RegistScreen> {
//
//   var formKey = GlobalKey<FormState>();
//
//   bool isPassword = true;
//
//   bool isLoading = false;
//
//   final _auth = Auth();
//
//   TextEditingController _email = TextEditingController();
//
//   TextEditingController _password = TextEditingController();
//
//   TextEditingController _name = TextEditingController();
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
//                     'register'.toUpperCase(),
//                     style: Theme.of(context).textTheme.headline3,
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   defaultTextForm(
//                     label: 'Enter Your Name',
//                     controller: _name,
//                     // onClick: (value)
//                     // {
//                     //   name = value;
//                     // },
//                     prefixIcon: Icon(
//                       Icons.person,
//                       color: defaultColor,
//                     ),
//                     textInputType: TextInputType.emailAddress,
//                     validate: (String value) {
//                       if (value.isEmpty) {
//                         return 'Name must not be empty';
//                       }
//                     },
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   defaultTextForm(
//                     label: 'Enter Your Email',
//                     controller: _email,
//                     // onClick: (value)
//                     // {
//                     //   email = value;
//                     // },
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
//                       // onClick: (value)
//                       // {
//                       //   password = value;
//                       // },
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
//                       text: 'REGISTER',
//                       function: () async
//                       {
//                         if(_name.text.isNotEmpty &&
//                             _email.text.isNotEmpty &&
//                             _password.text.isNotEmpty)
//                         {
//                           setState(() {
//                             isLoading = true;
//                           });
//
//                           final user = await _auth.createAccount(_name.text, _email.text, _password.text).then((user) {
//                                 if(user != null)
//                                 {
//                                   print('Register Sucessful');
//                                   setState(() {
//                                     isLoading = false;
//                                   });
//                                   navigateTo(context, Profile());
//                                 } else{
//                                   print('Register Failed');
//                                   setState(() {
//                                     isLoading = false;
//                                   });
//                                 }
//                             // print('Register Sucessful');
//                             // setState(() {
//                             //   isLoading = false;
//                             // });
//                             // navigateTo(context, Profile());
//                           });
//                         } else{
//                           print('Please enter Fields');
//                         }
//                       }
//                       ),
//
//                   SizedBox(
//                     height:10,
//                   ),
//
//                    TextButton(onPressed: ()=> navigateTo(context, LoginScreenFirebase() ), child: Text('LOGIN'))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
