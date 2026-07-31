import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/party_balance.dart';
import '../models/transaction.dart';
import '../services/extraction_service.dart';
import '../theme/app_theme.dart';
import '../theme/arco_components.dart';
import '../utils/formatters.dart';
import '../utils/transaction_labels.dart';
import '../widgets/type_chip.dart';
import 'transaction_detail_screen.dart';

class PartyBalancesScreen extends StatefulWidget {
  const PartyBalancesScreen({super.key});

  @override
  State<PartyBalancesScreen> createState() => _PartyBalancesScreenState();
}

class _PartyBalancesScreenState extends State<PartyBalancesScreen> {
  late Future<List<PartyBalance>> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<ExtractionService>().getPartyBalances();
  }

  void _refresh() => setState(
    () => _future = context.read<ExtractionService>().getPartyBalances(),
  );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _refresh(),
      child: FutureBuilder<List<PartyBalance>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) return _buildError();
          final parties = snap.data ?? [];
          if (parties.isEmpty) return _buildEmpty();

          final totalOwed = parties.fold(
            0.0,
            (s, p) => s + (p.balance > 0 ? p.balance : 0),
          );
          final totalOwing = parties.fold(
            0.0,
            (s, p) => s + (p.balance < 0 ? p.balance.abs() : 0),
          );

          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s4,
              AppSpacing.s4,
              AppSpacing.s4,
              AppSpacing.s6,
            ),
            children: [
              _SummaryRow(totalOwed: totalOwed, totalOwing: totalOwing),
              const SizedBox(height: AppSpacing.s4),
              ...parties.map(
                (p) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.s3),
                  child: _PartyCard(
                    party: p,
                    onTap: () => _openPartyTransactions(p),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openPartyTransactions(PartyBalance party) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PartyTransactionHistoryScreen(party: party),
      ),
    );
  }

  Widget _buildEmpty() {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.3),
        Column(
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: AppColorsResolver.text3(context),
            ),
            const SizedBox(height: AppSpacing.s4),
            Text(
              'No parties yet',
              style: AppText.bodyLg.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColorsResolver.text3(context),
              ),
            ),
            const SizedBox(height: AppSpacing.s2),
            Text(
              'Confirm a transaction to see\nparty balances here.',
              textAlign: TextAlign.center,
              style: AppText.smallFor(
                context,
              ).copyWith(color: AppColorsResolver.text3(context)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: AppColorsResolver.danger(context),
          ),
          const SizedBox(height: AppSpacing.s3),
          Text(
            'Could not load balances',
            style: AppText.body.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.s2),
          ArcoButton(
            label: 'Retry',
            variant: ArcoButtonVariant.ghost,
            onPressed: _refresh,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final double totalOwed;
  final double totalOwing;

  const _SummaryRow({required this.totalOwed, required this.totalOwing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: 'Owed to iStatis',
            amount: totalOwed,
            color: AppColorsResolver.link(context),
            icon: Icons.arrow_circle_up_outlined,
          ),
        ),
        const SizedBox(width: AppSpacing.s3),
        Expanded(
          child: _SummaryCard(
            label: 'iStatis Owes',
            amount: totalOwing,
            color: AppColorsResolver.warning(context),
            icon: Icons.arrow_circle_down_outlined,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;
  final IconData icon;

  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: AppDecorations.semanticTint(context, color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: AppSpacing.s2),
              Text(label, style: AppText.chip.copyWith(color: color)),
            ],
          ),
          const SizedBox(height: AppSpacing.s2),
          Text(
            'PKR ${formatPkr(amount)}',
            style: AppText.bodyLg.copyWith(
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _PartyCard extends StatelessWidget {
  final PartyBalance party;
  final VoidCallback onTap;

  const _PartyCard({required this.party, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final name = party.nameRoman ?? party.nameUrdu ?? 'Unknown';
    final balance = party.balance;
    final isOwed = balance >= 0;
    final balanceColor = isOwed
        ? AppColorsResolver.link(context)
        : AppColorsResolver.warning(context);
    final lastDate = formatTxDateOptional(party.lastTransactionDate);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: AppDecorations.card(context),
        padding: const EdgeInsets.all(AppSpacing.s4),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 52,
              decoration: BoxDecoration(
                color: balanceColor,
                borderRadius: AppRadius.rXs,
              ),
            ),
            const SizedBox(width: AppSpacing.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppText.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: AppSpacing.s1),
                  Row(
                    children: [
                      Text(
                        '${party.transactionCount} transactions',
                        style: AppText.caption,
                      ),
                      if (lastDate != null) ...[
                        Text('  ·  ', style: AppText.caption),
                        Text('Last: $lastDate', style: AppText.caption),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'PKR ${formatPkr(balance, absolute: true)}',
                  style: AppText.body.copyWith(
                    fontWeight: FontWeight.w800,
                    color: balanceColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isOwed ? 'owes iStatis' : 'iStatis owes',
                  style: AppText.caption.copyWith(
                    color: balanceColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.s2),
            Icon(
              Icons.chevron_right,
              color: AppColorsResolver.text3(context),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class PartyTransactionHistoryScreen extends StatefulWidget {
  final PartyBalance party;

  const PartyTransactionHistoryScreen({super.key, required this.party});

  @override
  State<PartyTransactionHistoryScreen> createState() =>
      _PartyTransactionHistoryScreenState();
}

class _PartyTransactionHistoryScreenState
    extends State<PartyTransactionHistoryScreen> {
  late Future<List<TransactionSummary>> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<ExtractionService>().getTransactions(
      partyId: widget.party.partyId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.party.nameRoman ?? widget.party.nameUrdu ?? 'Unknown';
    final balance = widget.party.balance;
    final isOwed = balance >= 0;
    final balanceColor = isOwed
        ? AppColorsResolver.link(context)
        : AppColorsResolver.warning(context);

    return Scaffold(
      backgroundColor: AppColorsResolver.canvas(context),
      appBar: ArcoTopBar(
        title: name,
        subtitle:
            '${isOwed ? "Owes" : "Owed"} PKR ${formatPkr(balance, absolute: true)}',
        showBrand: false,
      ),
      body: FutureBuilder<List<TransactionSummary>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: balanceColor),
            );
          }
          if (snap.hasError) {
            return Center(
              child: Text(
                'Could not load.',
                style: AppText.smallFor(
                  context,
                ).copyWith(color: AppColorsResolver.text3(context)),
              ),
            );
          }
          final txs = snap.data ?? [];
          if (txs.isEmpty) {
            return Center(
              child: Text(
                'No transactions found.',
                style: AppText.smallFor(
                  context,
                ).copyWith(color: AppColorsResolver.text3(context)),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.s4),
            itemCount: txs.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s3),
            itemBuilder: (_, i) => _PartyTxRow(tx: txs[i]),
          );
        },
      ),
    );
  }
}

class _PartyTxRow extends StatelessWidget {
  final TransactionSummary tx;

  const _PartyTxRow({required this.tx});

  @override
  Widget build(BuildContext context) {
    final txType = tx.transactionType ?? 'sale';
    final color = txTypeColor(context, txType);
    final label = txTypeLabel(txType);
    final isCredit = txType == 'payment_received';

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TransactionDetailScreen(
            transactionId: tx.id,
            initialPartyName: tx.partyNameRoman ?? tx.partyNameUrdu,
          ),
        ),
      ),
      child: Container(
        decoration: AppDecorations.card(context),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s4,
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 44,
              decoration: BoxDecoration(
                color: color,
                borderRadius: AppRadius.rXs,
              ),
            ),
            const SizedBox(width: AppSpacing.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ArcoTypeChip(label: label, color: color),
                      const SizedBox(width: AppSpacing.s2),
                      Text(
                        formatTxDate(tx.transactionDate),
                        style: AppText.caption,
                      ),
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
                '${isCredit ? "-" : "+"}PKR ${formatPkr(tx.totalAmount!)}',
                style: AppText.body.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isCredit
                      ? AppColorsResolver.success(context)
                      : AppColorsResolver.link(context),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
