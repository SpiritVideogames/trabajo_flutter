import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MySlidable> list = [];
    list.add(const MySlidable(
      tit: 'Slide1',
    ));
    list.add(const MySlidable(
      tit: 'Slide2',
    ));
    list.add(const MySlidable(
      tit: 'Slide3',
    ));
    list.add(const MySlidable(
      tit: 'Slide4',
    ));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          color: Colors.cyanAccent[50],
          child: ListView.separated(
            itemBuilder: (context, index) => list[index],
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
          ),
        ));
  }
}

class MySlidable extends StatelessWidget {
  final String tit;
  const MySlidable({
    Key? key,
    required this.tit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(

        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            const SlidableAction(
              onPressed: null,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (BuildContext context) {
                Navigator.pushNamed(context, 'edit');
              },
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.manage_accounts_rounded,
              label: 'Edit',
            ),
          ],
        ),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: const ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.

              onPressed: null,
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.done_outline_rounded,
              label: 'Active',
            ),
            SlidableAction(
              onPressed: null,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.no_accounts_rounded,
              label: 'Disactive',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: ListTile(
          title: Text(tit),
        ));
  }

  static void goview(String route, BuildContext context) {
    Navigator.pushNamed(context, route);
  }
}
