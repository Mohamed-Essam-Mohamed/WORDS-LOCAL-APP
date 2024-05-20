import '../../../controller/read_data/read_data_cubit.dart';
import '../../../controller/read_data/read_data_state.dart';
import 'widget/list_color_widget.dart';
import 'widget/show_dialog_widget.dart';
import 'widget/words_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/filter_dialog_button.dart';
import 'widget/language_filter_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "HomeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: AppTextStyle.textStyle26,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.withAlpha(30),
      ),
      body: BlocBuilder<ReadDataCubit, ReadDataState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: const Column(
              children: [
                Row(
                  children: [
                    LanguageFilterWidget(),
                    Spacer(),
                    FilterDialogButton(),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(child: WordsWidget()),
              ],
            ),
          );
        },
      ),
      floatingActionButton: _floatingActionFunction(context),
    );
  }

  FloatingActionButton _floatingActionFunction(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) => ShowDialogWidget(),
      ),
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Icon(
        Icons.add,
        size: 30,
        color: AppColors.blackColor,
      ),
    );
  }
}
