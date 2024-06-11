import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController();
  bool _loading = false;
  String _message = '';

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _loading = true;
      _message = '';
    });

    final card = CreditCard(
      number: _cardNumberController.text,
      expMonth: int.parse(_expiryDateController.text.split('/')[0]),
      expYear: int.parse(_expiryDateController.text.split('/')[1]),
      cvc: _cvvController.text,
    );

    try {
      final token = await StripePayment.createTokenWithCard(card);

      final response = await http.post(
        Uri.parse('https://your-cloud-function-url'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'token': token.tokenId,
          'amount': 1000, // in cents
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _message = 'Payment successful!';
        });
      } else {
        setState(() {
          _message = 'Payment failed: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Payment error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(labelText: 'Card Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cvvController,
                decoration: InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cardHolderNameController,
                decoration: InputDecoration(labelText: 'Card Holder Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card holder name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _loading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _processPayment,
                child: Text('Pay Now'),
              ),
              SizedBox(height: 20),
              if (_message.isNotEmpty) ...[
                Text(
                  _message,
                  style: TextStyle(color: _message.contains('successful') ? Colors.green : Colors.red),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
