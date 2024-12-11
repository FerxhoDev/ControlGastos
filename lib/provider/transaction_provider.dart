import 'package:flutter/material.dart';
import 'package:gestapp/models/transaction.dart';

class TransactionProvider with ChangeNotifier{

  final List<Transaction> _transactions = [];


  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction transaction){
    _transactions.add(transaction);
    notifyListeners();
  }

  void removeTransaction(Transaction transaction){
    _transactions.removeWhere((transaction) => transaction.id == transaction.id);
    notifyListeners();
  }
}