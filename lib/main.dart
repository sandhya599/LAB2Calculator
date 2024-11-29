import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modern Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const CalculatorPage()),
      );
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 249, 246),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image.png', // Make sure the path matches your asset
              width: 400,
              height: 400,
            ),
            const SizedBox(height: 20),
            const Text(
              "Modern Calculator",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = "0";
  String _operation = "";
  double? _firstOperand;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _display = "0";
        _operation = "";
        _firstOperand = null;
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        if (_firstOperand == null) {
          _firstOperand = double.tryParse(_display);
        }
        _operation = value;
        _display = "0";
      } else if (value == "=") {
        if (_firstOperand != null && _operation.isNotEmpty) {
          double? secondOperand = double.tryParse(_display);
          if (secondOperand != null) {
            switch (_operation) {
              case "+":
                _display = (_firstOperand! + secondOperand).toString();
                break;
              case "-":
                _display = (_firstOperand! - secondOperand).toString();
                break;
              case "*":
                _display = (_firstOperand! * secondOperand).toString();
                break;
              case "/":
                _display = secondOperand != 0
                    ? (_firstOperand! / secondOperand).toString()
                    : "Error";
                break;
            }
          }
          _firstOperand = null;
          _operation = "";
        }
      } else {
        if (_display == "0") {
          _display = value;
        } else {
          _display += value;
        }
      }
    });
  }

  Widget _buildButton(
    String text, {
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: () => _onButtonPressed(text),
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Modern Calculator", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Display Panel
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(24.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(4, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Text(
              _display,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // Buttons
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton("7", backgroundColor: Colors.white, textColor: Colors.orange),
                    _buildButton("8", backgroundColor: Colors.white, textColor: Colors.orange),
                    _buildButton("9", backgroundColor: Colors.white, textColor: Colors.orange),
                    _buildButton("/", backgroundColor: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4", backgroundColor: Colors.white, textColor: Colors.orange),
                    _buildButton("5", backgroundColor: Colors.white, textColor: Colors.orange),
                    _buildButton("6", backgroundColor: Colors.white, textColor: Colors.orange),
                    _buildButton("*", backgroundColor: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1", backgroundColor: Colors.white, textColor: Colors.orange),
                    _buildButton("2", backgroundColor: Colors.white, textColor: Colors.orange),
                    _buildButton("3", backgroundColor: Colors.white, textColor: Colors.orange),
                    _buildButton("-", backgroundColor: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("C", backgroundColor: Colors.orange, textColor: Colors.white),
                    _buildButton("0", backgroundColor: Colors.white, textColor: Colors.orange),
                    _buildButton("=", backgroundColor: Colors.orange, textColor: Colors.white),
                    _buildButton("+", backgroundColor: Colors.orange, textColor: Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
