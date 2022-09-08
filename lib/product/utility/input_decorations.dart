import 'package:flutter/material.dart';

class ProjectInput extends InputDecoration {
  const ProjectInput(String title)
      : super(
          border: const OutlineInputBorder(),
          labelText: title,
          focusColor: Colors.red,
        );
}
