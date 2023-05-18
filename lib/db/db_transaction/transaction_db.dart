import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/transaction/transaction_model.dart';
import '../db_category/catergory_db.dart';
import 'income_and_expense.dart';

const transactionDbName = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
  Future<void> deleteAllTransaction();
  Future<void> editTransaction(TransactionModel value);
  Future<void> refreshTransAndCat();
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> transactionFilterNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    await db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final list = await getAllTransactions();

    list.sort((first, second) => second.date.compareTo(first.date));

    transactionListNotifier.value.clear();
    transactionFilterNotifier.value.clear();

    transactionListNotifier.value.addAll(list);
    transactionFilterNotifier.value.addAll(list);

    transactionListNotifier.notifyListeners();
    transactionFilterNotifier.notifyListeners();

    incomeAndExpense();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    return db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    await db.delete(id);
    refresh();
  }

  @override
  Future<void> editTransaction(TransactionModel value) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    await db.put(value.id, value);
    refresh();
  }

  @override
  Future<void> deleteAllTransaction() async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    await db.clear();
    await db.close();
    refresh();
  }

  @override
  Future<void> refreshTransAndCat() async {
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refresh();
  }
}