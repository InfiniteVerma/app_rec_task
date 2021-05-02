import 'package:flutter/material.dart';

Padding buildDropdown(
    String hintText, List<String> listItems, String val, Function onchanged) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: DropdownButtonFormField(
      hint: Text(hintText),
      items: listItems.map((String indiaState) {
        return new DropdownMenuItem(
            value: indiaState,
            child: Row(
              children: <Widget>[
                Text(
                  indiaState,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ));
      }).toList(),
      onChanged: onchanged,
      value: val,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(color: Color(0xffF8AD9D), width: 2.0)),
      ),
    ),
  );
}
