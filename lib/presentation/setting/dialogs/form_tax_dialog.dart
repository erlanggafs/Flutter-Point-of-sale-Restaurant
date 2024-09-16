import 'package:flutter/material.dart';
import 'package:flutter_posresto_app_v2/core/extensions/build_context_ext.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../models/tax_model.dart';

class FormTaxDialog extends StatelessWidget {
  final TaxModel? data;
  const FormTaxDialog({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final shippingFeeController = TextEditingController();
    final serviceFeeController = TextEditingController();
    final taxFeeController = TextEditingController();
    final isShipping = ValueNotifier<bool>(false);
    final isService = ValueNotifier<bool>(false);
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close),
          ),
          Text(data == null
              ? 'Tambah Perhitungan Biaya'
              : 'Edit Perhitungan Biaya'),
          const Spacer(),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: context.deviceWidth / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: serviceFeeController,
                label: 'Biaya Layanan',
                onChanged: (value) {},
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(Icons.percent),
              ),
              const SpaceHeight(24.0),
              CustomTextField(
                controller: taxFeeController,
                label: 'Pajak',
                onChanged: (value) {},
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(Icons.percent),
              ),
              const SpaceHeight(24.0),
              Button.filled(
                onPressed: () {
                  if (data == null) {
                    // TODO: do add Perhitungan Biaya
                  } else {
                    // TODO: do edit Perhitungan Biaya
                  }
                  context.pop();
                },
                label: data == null ? 'Simpan' : 'Perbarui',
              )
            ],
          ),
        ),
      ),
    );
  }
}
