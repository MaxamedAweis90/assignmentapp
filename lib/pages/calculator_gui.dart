import 'package:flutter/material.dart';

class CalculatorGUI extends StatefulWidget {
  const CalculatorGUI({super.key});

  @override
  _CalculatorGUIState createState() => _CalculatorGUIState();
}

class _CalculatorGUIState extends State<CalculatorGUI> {
  String _displayText = "0";
  double? _firstOperand;
  String? _operator; // Stores the selected operator
  bool _isTypingSecondOperand =
      false; // Tracks when the second operand is being entered
  bool _hasResult = false; // Tracks whether a result has been displayed

  // Handles number button presses
  void _onNumberPressed(String number) {
    setState(() {
      // If a result was displayed or starting to type the second operand, clear the display
      if (_hasResult || _isTypingSecondOperand) {
        _displayText = number;
        _isTypingSecondOperand = false;
        _hasResult = false; // Reset the result flag
      } else {
        // Append the number to the existing text
        _displayText = _displayText == "0" ? number : _displayText + number;
      }
    });
  }

  // Handles operator button presses
  void _onOperatorPressed(String operator) {
    setState(() {
      if (_firstOperand == null) {
        // Store the first operand and set the operator
        _firstOperand = double.tryParse(_displayText);
        _operator = operator;
        _isTypingSecondOperand = true; // Ready for second operand
      } else if (_operator != null) {
        // Perform calculation if an operator is already set
        _calculateResult();
        _operator = operator;
        _firstOperand = double.tryParse(_displayText); // Update first operand
        _isTypingSecondOperand = true; // Ready for second operand
      }
    });
  }

  // Performs the calculation
  void _calculateResult() {
    if (_firstOperand != null && _operator != null) {
      double? secondOperand = double.tryParse(_displayText);
      if (secondOperand != null) {
        double result;

        switch (_operator) {
          case '+':
            result = _firstOperand! + secondOperand;
            break;
          case '-':
            result = _firstOperand! - secondOperand;
            break;
          case '*':
            result = _firstOperand! * secondOperand;
            break;
          case '/':
            if (secondOperand != 0) {
              result = _firstOperand! / secondOperand;
            } else {
              _displayText = "Error"; // Handle division by zero
              _firstOperand = null;
              _operator = null;
              _isTypingSecondOperand = false;
              _hasResult = true; // Ensure new input clears the display
              return;
            }
            break;
          default:
            return;
        }

        setState(() {
          // Display the result and reset states
          _displayText = result.toStringAsFixed(2);
          _firstOperand = null;
          _operator = null;
          _isTypingSecondOperand = false;
          _hasResult = true; // Result has been displayed
        });
      }
    }
  }

  // Clears all inputs and resets the calculator
  void _clear() {
    setState(() {
      _displayText = "0";
      _firstOperand = null;
      _operator = null;
      _isTypingSecondOperand = false;
      _hasResult = false;
    });
  }

  // Builds calculator buttons
  Widget _buildButton(String text, {Color? color, Function()? onPressed}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.deepPurple,
            padding: const EdgeInsets.all(20),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('The Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                _displayText,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            children: [
              _buildButton("7", onPressed: () => _onNumberPressed("7")),
              _buildButton("8", onPressed: () => _onNumberPressed("8")),
              _buildButton("9", onPressed: () => _onNumberPressed("9")),
              _buildButton(
                "/",
                color: Colors.orange,
                onPressed: () => _onOperatorPressed("/"),
              ),
            ],
          ),
          Row(
            children: [
              _buildButton("4", onPressed: () => _onNumberPressed("4")),
              _buildButton("5", onPressed: () => _onNumberPressed("5")),
              _buildButton("6", onPressed: () => _onNumberPressed("6")),
              _buildButton(
                "*",
                color: Colors.orange,
                onPressed: () => _onOperatorPressed("*"),
              ),
            ],
          ),
          Row(
            children: [
              _buildButton("1", onPressed: () => _onNumberPressed("1")),
              _buildButton("2", onPressed: () => _onNumberPressed("2")),
              _buildButton("3", onPressed: () => _onNumberPressed("3")),
              _buildButton(
                "-",
                color: Colors.orange,
                onPressed: () => _onOperatorPressed("-"),
              ),
            ],
          ),
          Row(
            children: [
              _buildButton("C", color: Colors.red, onPressed: _clear),
              _buildButton("0", onPressed: () => _onNumberPressed("0")),
              _buildButton(
                "=",
                color: Colors.green,
                onPressed: _calculateResult,
              ),
              _buildButton(
                "+",
                color: Colors.orange,
                onPressed: () => _onOperatorPressed("+"),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
