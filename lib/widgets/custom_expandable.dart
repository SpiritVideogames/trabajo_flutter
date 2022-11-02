import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class CustomExpandable extends StatelessWidget {
  const CustomExpandable({super.key});

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<ExpandableFabState>();
    return ExpandableFab(
      children: [
        FloatingActionButton.small(
          child: const Icon(Icons.logout_rounded),
          onPressed: () {
            final state = _key.currentState;
            if (state != null) {
              debugPrint('isOpen:${state.isOpen}');
              state.toggle();
            }
          },
        ),
      ],
    );
  }
}
