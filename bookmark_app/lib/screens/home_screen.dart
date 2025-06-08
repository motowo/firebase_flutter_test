import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('マイブックマーク'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'ログアウト',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // LoginPageに自動的に遷移するはず (AuthenticationWrapperにより)
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user?.photoURL != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
                radius: 40,
              ),
            SizedBox(height: 16),
            Text('ようこそ、${user?.displayName ?? 'ユーザー'} さん'),
            Text('メールアドレス: ${user?.email ?? '登録なし'}'),
            SizedBox(height: 20),
            Text(
              'ブックマーク機能はここに実装されます。',
               style: Theme.of(context).textTheme.titleMedium,
            ),
            // TODO: ブックマーク一覧表示エリア
            // TODO: ブックマーク追加ボタン (FABなど)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: ブックマーク追加ダイアログ表示
          print("ブックマーク追加ボタンが押されました");
        },
        child: Icon(Icons.add),
        tooltip: '新しいブックマークを追加',
      ),
    );
  }
}
