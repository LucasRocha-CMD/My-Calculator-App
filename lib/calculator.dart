
import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _userInput = '';
  String _result = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _userInput = '';
        _result = '';
      } else if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == '⌫') {
        if (_userInput.isNotEmpty) {
          _userInput = _userInput.substring(0, _userInput.length - 1);
        }
      } else {
        _userInput += buttonText;
      }
    });
  }

  void _calculateResult() {
    try {
      String expression = _userInput.replaceAll('x', '*').replaceAll('÷', '/');
      ExpressionEvaluator evaluator = const ExpressionEvaluator();
      var result = evaluator.eval(Expression.parse(expression), {});
      _result = result.toString();
    } catch (e) {
      _result = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _userInput,
                      style: const TextStyle(fontSize: 24),
                    ),
                    Text(
                      _result,
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 4,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  _buildButton('C', Colors.red),
                  _buildButton('(', Colors.grey),
                  _buildButton(')', Colors.grey),
                  _buildButton('÷', Colors.orange),
                  _buildButton('7', Colors.grey[300]),
                  _buildButton('8', Colors.grey[300]),
                  _buildButton('9', Colors.grey[300]),
                  _buildButton('x', Colors.orange),
                  _buildButton('4', Colors.grey[300]),
                  _buildButton('5', Colors.grey[300]),
                  _buildButton('6', Colors.grey[300]),
                  _buildButton('-', Colors.orange),
                  _buildButton('1', Colors.grey[300]),
                  _buildButton('2', Colors.grey[300]),
                  _buildButton('3', Colors.grey[300]),
                  _buildButton('+', Colors.orange),
                  _buildButton('0', Colors.grey[300]),
                  _buildButton('.', Colors.grey[300]),
                  _buildButton('⌫', Colors.grey),
                  _buildButton('=', Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color? color) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        textStyle: const TextStyle(fontSize: 24),
        padding: const EdgeInsets.all(24),
      ),
      child: Text(text),
    );
  }
}
