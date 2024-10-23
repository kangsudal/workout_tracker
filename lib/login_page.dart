import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Login',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  //중요:label 위에 고정되게
                  hintText: 'example@example.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이메일을 입력하세요';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    //이메일 정규표현식
                    return '올바른 이메일 형식을 입력하세요';
                  }
                  return null; //아무것도 하지않음, validator 콜백함수는 성공하면. TextFormField위젯의 멤버변수로 넘어감.
                  //어떤 시점에 불릴때, validator('aaa@naver.com') = validator.call('aaaaa.com')
                  //String? 값을 if문으로 처리: 아래에 받은 값(warning 문구)을 Text로 표시해줌. null일땐 아무것도 표시안해줌
                },
                onSaved: (value) {
                  email = value;
                },
              ),
              TextFormField(
                //중요:command+k 키보드나오게
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력하세요';
                  }
                  if (value.length < 6) {
                    return '비밀번호는 최소 6자 이상이어야 합니다';
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value;
                },
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('로그인'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text('go to Register page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
