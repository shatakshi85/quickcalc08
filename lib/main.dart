import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: const CalculatorScreen(),
      theme: ThemeData.dark(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = "0";
  bool resultDisplayed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  display,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              ),
            ),

          Expanded(
            flex: 5,
            child: Center(
              child: SizedBox(
                width: 450,
                child: GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: 1.2,
                  children: [
                    buildButton("C"),
                    buildButton("DEL"),
                    buildButton("%"),
                    buildButton("/"),
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("*"),
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("-"),
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("+"),
                    buildButton("0"),
                    buildButton("."),
                    buildButton("="),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String label) {
    Color buttonColor = Colors.grey.shade800;

  if (["+", "-", "*", "/", "="].contains(label)) {
    buttonColor = Colors.orange;
  }

  if (label == "C" || label == "DEL") {
    buttonColor = Colors.red;
  }
  
  return Container(
  margin: const EdgeInsets.all(8),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    elevation: 8,
    backgroundColor: buttonColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
        onPressed: () {
  setState(() {

    if (label == "C") {
      display = "0";
      return;
    }
    if (label == "DEL") {
      if (display.length > 1) {
        display = display.substring(0, display.length - 1);
      } else {
        display = "0";
      }
      return;
    }
    if (label == "%") {
      try {
        double value = double.parse(display);
        display = (value / 100).toString();
        resultDisplayed = true;
      }catch (e) {
          display = "Error";
      }
    return;
}

    if (label == "=") {
      try {
        Parser p = Parser();
        Expression exp = p.parse(display);

        ContextModel cm = ContextModel();

        double result =
            exp.evaluate(EvaluationType.REAL, cm);

        display = result.toString();
        resultDisplayed = true;
      } catch (e) {
        display = "Error";
      }

      return;
    }

    if (resultDisplayed && !["+", "-", "*", "/"].contains(label)) {
      display = label;
      resultDisplayed = false;
    }
    else if (display == "0") {
      display = label;
    }
    else {
      display += label;
    }
  });
},
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}


