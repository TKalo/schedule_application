

import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';



class CustomTextButton extends StatelessWidget {
  final String title;
  final double textSize;
  final Function onClick;
  final Color color;
  final Color textColor;

  CustomTextButton({this.title, this.textSize, this.onClick, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(80)),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) => color ?? Colors.white.withOpacity(0.75))
        ),
        child: Text(
          title ?? "",
          style: TextStyle(
            color: textColor ?? null,
            fontSize: textSize ?? 20,
          ),
        ),
        onPressed: onClick ?? (){},
      ),
    );
  }
}

class CustomTitleText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color textColor;

  CustomTitleText({this.title, this.fontSize, this.textColor});

  @override
  Widget build(BuildContext context) {
    return //Title
      Text(
        title ?? "",
        style: TextStyle(
          color: textColor ?? Colors.white,
          decoration: TextDecoration.none,
          fontSize: fontSize ?? 42,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.center,
      );
  }
}

class CustomTextField extends StatelessWidget {
  final String title;
  final String text;
  final String hint;
  final Color color;
  final Color colorFill;
  final bool enabled;
  final TextInputType type;
  final void Function(String) onChanged;
  final void Function() onTap;
  final String Function(String string) validator;
  final AutovalidateMode autovalidateMode;


  CustomTextField({this.title, this.text, this.color, this.colorFill, this.enabled, this.hint, this.type, this.onChanged, this.onTap, this.validator, this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onTap: onTap,
      style: TextStyle(
          color: color ?? Colors.white
      ),
      textAlign: TextAlign.center,
      cursorColor: color ?? Colors.white,
      cursorHeight: 24,
      keyboardType: type ?? TextInputType.text,
      initialValue: text,
      validator: validator,
      autovalidateMode: autovalidateMode,
      enabled: enabled ?? true,

      decoration: CustomInputDecoration(title: title, hint: hint, color: color).get()
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final void Function() onTap;

  CustomListTile({this.title, this.icon, this.selected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: ListTile(
          leading: Icon(icon ?? Icons.circle, color: Colors.grey[400],),
          title: Text(
            title.toLowerCase() ?? "",
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.grey[700],
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1
            ),
          ),
          onTap: onTap ?? (){},
          selected: selected,
          selectedTileColor: Colors.blue[500].withOpacity(0.2),
        ),
      ),
    );
  }
}

class CustomUnicornButton extends UnicornButton{
  static UnicornButton getCustomUnicornButton(String title, IconData icon, void Function() onClick, Color backgroundColor){
    return UnicornButton(
      hasLabel: true,
      labelText: title,
      labelFontSize: 18,
      labelBackgroundColor: Colors.transparent,
      labelHasShadow: false,
      currentButton: FloatingActionButton(
        onPressed: onClick,
        child: Icon(icon),
        backgroundColor: backgroundColor,
        mini: true,
      ),
    );
  }
}

class CustomDropDownButton<E> extends StatelessWidget {

  final String title;
  final String hint;
  final Color color;
  final void Function(E) onChanged;
  final E value;
  final List<DropdownMenuItem<E>> items;
  final String Function(E) validator;
  final AutovalidateMode autovalidateMode;

  CustomDropDownButton({this.title, this.hint, this.value, this.items, this.onChanged, this.color, this.validator, this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<E>(
      value: value ?? items[0].value,
      items: items,
      onChanged: onChanged,
      isDense: true,
      elevation: 0,
      validator: validator,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
      decoration: CustomInputDecoration(title: title, hint: hint, color: color).get(),
    );
  }
}

class CustomTimePicker extends StatelessWidget {

  final String title;
  final TimeOfDay time;
  final String hint;
  final Color color;
  final void Function(String) onChanged;
  final String Function(String) validator;
  final bool autoValidate;


  CustomTimePicker({@required this.title, this.time, this.hint, this.color, this.onChanged, this.validator, this.autoValidate});

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      validator: validator,
      autovalidate: autoValidate ?? false ,
      type: DateTimePickerType.time,
      initialValue: time != null ? time.hour.toString() + ":" + time.minute.toString() : '',
      onChanged: onChanged,
      decoration: CustomInputDecoration(title: title, hint: hint, color: color).get()
    );
  }
}

class CustomDatePicker extends StatelessWidget {

  final String title;
  final DateTime date;
  final DateTime minDate;
  final DateTime maxDate;
  final String hint;
  final Color color;
  final void Function(String) onChanged;
  final String Function(String) validator;
  final bool autoValidate;


  CustomDatePicker({@required this.title, this.date, @required this.minDate, @required this.maxDate, this.hint, this.color, this.onChanged, this.validator, this.autoValidate});

  @override
  Widget build(BuildContext context) {

    return DateTimePicker(
      controller: TextEditingController()..text = date != null ? date.toString() : minDate.toString(),
      dateMask: 'dd/MM/yyyy',
      validator: validator,
      autovalidate: autoValidate ?? false,
      firstDate: minDate,
      lastDate: maxDate,
      type: DateTimePickerType.date,
      onChanged: onChanged,
      decoration: CustomInputDecoration(title: title, hint: hint, color: color).get()
    );
  }
}

class CustomInputDecoration{
  final String title;
  final String hint;
  final Color color;
  final Color colorFill;

  CustomInputDecoration({this.title, this.hint, this.color, this.colorFill});

  InputDecoration get(){
    return InputDecoration(
        labelText: title ?? "",
        helperText: hint ?? null,
        alignLabelWithHint: true,
        labelStyle: TextStyle(color: color ?? Colors.white,),
        focusColor: color ?? Colors.white,
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.red..withOpacity(0.8)
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                color: color ?? Colors.white
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                color: color ?? Colors.white
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                color: color ?? Colors.white
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                color: color ?? Colors.white
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),

        filled: true,
        fillColor: colorFill != null ? colorFill.withOpacity(0.1) : Colors.transparent
    );
  }
}


