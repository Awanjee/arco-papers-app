import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../models/extraction_result.dart';
import '../models/party_balance.dart';
import '../models/transaction.dart';

class ExtractionService {
  final Dio _dio;

  ExtractionService(this._dio);

  /// Upload image -> GPT-4o extraction -> returns result for review screen.
  Future<ExtractionResult> extractDocument(XFile imageFile) async {
    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();

    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(bytes, filename: fileName),
    });

    final response = await _dio.post<Map<String, dynamic>>(
      '/extract',
      data: formData,
      options: Options(
        receiveTimeout: const Duration(seconds: 90),
      ),
    );

    return ExtractionResult.fromJson(response.data!);
  }

  Future<Map<String, dynamic>> confirmExtraction({
    required ExtractionResult result,
    String? editedPartyName,
    String? editedDate,
    double? editedTotal,
    String? notes,
    String transactionType = 'sale',
  }) async {
    final payload = {
      'party_name': editedPartyName ?? result.partyName,
      'party_name_urdu': result.partyNameUrdu,
      'transaction_date': editedDate ?? result.date,
      'document_type': result.documentType,
      'transaction_type': transactionType,
      'total_amount': editedTotal ?? result.totals.grandTotal,
      'line_items': result.lineItems.map((i) => i.toJson()).toList(),
      if (notes != null && notes.isNotEmpty) 'notes': notes,
    };

    final response = await _dio.post<Map<String, dynamic>>(
      '/extract/${result.extractionId}/confirm',
      data: payload,
    );
    return response.data!;
  }

  Future<void> rejectExtraction(String extractionId) async {
    await _dio.post<void>('/extract/$extractionId/reject');
  }

  Future<List<TransactionSummary>> getTransactions({String? partyId}) async {
    final response = await _dio.get<List<dynamic>>(
      '/extract/transactions',
      queryParameters: partyId != null ? {'party_id': partyId} : null,
    );
    return (response.data ?? [])
        .map((e) => TransactionSummary.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<TransactionDetail> getTransactionDetail(String transactionId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/extract/transactions/$transactionId',
    );
    return TransactionDetail.fromJson(response.data!);
  }

  Future<List<PartyBalance>> getPartyBalances() async {
    final response =
        await _dio.get<List<dynamic>>('/extract/parties/balances');
    return (response.data ?? [])
        .map((e) => PartyBalance.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
