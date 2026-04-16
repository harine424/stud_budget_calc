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
  final _BudgetController = TextEditingController();
  final _ExpenseController = TextEditingController();
  double _balance = 0.0;

  void _calculateBalance() {
    double budget = double.tryParse(_BudgetController.text) ?? 0.0;
    double expenses = double.tryParse(_ExpenseController.text) ?? 0.0;
    setState(() {
      _balance = budget - expenses;
    });
    if (_balance < 10) {
      AudioPlayer().play(AssetSource('audios/bongo.wav'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Budget Calculator', style: GoogleFonts.poppins()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/budgetcalc.png', height: 300),
            const SizedBox(height: 30),
            Text('Student Budget', style: GoogleFonts.lato()),
            const SizedBox(height: 20),

            TextField(
              controller: _BudgetController,
              decoration: const InputDecoration(
                labelText: "Enter your monthly budget here",
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _ExpenseController,
              decoration: const InputDecoration(
                labelText: "Enter your monthly expenses here",
              ),
              keyboardType: TextInputType.number,
            ),
            // Calculate balance when button is pressed
            ElevatedButton(
              onPressed: () {},

              child: const Text("Calculate Balance"),
            ),
            Text(
              "Your remaining balance is: \$${_balance.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
