import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_flutter/providers/login_api_provider.dart';
import 'package:trabajo_flutter/screens/screens.dart';

import '../models/models.dart';

import '../services/services.dart';
import '../widgets/widgets.dart';

class IndexScreen extends StatelessWidget {
  final String? token;
  const IndexScreen({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<ExpandableFabState>();

    late List<MySlidable> list = [];

    final usersService = Provider.of<UsersServices>(context);

    List<Datum4> users = usersService.users.cast<Datum4>();

    final n = users.length;

    for (int i = 0; i < n; i++) {
      if (users[i].deleted == 0) {
        if (users[i].actived == 1) {
          list.add(MySlidable(
            tit: users[i].name + ' ' + users[i].surname,
            actived: 'Deactivate',
            bg: Colors.red,
            id: users[i].id.toString(),
            index: i,
          ));
        } else {
          list.add(MySlidable(
            tit: users[i].name + ' ' + users[i].surname,
            actived: 'Activate',
            bg: Color(0xFF7BC043),
            id: users[i].id.toString(),
            index: i,
          ));
        }
      }
    }

    if (usersService.isLoading) return LoadingScreen();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: const ExampleExpandableFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
  final Color bg;
  final String actived;
  final String id;
  final int index;
  const MySlidable({
    Key? key,
    required this.tit,
    required this.actived,
    required this.bg,
    required this.id,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activateService = Provider.of<ActivateServices>(context);
    final deactivateService = Provider.of<DeactivateServices>(context);
    final deleteService = Provider.of<DeleteServices>(context);
    return Slidable(

        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),
          dragDismissible: false,

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (BuildContext context) {
                deleteService.postDelete(id);
              },
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
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.

              onPressed: (BuildContext context) async {
                if (actived == 'Deactivate') {
                  deactivateService.postDeactivate(id);
                } else {
                  activateService.postActivate(id);
                }
              },
              backgroundColor: bg,
              foregroundColor: Colors.white,
              icon: Icons.done_outline_rounded,
              label: actived,
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
