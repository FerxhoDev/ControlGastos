import 'package:flutter/material.dart';
import 'package:gestapp/models/expense_data.dart';
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

    // Nuevo método para obtener ExpenseData
  List<ExpenseData> getExpenseData() {
    // Agrupa las transacciones por categoría y suma los montos
    Map<String, double> expenseMap = {};
    for (var transaction in _transactions) {
      if (transaction.type == TransactionType.expense) {
        expenseMap.update(
          transaction.category,
          (value) => value + transaction.amount,
          ifAbsent: () => transaction.amount,
        );
      }
    }
    
    // Convierte el mapa a una lista de ExpenseData
    return expenseMap.entries
        .map((e) => ExpenseData(e.key, e.value))
        .toList();
  }
  
}