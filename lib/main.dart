import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';  // Display text
  String operator = '';      // Stores the selected operator (+, -, *, /)
  double firstOperand = 0;   // First operand
  bool isOperatorPressed = false;  // Track if operator is pressed

  // Handles button presses
  void buttonPressed(String buttonText) {
    setState(() {
      // Handle Clear button
      if (buttonText == 'C') {
        displayText = '0';
        firstOperand = 0;
        operator = '';
        isOperatorPressed = false;
      } 
      // Handle decimal input
      else if (buttonText == '.' && !displayText.contains('.')) {
        displayText += buttonText;
      } 
      // Handle number input
      else if ('0123456789'.contains(buttonText)) {
        if (isOperatorPressed) {
          displayText = buttonText; // Replace display with new number after operator is pressed
          isOperatorPressed = false;
        } else {
          displayText == '0' ? displayText = buttonText : displayText += buttonText; // Concatenate numbers
        }
      } 
      // Handle operator input
      else if ('+-*/'.contains(buttonText)) {
        firstOperand = double.parse(displayText);
        operator = buttonText;
        isOperatorPressed = true;
      } 
      // Handle equals button
      else if (buttonText == '=') {
        if (operator.isNotEmpty && displayText.isNotEmpty) {
          double secondOperand = double.parse(displayText);
          switch (operator) {
            case '+':
              displayText = (firstOperand + secondOperand).toString();
              break;
            case '-':
              displayText = (firstOperand - secondOperand).toString();
              break;
            case '*':
              displayText = (firstOperand * secondOperand).toString();
              break;
            case '/':
              if (secondOperand == 0) {
                displayText = 'Error'; // Handle division by zero
              } else {
                displayText = (firstOperand / secondOperand).toString();
              }
              break;
          }
          // Remove unnecessary decimal places
          if (displayText.endsWith('.0')) {
            displayText = displayText.substring(0, displayText.length - 2);
          }
          operator = '';
        }
      }
    });
  }

  // Builds each button for the calculator
  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(buttonText, style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(displayText, style: TextStyle(fontSize: 48)),
          ),
          Row(children: [
            buildButton('7'),
            buildButton('8'),
            buildButton('9'),
            buildButton('/'),
          ]),
          Row(children: [
            buildButton('4'),
            buildButton('5'),
            buildButton('6'),
            buildButton('*'),
          ]),
          Row(children: [
            buildButton('1'),
            buildButton('2'),
            buildButton('3'),
            buildButton('-'),
          ]),
          Row(children: [
            buildButton('C'),
            buildButton('0'),
            buildButton('='),
            buildButton('+'),
          ]),
          Row(children: [
            buildButton('.'),
          ]),
        ],
      ),
    );
  }
}
