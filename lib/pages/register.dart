import 'package:flutter/material.dart';
import 'package:flutter_render/widgets/page_content.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageContent(name: '注册'),
    );
  }
}