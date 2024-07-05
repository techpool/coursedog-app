import 'package:coursedog_app/components/common/bottomsheet_topbar.dart';
import 'package:coursedog_app/models/term.dart';
import 'package:coursedog_app/notifiers/term.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TermSelectorDropdown extends StatelessWidget {
  const TermSelectorDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const BottomsheetTopbar(title: 'Select your term'),
        Provider.of<TermNotifier>(context).terms.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  itemCount: Provider.of<TermNotifier>(context).terms.length,
                  itemBuilder: (context, index) {
                    Term term = Provider.of<TermNotifier>(context)
                        .terms
                        .reversed
                        .toList()[index];
                    String? selectedTermId =
                        Provider.of<TermNotifier>(context).selectedTermId;

                    return ListTile(
                      selectedTileColor: Theme.of(context).colorScheme.primary,
                      selectedColor: Theme.of(context).colorScheme.onPrimary,
                      selected: selectedTermId == term.id,
                      title: Text(term.displayName),
                      trailing: Text(term.startDate.toString().split(' ')[0]),
                      onTap: () {
                        Provider.of<TermNotifier>(context, listen: false)
                            .selectTerm(term.id);
                      },
                    );
                  },
                ),
              )
      ],
    );
  }
}

void openTermSelectorModal(BuildContext context) {
  Get.bottomSheet(const TermSelectorDropdown(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
      ignoreSafeArea: false);
}
