import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider extends ChangeNotifier {
  String _expression = '';
  String _result = '0';
  List<String> _history = [];

  String get expression => _expression;
  String get result => _result;
  List<String> get history => _history;

  void addExpression(String value) {
    if (value == '%') {
      if (_expression.isNotEmpty) {
        _expression = (double.parse(_expression) / 100).toString();
      }
    } else if (value == '÷') {
      _expression += '/';  // Convert division symbol to '/'
    } else if (value == '×') {
      _expression += '*';  // Convert multiplication symbol to '*'
    } else {
      _expression += value;
    }
    notifyListeners();
  }

  void clear() {
    _expression = '';
    _result = '0';
    notifyListeners();
  }

  void calculate() {
    try {
      _result = _evaluateExpression(_expression).toString();
      if (_result == 'NaN') {
        _result = 'Error';  // Handle NaN as an error
      }
      _addToHistory(_expression + ' = ' + _result);
      _expression = _result;
    } catch (e) {
      _result = 'Error';
    }
    notifyListeners();
  }

  void squareRoot() {
    try {
      _result = _evaluateExpression('sqrt($_expression)').toString();
      if (_result == 'NaN') {
        _result = 'Error';  // Handle NaN as an error
      }
      _addToHistory('√$_expression = ' + _result);
      _expression = _result;
    } catch (e) {
      _result = 'Error';
    }
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  void _addToHistory(String calculation) {
    if (_history.length >= 10) {
      _history.removeAt(0);
    }
    _history.add(calculation);
    notifyListeners();
  }

  double _evaluateExpression(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      print('Error evaluating expression: $e');
      return double.nan;  // Return NaN to indicate an error
    }
  }
}
