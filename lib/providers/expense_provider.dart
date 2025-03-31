import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;


class ExpenseProvider with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  List<Expense> _expenses = [];
  double _budgetLimit = 500;

  List<Expense> get expenses => _expenses;
  double get budgetLimit => _budgetLimit;
  double get totalSpent =>
      _expenses.fold(0, (sum, e) => sum + e.amount);
  double get budgetProgress =>
      (totalSpent / _budgetLimit).clamp(0.0, 1.0);


  Future<void> loadInitialData() async {
    await fetchExpenses();
    await _loadSavedBudget();
  }

  Future<void> fetchExpenses() async {
    final snapshot = await _firestore.collection('expenses').get();
    _expenses = snapshot.docs
        .map((doc) => Expense.fromMap(doc.id, doc.data()))
        .toList();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    final docRef = await _firestore.collection('expenses').add(expense.toMap());
    _expenses.add(Expense(
      id: docRef.id,
      title: expense.title,
      amount: expense.amount,
      date: expense.date,
    ));
    notifyListeners();
  }

  Future<void> setBudget(double newLimit) async {
  _budgetLimit = newLimit;

  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('budget_limit', newLimit);

  notifyListeners();
  }


  Future<void> _loadSavedBudget() async {
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getDouble('budget_limit');
  if (saved != null) {
    _budgetLimit = saved;
  }

  notifyListeners();
  }


  Future<void> deleteExpense(String id) async {
    await _firestore.collection('expenses').doc(id).delete();
    _expenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
