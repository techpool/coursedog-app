import 'package:coursedog_app/models/term.dart';
import 'package:coursedog_app/notifiers/term.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermSelector extends StatelessWidget {
  const TermSelector({super.key});

  @override
  Widget build(BuildContext context) {
    Term? selectedTerm = Provider.of<TermNotifier>(context).selectedTerm;
    return ElevatedButton(
        onPressed: () {},
        child: selectedTerm == null
            ? const Text('Select Term')
            : Text(selectedTerm.displayName));
  }
}
