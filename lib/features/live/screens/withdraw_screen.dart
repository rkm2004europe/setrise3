import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _amountCtrl = TextEditingController();
  String _method = 'paypal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              const Text('سحب الأرباح', style: TextStyle(color: LiveColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              TextField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: LiveColors.text),
                decoration: InputDecoration(
                  hintText: 'المبلغ (بالعملات)',
                  hintStyle: TextStyle(color: LiveColors.text2.withOpacity(0.5)),
                  filled: true,
                  fillColor: LiveColors.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              const Text('طريقة الدفع', style: TextStyle(color: LiveColors.text2, fontSize: 13)),
              const SizedBox(height: 8),
              _buildMethod('paypal', 'PayPal'),
              _buildMethod('bank', 'تحويل بنكي'),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تقديم طلب السحب!')));
                },
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('طلب السحب', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethod(String value, String label) => GestureDetector(
    onTap: () => setState(() => _method = value),
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _method == value ? LiveColors.accent.withOpacity(0.1) : LiveColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _method == value ? LiveColors.accent : LiveColors.border),
      ),
      child: Text(label, style: TextStyle(color: _method == value ? LiveColors.accent : LiveColors.text)),
    ),
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
    const SizedBox(width: 12),
    const Text('سحب الأرباح', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
