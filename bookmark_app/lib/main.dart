import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
// import 'firebase_options.dart'; // FlutterFire CLI を使用する場合

// TODO: ユーザーがFirebaseコンソールから取得した実際の値に置き換える必要があります。
// この firebaseOptions は、Firebaseコンソールのプロジェクト設定 -> マイアプリ -> SDK の設定と構成 で確認できます。
const firebaseOptions = FirebaseOptions(
  apiKey: "YOUR_API_KEY", // ここを実際のAPIキーに置き換えてください
  authDomain: "YOUR_AUTH_DOMAIN", // ここを実際の認証ドメインに置き換えてください
  projectId: "YOUR_PROJECT_ID", // ここを実際のプロジェクトIDに置き換えてください
  storageBucket: "YOUR_STORAGE_BUCKET", // ここを実際のストレージバケットに置き換えてください
  messagingSenderId: "YOUR_MESSAGING_SENDER_ID", // ここを実際のメッセージングセンダーIDに置き換えてください
  appId: "YOUR_APP_ID", // ここを実際のApp IDに置き換えてください
  // measurementId: "YOUR_MEASUREMENT_ID" // measurementId はオプションです
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebaseOptions, // 手動で設定する場合
    // options: DefaultFirebaseOptions.currentPlatform, // FlutterFire CLI で firebase_options.dart を生成した場合
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      initialData: null, // 初期データとしてnull（未認証状態）を設定
      child: MaterialApp(
        title: 'ブックマークアプリ',
        theme: ThemeData(
          primarySwatch: Colors.indigo, // テーマカラーを変更
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false, // デバッグバナーを非表示
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider経由で認証状態を取得
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      // ユーザーがログインしている場合
      return HomePage();
    }
    // ユーザーがログインしていない場合
    return LoginPage();
  }
}
