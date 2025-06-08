import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      // Webでは signInWithPopup を使用
      // モバイルでは signInWithProvider (または signInWithCredential) を使用
      await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } catch (e) {
      print("Google Sign-In Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In Failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ブックマークアプリへようこそ'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ログインしてブックマークを開始しましょう',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              icon: Image.asset('assets/images/google_logo.png', height: 24.0), // Googleロゴ画像が必要
              label: Text('Googleでサインイン'),
              onPressed: () => _signInWithGoogle(context),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
