import 'package:corona_live_flutter/lib/PreviousPageProvider.dart';
import 'package:corona_live_flutter/lib/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final idTextFieldController = TextEditingController();
  final pwTextFieldController = TextEditingController();
  final DEFAULT_ID = 'skku';
  final DEFAULT_PW = '1234';

  void onPressedLoginButton(UserProvider userProvider) {
    if (idTextFieldController.text == DEFAULT_ID && pwTextFieldController.text == DEFAULT_PW) {
      userProvider.login(idTextFieldController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final previousPageProvider = Provider.of<PreviousPageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Corona Live'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("CORONA LIVE"),
                        Text(userProvider.userId == null ? 'Login Please' : 'Login Success. Hello ${userProvider.userId}')
                      ],
                    ),
                  )
                ]
            ),
          ),
          userProvider.userId == null ?
          Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black38),
                borderRadius: const BorderRadius.all(const Radius.circular(8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text('ID: '),
                        width: 50,
                      ),
                      Expanded(child: TextField(
                        controller: idTextFieldController,
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text('PW: '),
                        width: 50,
                      ),
                      Expanded(child: TextField(
                        controller: pwTextFieldController,
                        obscureText: true,
                      ))
                    ],
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () => onPressedLoginButton(userProvider),
                      child: Text('Login'),
                    ),
                    margin: const EdgeInsets.only(top: 20),
                  )
                ],
              )
          )
              : Container(
              margin: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/img-covid19.jpeg',
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 60),
                    child: ElevatedButton(onPressed: () {
                        previousPageProvider.visit('Login Page');
                        Navigator.pushNamed(context, '/navigation');
                      },
                      child: Text('Start CORONA LIVE')
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
