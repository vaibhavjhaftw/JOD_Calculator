import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_provider.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/icons/appstore.png',
              height: 30,
            ),
            SizedBox(width: 10),
            Text('JOD Calculator', style: TextStyle(fontFamily: 'Poppins')),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showHistory(context, provider.history);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        provider.expression.isEmpty ? '0' : provider.expression,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 48,
                            color: Colors.white),
                      ),
                      Text(
                        provider.result,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                _buildButtonRow(context, ['C', '√', '%', '÷'],
                    isOperator: true),
                _buildButtonRow(context, ['7', '8', '9', '×']),
                _buildButtonRow(context, ['4', '5', '6', '-']),
                _buildButtonRow(context, ['1', '2', '3', '+']),
                _buildButtonRow(context, ['0', '.', '='], lastRow: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context, List<String> texts,
      {bool isOperator = false, bool lastRow = false}) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: texts
            .map((text) => _buildButton(context, text,
                isOperator: isOperator, lastRow: lastRow))
            .toList(),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text,
      {bool isOperator = false, bool lastRow = false}) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);
    bool isZero = text == '0';
    return Expanded(
      flex: isZero ? 2 : 1,
      child: GestureDetector(
        onTap: () {
          if (text == 'C') {
            provider.clear();
          } else if (text == '=') {
            provider.calculate();
          } else if (text == '√') {
            provider.squareRoot();
          } else {
            provider.addExpression(text);
          }
        },
        child: Container(
          margin: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: isOperator ? Colors.orange : Colors.grey[850],
            borderRadius: lastRow
                ? BorderRadius.circular(32.0)
                : BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showHistory(BuildContext context, List<String> history) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('History', style: TextStyle(fontFamily: 'Poppins')),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: history.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(history[index],
                      style: TextStyle(fontFamily: 'Poppins')),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Clear History',
                  style: TextStyle(fontFamily: 'Poppins')),
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<CalculatorProvider>(context, listen: false)
                    .clearHistory();
              },
            ),
            TextButton(
              child: Text('Close', style: TextStyle(fontFamily: 'Poppins')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
