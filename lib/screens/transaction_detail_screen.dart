import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import '../services/extraction_service.dart';
import '../theme/app_theme.dart';
import '../theme/arco_components.dart';
import '../utils/formatters.dart';
import '../utils/transaction_labels.dart';
import '../widgets/type_chip.dart';

class TransactionDetailScreen extends StatefulWidget {
  final String transactionId;
  final String? initialPartyName;

  const TransactionDetailScreen({
    super.key,
    required this.transactionId,
    this.initialPartyName,
  });

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  late Future<TransactionDetail> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<ExtractionService>().getTransactionDetail(
      widget.transactionId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsResolver.canvas(context),
      appBar: ArcoTopBar(
        title: widget.initialPartyName ?? 'Transaction',
        showBrand: false,
      ),
      body: FutureBuilder<TransactionDetail>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColorsResolver.link(context),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
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
                      'Could not load transaction details',
                      style: AppText.body.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          }

          final tx = snapshot.data!;
          return _TransactionDetailBody(tx: tx);
        },
      ),
    );
  }
}

class _TransactionDetailBody extends StatelessWidget {
  final TransactionDetail tx;

  const _TransactionDetailBody({required this.tx});

  @override
  Widget build(BuildContext context) {
    final txType = tx.transactionType ?? 'sale';
    final txColor = txTypeColor(context, txType, detailScreen: true);
    final txLabel = txTypeLabel(txType);
    final docLabel = docTypeLabel(tx.documentType);
    final party = tx.partyNameRoman ?? tx.partyNameUrdu ?? 'Unknown party';
    final date = formatTxDate(tx.transactionDate);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.s4),
      children: [
        ArcoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      party,
                      style: AppText.bodyLg.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ArcoTypeChip(label: txLabel, color: txColor),
                ],
              ),
              if (tx.partyNameUrdu != null &&
                  tx.partyNameUrdu != tx.partyNameRoman) ...[
                const SizedBox(height: AppSpacing.s1),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    tx.partyNameUrdu!,
                    style: AppText.urdu(
                      color: AppColorsResolver.text2(context),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.s3),
              const ArcoDivider(),
              const SizedBox(height: AppSpacing.s3),
              _MetaRow(icon: Icons.calendar_today_outlined, label: date),
              const SizedBox(height: AppSpacing.s2),
              _MetaRow(icon: Icons.description_outlined, label: docLabel),
              if (tx.notes != null && tx.notes!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.s2),
                _MetaRow(
                  icon: Icons.notes_outlined,
                  label: tx.notes!,
                  italic: true,
                ),
              ],
              const SizedBox(height: AppSpacing.s3),
              const ArcoDivider(),
              const SizedBox(height: AppSpacing.s3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: AppText.label),
                  Text(
                    tx.totalAmount != null
                        ? 'PKR ${formatPkr(tx.totalAmount!)}'
                        : 'N/A',
                    style: AppText.h3.copyWith(color: txColor),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        if (tx.lineItems.isEmpty)
          ArcoCard(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.s6),
                child: Text(
                  'No line items recorded',
                  style: AppText.smallFor(
                    context,
                  ).copyWith(color: AppColorsResolver.text3(context)),
                ),
              ),
            ),
          )
        else ...[
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.s1,
              bottom: AppSpacing.s2,
            ),
            child: Text(
              'Line Items (${tx.lineItems.length})',
              style: AppText.overline,
            ),
          ),
          ArcoCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s4,
                    vertical: AppSpacing.s3,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text('PRODUCT', style: AppText.overline),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'QTY × PRICE',
                          textAlign: TextAlign.center,
                          style: AppText.overline,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'AMOUNT',
                          textAlign: TextAlign.right,
                          style: AppText.overline,
                        ),
                      ),
                    ],
                  ),
                ),
                const ArcoDivider(),
                ...tx.lineItems.asMap().entries.map((entry) {
                  final isLast = entry.key == tx.lineItems.length - 1;
                  return _LineItemRow(
                    item: entry.value,
                    isLast: isLast,
                    txColor: txColor,
                  );
                }),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.s8),
      ],
    );
  }
}

class _LineItemRow extends StatelessWidget {
  final TransactionLineItem item;
  final bool isLast;
  final Color txColor;

  const _LineItemRow({
    required this.item,
    required this.isLast,
    required this.txColor,
  });

  @override
  Widget build(BuildContext context) {
    final code = expandProductCode(item.productCode);
    final desc = item.description?.trim();
    final lowConfidence = item.confidence != null && item.confidence! < 0.6;

    final qtyStr = item.quantity?.toStringAsFixed(
      item.quantity! == item.quantity!.truncateToDouble() ? 0 : 1,
    );
    final priceStr = item.unitPrice != null
        ? formatAmount(item.unitPrice!)
        : null;
    final qtyPrice = (qtyStr != null && priceStr != null)
        ? '$qtyStr × $priceStr'
        : null;
    final amountStr = item.amount != null ? formatAmount(item.amount!) : null;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4,
            vertical: AppSpacing.s3,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (lowConfidence)
                          Padding(
                            padding: const EdgeInsets.only(
                              right: AppSpacing.s1,
                            ),
                            child: Icon(
                              Icons.warning_amber_rounded,
                              size: 13,
                              color: AppColorsResolver.warning(context),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            code,
                            style: AppText.body.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (item.productCode != null)
                      Text(item.productCode!, style: AppText.caption),
                    if (desc != null && desc.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          desc,
                          style: AppText.caption.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    if (item.notes != null && item.notes!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          item.notes!,
                          style: AppText.caption.copyWith(
                            color: AppColorsResolver.warning(context),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  qtyPrice ?? (qtyStr ?? ''),
                  textAlign: TextAlign.center,
                  style: AppText.small,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  amountStr ?? '',
                  textAlign: TextAlign.right,
                  style: AppText.small.copyWith(
                    fontWeight: FontWeight.w600,
                    color: txColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const ArcoDivider(indent: AppSpacing.s4, endIndent: AppSpacing.s4),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool italic;

  const _MetaRow({
    required this.icon,
    required this.label,
    this.italic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColorsResolver.text3(context)),
        const SizedBox(width: AppSpacing.s2),
        Expanded(
          child: Text(
            label,
            style: AppText.small.copyWith(
              color: AppColorsResolver.text3(context),
              fontStyle: italic ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}
