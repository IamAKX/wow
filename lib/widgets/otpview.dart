import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

String getOtp = controllers.map((item) => item.text).toList().join("");
void clearOtpView() {
  for (var ctrl in controllers) {
    ctrl.text = "";
  }
  focusNode[0].requestFocus();
}

late List<TextEditingController> controllers;
late List<FocusNode> focusNode;

class OtpViews extends StatelessWidget {
  int length = 4;
  bool obSecure = false;
  BoxType boxType;
  Function(String)? onComplete;
  String hintText = '0';
  bool? filled;
  Color? filledColor;
  Color? borderColor;
  Color? textColor;
  TextInputType? keyboardType;
  OtpViews(
      {Key? key,
      this.keyboardType,
      this.filled,
      this.textColor,
      this.filledColor,
      this.borderColor,
      this.boxType = BoxType.circle,
      this.obSecure = false,
      this.length = 4,
      this.onComplete,
      this.hintText = '0'})
      : super(key: key) {
    controllers = List.generate(length, (index) => TextEditingController());
    focusNode = List.generate(length, (index) => FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
          length,
          (index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                color: Colors.white,
                elevation: 10,
                child: SizedBox(
                    width: 50,
                    child: EditText(
                      hint: hintText,
                      keyboardType: keyboardType,
                      filled: filled,
                      textColor: textColor,
                      filledColor: filledColor,
                      boxType: boxType,
                      obscureText: obSecure,
                      focusNode: focusNode[index],
                      controller: controllers[index],
                      onChanged: (v) {
                        if (v.isEmpty) {
                          if (index != 0) {
                            focusNode[index - 1].requestFocus();
                          }
                        } else {
                          if (index != length - 1) {
                            focusNode[index + 1].requestFocus();
                          } else {
                            if (onComplete != null) {
                              onComplete!.call(controllers
                                  .map((item) => item.text)
                                  .toList()
                                  .join(""));
                            }
                          }
                        }
                      },
                    )),
              )),
    );
  }
}

enum BoxType { circle, rounded }

class EditText extends StatelessWidget {
  String? hint;
  BoxType boxType;
  final TextEditingController? controller;
  TextInputType? keyboardType;
  ValueChanged<String>? onChanged;
  int? maxLength;
  FormFieldValidator<String>? validator;
  GestureTapCallback? onTap;
  FocusNode? focusNode;

  bool obscureText;
  bool? filled;
  Color? filledColor;
  Color? borderColor;
  Color? textColor;
  bool? readOnly;
  List<TextInputFormatter>? inputFormatters;
  EditText(
      {Key? key,
      this.hint,
      this.controller,
      this.boxType = BoxType.circle,
      this.keyboardType = TextInputType.number,
      this.onChanged,
      this.maxLength = 1,
      this.filled,
      this.obscureText = false,
      this.filledColor,
      this.textColor = Colors.black,
      this.borderColor,
      this.readOnly,
      this.inputFormatters,
      this.validator,
      this.onTap,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: TextFormField(
        onTap: onTap,
        obscureText: obscureText,
        focusNode: focusNode,
        maxLength: maxLength,
        // validator: validator,
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        // readOnly: readOnly ?? false,
        style: TextStyle(fontSize: 18, color: textColor),
        decoration: InputDecoration(
            filled: filled,
            fillColor: filledColor,
            hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
            contentPadding:
                const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
            counterText: '',
            border: InputBorder.none),
      ),
    );
  }
}
