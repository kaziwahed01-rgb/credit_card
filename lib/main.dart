import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/presentation/presentation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Credit Card',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: BlocProvider(
        create: (context) => CardFormBloc(),
        child: const CreditCardPage(),
      ),
    );
  }
}
