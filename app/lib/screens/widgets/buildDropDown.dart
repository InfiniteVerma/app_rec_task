import 'package:flutter/material.dart';

Padding buildDropdown(
    String hintText, List<String> listItems, String val, Function onchanged) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: DropdownButtonFormField(
      hint: Text(hintText),
      items: listItems.map((String category) {
        return new DropdownMenuItem(
            value: category,
            child: Row(
              children: <Widget>[
                Text(category),
              ],
            ));
      }).toList(),
      onChanged: onchanged,
      value: val,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    ),
  );
}
