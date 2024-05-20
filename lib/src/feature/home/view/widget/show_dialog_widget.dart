import '../../../../controller/read_data/read_data_cubit.dart';
import '../../../../controller/write_data/write_data_cubit.dart';
import '../../../../controller/write_data/write_data_state.dart';
import 'ar_or_en_widget.dart';
import 'custom_button.dart';
import 'custom_form.dart';
import 'list_color_widget.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowDialogWidget extends StatefulWidget {
  const ShowDialogWidget({super.key});

  @override
  State<ShowDialogWidget> createState() => _ShowDialogWidgetState();
}

class _ShowDialogWidgetState extends State<ShowDialogWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: BlocConsumer<WriteDataCubit, WriteDataState>(
      listener: (context, state) {
        if (state is WriteDataSuccess) {
          Navigator.pop(context);
          ReadDataCubit.get(context).getAllWords();
          AppDialog.showSnackBar(context, "Done");
        } else if (state is WriteDataError) {
          AppDialog.showSnackBar(context, state.messageError);
        }
      },
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.whiteColor,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Color(WriteDataCubit.get(context).colorCode),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArOrEnWidget(
                  arabicIsSelected: WriteDataCubit.get(context).isArabic,
                  colorCode: WriteDataCubit.get(context).colorCode,
                ),
                const SizedBox(height: 15),
                ListColorWidget(
                    activeColorCode: WriteDataCubit.get(context).colorCode),
                const SizedBox(height: 20),
                CustomForm(
                  formKey: formKey,
                  label: "New Word",
                ),
                const SizedBox(height: 20),
                CustomButton(
                  colorCode: WriteDataCubit.get(context).colorCode,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      WriteDataCubit.get(context).addWord();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
