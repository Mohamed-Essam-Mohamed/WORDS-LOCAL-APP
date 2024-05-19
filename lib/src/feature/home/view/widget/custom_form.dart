import 'dart:ui';

import 'package:app_english/src/controller/write_data/write_data_cubit.dart';
import 'package:app_english/src/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, required this.formKey, required this.label});

  final String label;
  final GlobalKey<FormState> formKey;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        controller: textEditingController,
        minLines: 1,
        maxLines: 2,
        cursorColor: AppColors.whiteColor,
        style: const TextStyle(color: AppColors.whiteColor),
        decoration: _getInputDecoration(),
        onChanged: (value) => WriteDataCubit.get(context).updateText(value),
        validator: (value) {
          return _validator(
            value,
            WriteDataCubit.get(context).isArabic,
          );
        },
      ),
    );
  }

  String? _validator(String? value, bool isArabic) {
    if (value == null || value.trim().length == 0) {
      return "This Field Has not to be empty";
    }

    for (var i = 0; i < value.length; i++) {
      CharType charType = _getCharType(value.codeUnitAt(i));
      if (charType == CharType.notValid) {
        return "Char Number ${i + 1} Not Valid";
      } else if (charType == CharType.arabic && isArabic == false) {
        return "Char Number ${i + 1} is not english Char";
      } else if (charType == CharType.english && isArabic == true) {
        return "Char Number ${i + 1} is not arabic Char";
      }
    }
    return null;
  }

  CharType _getCharType(int asciCode) {
    if ((asciCode >= 65 && asciCode <= 90) ||
        (asciCode >= 97 && asciCode <= 122)) {
      return CharType.english;
    } else if (asciCode >= 1569 && asciCode <= 1610) {
      return CharType.arabic;
    } else if (asciCode == 32) {
      return CharType.space;
    }
    return CharType.notValid;
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      label: Text(
        widget.label,
        style: const TextStyle(color: AppColors.whiteColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.whiteColor, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}

enum CharType {
  arabic,
  english,
  space,
  notValid,
}
