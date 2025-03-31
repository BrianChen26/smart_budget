import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';
import 'add_expense_screen.dart';
import 'package:intl/intl.dart';
import '../widgets/budget_bar.dart';
import '../providers/expense_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final expenses = expenseProvider.expenses;

    void _editBudget() {
      showDialog(
        context: context,
        builder: (context) {
          final _controller = TextEditingController();
          return AlertDialog(
            title: const Text("Set Monthly Budget"),
            content: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Enter budget amount"),
              onSubmitted: (value) {
                final input = double.tryParse(value);
                if (input != null) {
                  expenseProvider.setBudget(input);
                }
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final input = double.tryParse(_controller.text);
                  if (input != null) {
                    expenseProvider.setBudget(input);
                  }
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Budget"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: BudgetBar(
              progress: expenseProvider.budgetProgress,
              total: expenseProvider.totalSpent,
              limit: expenseProvider.budgetLimit,
              onEdit: _editBudget,
            ),
          ),
          Expanded(
            child: expenses.isEmpty
                ? const Center(child: Text("No expenses yet."))
                : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      Expense e = expenses[index];
                      return Dismissible(
                        key: Key(e.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          expenseProvider.deleteExpense(e.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${e.title} deleted")),
                          );
                        },
                        child: ListTile(
                          title: Text(e.title),
                          subtitle: Text(DateFormat.yMMMd().format(e.date)),
                          trailing: Text("\$${e.amount.toStringAsFixed(2)}"),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddExpenseScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
