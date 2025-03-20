import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text('Task Date:', style: TextStyle(fontSize: 18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Select a date'
                        : '${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year} ${_selectedDate!.hour.toString().padLeft(2, '0')}:${_selectedDate!.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 18,
                      color:
                          _selectedDate == null ? Colors.black : Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_month, color: Colors.blue),
                    onPressed: () {
                      setState(() {
                        _showDatePicker = true;
                      });
                    },
                  ),
                ],
              ),
              if (_selectedDate == null)
                const Text(
                  "Please select a date",
                  style: TextStyle(color: Colors.red),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        hintText: 'Enter your first name',
                        border: const OutlineInputBorder(),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (value) => _firstName = value,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 60, // Biar sejajar sama TextField
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {}); // Trigger rebuild biar error keliatan
                        if (_formKey.currentState!.validate() &&
                            _selectedDate != null) {
                          _formKey.currentState!.save();
                          setState(() {
                            tasks.add({
                              'title': _firstName!,
                              'deadline':
                                  '${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year} ${_selectedDate!.hour.toString().padLeft(2, '0')}:${_selectedDate!.minute.toString().padLeft(2, '0')}',
                              'done': false,
                            });
                            _firstName = null;
                            _selectedDate = null;
                            _formKey.currentState!.reset();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Form Submitted'),
                              backgroundColor:
                                  Colors.green, // ✅ SnackBar jadi hijau
                            ),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              const Text(
                'List Tasks',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...tasks.map(
                (task) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Deadline: ${task['deadline']}',
                            style: const TextStyle(color: Colors.blueGrey),
                          ),
                          Text(
                            task['done'] ? 'Done' : 'Not Done',
                            style: TextStyle(
                              color: task['done'] ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Checkbox(
                        value: task['done'],
                        activeColor: Colors.deepPurple,
                        onChanged: (value) {
                          setState(() {
                            task['done'] = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet:
          _showDatePicker
              ? Container(
                height: 300,
                color: Colors.white,
                child: Column(
                  children: [
                    const Text(
                      'Set Task Date & Time',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.dateAndTime,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (dateTime) {
                          _selectedDate = dateTime;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showDatePicker = false;
                        });
                      },
                      child: const Text('Select'),
                    ),
                  ],
                ),
              )
              : null,
    );
  }
}
