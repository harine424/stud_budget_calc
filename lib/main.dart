import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BudgetPage());
  }
}

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final _budgetController = TextEditingController();
  final _expenseController = TextEditingController();
  double _balance = 0.0;
  String _warningMessage = "";

  void _calculateBalance() {
    double budget = double.tryParse(_budgetController.text) ?? 0.0;
    double expenses = double.tryParse(_expenseController.text) ?? 0.0;
    setState(() {
      _balance = budget - expenses;
    });
    if (_balance < 10) {
      const SizedBox(height: 40);
      _warningMessage =
          "Your balance is low! Consider reviewing your expenses.";
      AudioPlayer().play(AssetSource('audios/alarm_beep.wav'));
    } else {
      _warningMessage = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Budget Calculator', style: GoogleFonts.poppins()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/budgetcalc.png', height: 300),
              const SizedBox(height: 30),
              Text(
                'Student Budget',
                style: GoogleFonts.acme(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _budgetController,
                decoration: const InputDecoration(
                  labelText: "Enter your monthly budget here",
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _expenseController,
                decoration: const InputDecoration(
                  labelText: "Enter your monthly expenses here",
                ),
                keyboardType: TextInputType.number,
              ),
              // Calculate balance when button is pressed
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateBalance,
                child: const Text("Calculate Balance"),
              ),
              if (_warningMessage.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  _warningMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              const SizedBox(height: 40),
              Text(
                "Your remaining balance is: RM ${_balance.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
