import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Twoo Numbers',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AddTwoNumbersPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AddTwoNumbersPage extends StatefulWidget {
  const AddTwoNumbersPage({super.key});
  @override
  State<AddTwoNumbersPage> createState() => _AddTwoNumbersPageState();
}

class _AddTwoNumbersPageState extends State<AddTwoNumbersPage> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  String _result = '';

  void _addNumbers() {
    // Remove keyboard
    FocusScope.of(context).unfocus();

    final String aText = _aController.text.trim();
    final String bText = _bController.text.trim();

    final double? a = double.tryParse(aText);
    final double? b = double.tryParse(bText);

    if (a == null || b == null) {
      // Simple user feedback for invalid input
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid numbers')),
      );
      return;
    }

    final double sum = a + b;
    // Format: show integer if no fractional part
    final String formatted = (sum == sum.roundToDouble())
        ? sum.toInt().toString()
        : sum.toString();
    setState(() {
      _result = formatted;
    });
  }

  void _clear() {
    _aController.clear();
    _bController.clear();
    setState(() {
      _result = '';
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Two Numbers'),
        centerTitle: true,
      ),
body: Container(
  color: Colors.lightBlue[50], // 👈 background color
  child: Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title at center
          const Text(
            'Add Two Numbers',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // First number
          SizedBox(
            width: 200,
            child: TextField(
              controller: _aController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'First number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Enter first number',
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Second number
          SizedBox(
            width: 250,
            child: TextField(
              controller: _bController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Second number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Enter second number',
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Buttons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _addNumbers,
                child: const Text('Add'),
              ),
              ElevatedButton(
                onPressed: _clear,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Result display
          Text(
            _result.isEmpty ? 'Result will appear here' : 'Result: $_result',
            style: TextStyle(
              fontSize: 20,
              color: _result.isEmpty ? Colors.grey : Colors.black,
              fontWeight:
                  _result.isEmpty ? FontWeight.normal : FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  ),
),
  );
  }
}
