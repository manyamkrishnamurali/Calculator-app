import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _displayText = '0';
  String _currentExpression = '';
  double _firstOperand = 0.0;
  double _secondOperand = 0.0;
  String _operator = '';

  bool isDarkTheme = true;

  void _appendToDisplay(String value) {
    setState(() {
      if (_displayText == '0' && value != '.') {
        _displayText = value;
      } else {
        _displayText += value;
      }
      _currentExpression += value;
    });
  }

  void _clearDisplay() {
    setState(() {
      _displayText = '0';
      _currentExpression = '';
      _firstOperand = 0.0;
      _secondOperand = 0.0;
      _operator = '';
    });
  }

  void _setOperator(String operator) {
    setState(() {
      _firstOperand = double.parse(_displayText);
      _operator = operator;
      _currentExpression += ' $operator ';
      _displayText = '0';
    });
  }

  void _calculateResult() {
    setState(() {
      _secondOperand = double.parse(_displayText);

      double result = 0.0;
      switch (_operator) {
        case '+':
          result = _firstOperand + _secondOperand;
          break;
        case '-':
          result = _firstOperand - _secondOperand;
          break;
        case '*':
          result = _firstOperand * _secondOperand;
          break;
        case '/':
          if (_secondOperand != 0) {
            result = _firstOperand / _secondOperand;
          } else {
            _displayText = 'Error';
            _currentExpression = '';
            return;
          }
          break;
        default:
          break;
      }

      _displayText = result.toString().endsWith('.0')
          ? result.toStringAsFixed(0)
          : result.toString();
      _currentExpression = '${_currentExpression.trim()} =';
      _firstOperand = 0.0;
      _secondOperand = 0.0;
      _operator = '';
    });
  }

  void _toggleTheme(bool isDark) {
    setState(() {
      isDarkTheme = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        primaryColor: Colors.grey,
        scaffoldBackgroundColor: isDarkTheme ? Colors.black54 : Colors.grey[200],
      ),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: isDarkTheme ? Colors.grey[850]?.withOpacity(0.8) : Colors.grey[300]?.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.wb_sunny_outlined,
                                  color: isDarkTheme ? Colors.grey : Colors.yellow,
                                ),
                                onPressed: () => _toggleTheme(false),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.dark_mode_outlined,
                                  color: isDarkTheme ? Colors.blue : Colors.grey,
                                ),
                                onPressed: () => _toggleTheme(true),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _currentExpression,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SFPro',
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      _displayText,
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SFPro',
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: isDarkTheme ? Colors.grey[900]?.withOpacity(0.9) : Colors.grey[300]?.withOpacity(0.8),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton(
                        text: 'AC',
                        onPressed: _clearDisplay,
                        isDarkTheme: isDarkTheme,
                        textColor: Colors.blue[400],
                        textSize: 32,
                      ),
                      CalculatorButton(
                        text: '±',
                        onPressed: _clearDisplay,
                        textSize: 34,
                        textColor: Colors.blue[400],
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '%',
                        onPressed: () {},
                        textColor: Colors.blue[400],
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '÷',
                        onPressed: () => _setOperator('/'),
                        isDarkTheme: isDarkTheme,
                        textColor: Colors.red[400],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton(
                        text: '7',
                        onPressed: () => _appendToDisplay('7'),
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '8',
                        onPressed: () => _appendToDisplay('8'),
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '9',
                        onPressed: () => _appendToDisplay('9'),
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '×',
                        onPressed: () => _setOperator('*'),
                        isDarkTheme: isDarkTheme,
                        textSize: 34,
                        textColor: Colors.red[400],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton(
                        text: '4',
                        onPressed: () => _appendToDisplay('4'),
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '5',
                        onPressed: () => _appendToDisplay('5'),
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '6',
                        onPressed: () => _appendToDisplay('6'),
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '-',
                        onPressed: () => _setOperator('-'),
                        isDarkTheme: isDarkTheme,
                        textSize: 34,
                        textColor: Colors.red[400],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton(
                        text: '1',
                        onPressed: () => _appendToDisplay('1'),
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '2',
                        onPressed: () => _appendToDisplay('2'),
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '3',
                        onPressed: () => _appendToDisplay('3'),
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '+',
                        onPressed: () => _setOperator('+'),
                        isDarkTheme: isDarkTheme,
                        textSize: 34,
                        textColor: Colors.red[400],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton(
                        text: 'C',
                        onPressed: _calculateResult,
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '0',
                        onPressed: () => _appendToDisplay('0'),
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '.',
                        onPressed: () => _appendToDisplay('.'),
                        isDarkTheme: isDarkTheme,
                      ),
                      CalculatorButton(
                        text: '=',
                        onPressed: _calculateResult,
                        isDarkTheme: isDarkTheme,
                        textSize: 34,
                        textColor: Colors.red[400],
                      ),
                    ],
                  ),
                  const SizedBox(height: 45),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isDarkTheme;
  final Color? textColor;
  final double? textSize;

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isDarkTheme,
    this.textColor,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          backgroundColor: isDarkTheme ? Colors.black45 : Colors.grey[300]?.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: textSize ?? 28.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'SFPro',
            color: textColor ?? Colors.grey[800],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
