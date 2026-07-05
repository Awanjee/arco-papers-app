import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import '../services/extraction_service.dart';
import '../theme/app_theme.dart';
import '../theme/arco_components.dart';
import '../utils/formatters.dart';
import '../utils/transaction_labels.dart';
import '../widgets/type_chip.dart';
import 'party_balances_screen.dart';
import 'transaction_detail_screen.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  int _tabIndex = 0;
  late Future<List<TransactionSummary>> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<ExtractionService>().getTransactions();
  }

  void _refresh() {
    setState(() {
      _future = context.read<ExtractionService>().getTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ArcoSegTabs(
          labels: const ['Transactions', 'Parties'],
          selectedIndex: _tabIndex,
          onSelected: (i) => setState(() => _tabIndex = i),
        ),
        Expanded(
          child: _tabIndex == 0
              ? _TransactionsTab(future: _future, onRefresh: _refresh)
              : const PartyBalancesScreen(),
        ),
      ],
    );
  }
}

class _TransactionsTab extends StatelessWidget {
  final Future<List<TransactionSummary>> future;
  final VoidCallback onRefresh;

  const _TransactionsTab({
    required this.future,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: FutureBuilder<List<TransactionSummary>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _buildError(context);
          }
          final transactions = snapshot.data ?? [];
          if (transactions.isEmpty) {
            return _buildEmpty(context);
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.s4),
            itemCount: transactions.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s3),
            itemBuilder: (context, i) =>
                _TransactionCard(tx: transactions[i]),
          );
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.3),
        Column(
          children: [
            const Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: AppColors.text3,
            ),
            const SizedBox(height: AppSpacing.s4),
            Text(
              'No transactions yet',
              style: AppText.bodyLg.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.text3,
              ),
            ),
            const SizedBox(height: AppSpacing.s2),
            Text(
              'Import and confirm a document\nto see it here.',
              textAlign: TextAlign.center,
              style: AppText.small.copyWith(color: AppColors.text3),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.danger),
            const SizedBox(height: AppSpacing.s3),
            Text(
              'Could not load transactions',
              style: AppText.body.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.s2),
            ArcoButton(
              label: 'Retry',
              variant: ArcoButtonVariant.ghost,
              onPressed: onRefresh,
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final TransactionSummary tx;

  const _TransactionCard({required this.tx});

  @override
  Widget build(BuildContext context) {
    final party = tx.partyNameRoman ?? tx.partyNameUrdu ?? 'Unknown party';
    final date = formatTxDate(tx.transactionDate);
    final label = docTypeLabel(tx.documentType);
    final chipColor = docTypeColor(tx.documentType);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TransactionDetailScreen(
            transactionId: tx.id,
            initialPartyName: party,
          ),
        ),
      ),
      child: Container(
        decoration: AppDecorations.card(),
        padding: const EdgeInsets.all(AppSpacing.s4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 52,
              decoration: BoxDecoration(
                color: chipColor,
                borderRadius: AppRadius.rXs,
              ),
            ),
            const SizedBox(width: AppSpacing.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    party,
                    style: AppText.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: AppSpacing.s1),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 12,
                        color: AppColors.text3,
                      ),
                      const SizedBox(width: AppSpacing.s1),
                      Text(date, style: AppText.caption),
                      const SizedBox(width: AppSpacing.s3),
                      ArcoTypeChip(label: label, color: chipColor),
                    ],
                  ),
                  if (tx.notes != null && tx.notes!.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.s1),
                    Text(
                      tx.notes!,
                      style: AppText.caption.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (tx.totalAmount != null)
              Text(
                'PKR ${formatPkr(tx.totalAmount!)}',
                style: AppText.body.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
