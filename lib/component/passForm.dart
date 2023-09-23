// import 'package:flutter/material.dart';

// class PassForm extends StatefulWidget {
//   final TextEditingController passwordController;
//   const PassForm({super.key, required this.passwordController});

//   @override
//   State<PassForm> createState() => _PassFormState();
// }

// class _PassFormState extends State<PassForm> {
//   bool visible = true;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Container(
//         child: TextFormField(
          
//           validator: (value) {
//             if (value.toString().isEmpty || value == null) {
//               return "Masukkan Password";
//             }
//           },
//           controller: widget.passwordController,
//           obscureText: visible,
//           decoration: InputDecoration(
//             labelText: "Password",
//             prefixIcon: Icon(Icons.lock),
//             hintText: "xxxxxxxx",
//             border: const OutlineInputBorder(),
//             helperText: "Password",
//             suffixIcon: hidePassword(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget hidePassword() {
//     return IconButton(
//         onPressed: () {
//           setState(() {
//             visible = !visible;
//           });
//         },
//         icon: visible ? Icon(Icons.visibility_off) : Icon(Icons.visibility));
//   }
// }
