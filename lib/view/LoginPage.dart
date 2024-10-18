import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tourist/TouristPage.dart';
import '../controller/FirebaseAuth.dart';
import 'Admin Page.dart';
import 'RegisterPage.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedRole; // متغير لتخزين الدور المختار
  bool isLoading = false; // حالة التحميل

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل الدخول'),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // إضافة قابلية التمرير
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Text(
              'مرحبًا بك في التطبيق',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                border: OutlineInputBorder(), // إضافة إطار
                prefixIcon: Icon(Icons.email), // أيقونة البريد الإلكتروني
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                border: OutlineInputBorder(), // إضافة إطار
                prefixIcon: Icon(Icons.lock), // أيقونة كلمة المرور
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedRole,
              decoration: InputDecoration(
                labelText: 'اختر الدور',
                border: OutlineInputBorder(), // إضافة إطار
              ),
              items: <String>['Admin', 'Tourist'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedRole = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator() // عرض مؤشر التحميل
                : ElevatedButton(
              onPressed: () async {
                if (selectedRole == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('يرجى اختيار الدور')),
                  );
                  return;
                }

                setState(() {
                  isLoading = true; // تفعيل حالة التحميل
                });

                try {
                  // تسجيل الدخول باستخدام Firebase
                  await ref.read(authProvider).signIn(
                    emailController.text,
                    passwordController.text,
                  );

                  // الانتقال إلى الصفحة المناسبة بناءً على الدور
                  if (selectedRole == 'Admin') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPage()),
                    );
                  } else if (selectedRole == 'Tourist') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TouristPage()),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('فشل تسجيل الدخول: $e')),
                  );
                } finally {
                  setState(() {
                    isLoading = false; // إيقاف حالة التحميل
                  });
                }
              },
              child: Text('تسجيل الدخول'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0,left: 16),
              child: TextButton(
                onPressed: () {
                  // الانتقال إلى صفحة تسجيل مستخدم جديد
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('تسجيل مستخدم جديد'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}