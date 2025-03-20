import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: FormPage());
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _firstName;
  bool _showDatePicker = false;

  // Dummy data task
  final List<Map<String, dynamic>> tasks = [
    {'title': 'Makan', 'deadline': '15-03-2025 14:03', 'done': false},
    {'title': 'Minum', 'deadline': '14-03-2025 12:03', 'done': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
        title: const Text('FORM PAGE', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
