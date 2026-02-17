import 'package:uuid/uuid.dart';
import '../../domain/entities/transfer_entity.dart';
import '../../domain/repositories/transfer_repository.dart';
import '../../../../core/services/account_balance_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Use Case: AddTransferUseCase
///
/// Purpose: Handles the business logic for adding new transfer records
/// - Validates transfer data before creation
/// - Coordinates with repository for persistence
/// - Generates unique IDs when needed
class AddTransferUseCase {
  final TransferRepository _repository;
  final Ref? _ref;
  final Uuid _uuid = const Uuid();

  AddTransferUseCase(this._repository, [this._ref]);

  /// Execute the use case to add a new transfer
  /// Returns the created TransferEntity with generated ID
  Future<TransferEntity> execute({
    required double amount,
    required String fromAccount,
    required String toAccount,
    DateTime? date,
    double? fee,
    String? note,
    Map<String, dynamic>? metadata,
  }) async {
    // Validate inputs
    if (amount <= 0) {
      throw Exception('Amount must be greater than 0');
    }

    if (fromAccount.isEmpty) {
      throw Exception('From account is required');
    }

    if (toAccount.isEmpty) {
      throw Exception('To account is required');
    }

    if (fromAccount == toAccount) {
      throw Exception('Cannot transfer to the same account');
    }

    if (fee != null && fee < 0) {
      throw Exception('Fee cannot be negative');
    }

    final now = DateTime.now();
    final transferDate = date ?? now;

    // Validate date is reasonable
    if (transferDate.isAfter(now.add(const Duration(days: 1)))) {
      throw Exception('Date cannot be too far in the future');
    }

    // Validate account balance if ref is available (for balance checking)
    if (_ref != null) {
      final balanceService = _ref.read(accountBalanceServiceProvider);
      final validation = await balanceService.validateTransfer(
        fromAccount: fromAccount,
        amount: amount,
        fee: fee ?? 0.0,
      );
      
      if (!validation.isValid) {
        throw Exception(validation.message);
      }
    }

    // Create transfer entity
    final transfer = TransferEntity(
      id: _uuid.v4(),
      amount: amount,
      fromAccount: fromAccount,
      toAccount: toAccount,
      date: transferDate,
      fee: fee ?? 0.0,
      note: note?.trim().isEmpty == true ? null : note?.trim(),
      createdAt: now,
      metadata: metadata,
    );

    // Validate entity
    final validationError = transfer.validate();
    if (validationError != null) {
      throw Exception(validationError);
    }

    // Persist through repository
    return await _repository.addTransfer(transfer);
  }
}
