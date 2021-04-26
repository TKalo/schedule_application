
import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/support/CustomComponents.dart';

import '../MainViewModel.dart';
import 'AuthenticationViewModel.dart';


class ForgotPasswordUI extends StatelessWidget {

  final AuthenticationViewModel viewModel = AuthenticationViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => MainViewModel().navigate(),),
        centerTitle: true,
        title: CustomTitleText(title: "RESET PASSWORD", fontSize: 18,),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.blue[200],
      ),
    );
  }
}
