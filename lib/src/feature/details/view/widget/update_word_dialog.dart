import 'package:app_english/src/utils/app_colors.dart';

import '../../../../controller/read_data/read_data_cubit.dart';
import '../../../../controller/write_data/write_data_cubit.dart';
import '../../../../controller/write_data/write_data_state.dart';
import '../../../home/view/widget/ar_or_en_widget.dart';
import '../../../home/view/widget/custom_button.dart';
import '../../../home/view/widget/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateWordDialog extends StatefulWidget {
  const UpdateWordDialog(
      {super.key,
      required this.isExample,
      required this.colorCode,
      required this.indexAtDatabase});
  final bool isExample;
  final int colorCode;
  final int indexAtDatabase;
  @override
  State<UpdateWordDialog> createState() => _UpdateWordDialogState();
}

class _UpdateWordDialogState extends State<UpdateWordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(30),
      backgroundColor: Color(widget.colorCode),
      child: BlocConsumer<WriteDataCubit, WriteDataState>(
        listener: (context, state) {
          if (state is WriteDataSuccess) {
            Navigator.pop(context);
          }
          if (state is WriteDataError) {
            ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(state));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArOrEnWidget(
                  arabicIsSelected: WriteDataCubit.get(context).isArabic,
                  colorCode: widget.colorCode,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  formKey: _formKey,
                  label: widget.isExample ? "New Example" : "New Similar Word",
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  colorCode: widget.colorCode,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isExample) {
                        WriteDataCubit.get(context)
                            .addExample(widget.indexAtDatabase);
                      } else {
                        WriteDataCubit.get(context)
                            .addSimilarWord(widget.indexAtDatabase);
                      }
                      ReadDataCubit.get(context).getAllWords();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SnackBar _getSnackBar(WriteDataError state) => SnackBar(
      backgroundColor: AppColors.redColor,
      content: Text(
        state.messageError,
      ));
}
