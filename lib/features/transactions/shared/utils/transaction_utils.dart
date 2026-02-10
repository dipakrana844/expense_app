import 'package:flutter/material.dart' hide DateUtils;
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/enums/transaction_type.dart';

/// Utility class for transaction-related formatting and calculations
class TransactionUtils {
  TransactionUtils._();

  /// Format transaction amount with appropriate sign and color indication
  ///
  /// For income: displays as positive amount with green indicator
  /// For expense: displays as negative amount with red indicator
  static String formatTransactionAmount(TransactionEntity transaction) {
    final formatter = NumberFormat('#,##,##0.00', 'en_IN');
    final amount = formatter.format(transaction.displayAmount);
    
    if (transaction.isIncome) {
      return '+${AppConstants.currencySymbol}$amount';
    } else {
      return '-${AppConstants.currencySymbol}$amount';
    }
  }

  /// Get color indicator for transaction type
  ///
  /// Returns appropriate color based on transaction type for UI display
  static String getColorIndicator(TransactionEntity transaction) {
    return transaction.isIncome ? '🟢' : '🔴';
  }

  /// Calculate net balance from list of transactions
  static double calculateNetBalance(List<TransactionEntity> transactions) {
    return transactions.fold(0.0, (sum, transaction) {
      return transaction.isIncome 
          ? sum + transaction.amount 
          : sum - transaction.amount;
    });
  }

  /// Calculate total income from list of transactions
  static double calculateTotalIncome(List<TransactionEntity> transactions) {
    return transactions
        .where((transaction) => transaction.isIncome)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  /// Calculate total expenses from list of transactions
  static double calculateTotalExpenses(List<TransactionEntity> transactions) {
    return transactions
        .where((transaction) => transaction.isExpense)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  /// Group transactions by date
  static Map<String, List<TransactionEntity>> groupByDate(
      List<TransactionEntity> transactions) {
    final grouped = <String, List<TransactionEntity>>{};
    
    for (final transaction in transactions) {
      final dateKey = transaction.dateKey;
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(transaction);
    }
    
    // Sort each group by time (most recent first within each day)
    for (final entry in grouped.entries) {
      entry.value.sort((a, b) => b.date.compareTo(a.date));
    }
    
    return grouped;
  }

  /// Filter transactions by type
  static List<TransactionEntity> filterByType(
      List<TransactionEntity> transactions, TransactionType? type) {
    if (type == null) return transactions; // Return all if no filter
    
    return transactions.where((transaction) => transaction.type == type).toList();
  }

  /// Get human-readable day of week
  static String getDayOfWeek(DateTime date) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[date.weekday % 7];
  }

  /// Format date for display in transaction list
  static String formatTransactionDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${getDayOfWeek(date)}, ${DateFormat('MMM d').format(date)}';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }

  /// Get appropriate icon for transaction category
  static IconData getCategoryIcon(String category) {
    return IconData(
      AppConstants.categoryIcons[category] ?? 0xe5cc,
      fontFamily: 'MaterialIcons',
    );
  }

  /// Convert expense entity to transaction entity
  static TransactionEntity fromExpense(dynamic expense) {
    return TransactionEntity(
      id: expense.id,
      amount: expense.amount,
      type: TransactionType.expense,
      categoryOrSource: expense.category,
      date: expense.date,
      note: expense.note,
      createdAt: expense.createdAt ?? expense.date,
      updatedAt: expense.updatedAt,
      metadata: expense.metadata,
    );
  }

  /// Convert income entity to transaction entity
  static TransactionEntity fromIncome(dynamic income) {
    return TransactionEntity(
      id: income.id,
      amount: income.amount,
      type: TransactionType.income,
      categoryOrSource: income.source,
      date: income.date,
      note: income.note,
      createdAt: income.createdAt ?? income.date,
      updatedAt: income.updatedAt,
      metadata: income.metadata,
    );
  }

  /// Merge and sort transactions from both sources
  static List<TransactionEntity> mergeTransactions(
      List<dynamic> incomes, List<dynamic> expenses) {
    final transactionList = <TransactionEntity>[];
    
    // Convert incomes
    for (final income in incomes) {
      transactionList.add(fromIncome(income));
    }
    
    // Convert expenses
    for (final expense in expenses) {
      transactionList.add(fromExpense(expense));
    }
    
    // Sort by date descending (newest first)
    transactionList.sort(TransactionEntity.compareByDateDesc);
    
    return transactionList;
  }
}