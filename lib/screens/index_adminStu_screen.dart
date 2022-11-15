import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:trabajo_flutter/screens/screens.dart';

import '../models/models.dart';

import '../services/services.dart';
import '../widgets/widgets.dart';

//List<MySlidable> list = [];
class Index2Screen extends StatelessWidget {
  const Index2Screen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: ListUser(),
        ));
  }
}

class ListUser extends StatefulWidget {
  const ListUser({super.key});

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  List<DataUsers> users = [];
  bool loading = true;

  void loadUser() async {
    final usersService = Provider.of<UsersServices>(context);
    // usersService.loadUsers();

    setState(() {
      users = usersService.users.cast<DataUsers>();
      loading = false;
    });
  }

  void initState() {
    users = [];
    loading = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadUser();

    return ListView.builder(
      itemBuilder: (context, index) {
        if (users[index].deleted == 0) {
          if (users[index].actived == 1) {
            return MySlidable(
              actived: 'Deactivate',
              bg: Colors.red,
              id: users[index].id.toString(),
              index: index,
              tit: '${users[index].name} ${users[index].surname}',
            );
          } else {
            return MySlidable(
              actived: 'Activate',
              bg: const Color(0xFF7BC043),
              id: users[index].id.toString(),
              index: index,
              tit: '${users[index].name} ${users[index].surname}',
            );
          }
        }
        return MySlidable(
          actived: 'Deactivate',
          bg: Colors.red,
          id: users[index].id.toString(),
          index: index,
          tit: '${users[index].name} ${users[index].surname}',
        );
      },
      itemCount: users.length,
    );
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
              onPressed: (BuildContext _) {
                Alert(
                  context: context,
                  type: AlertType.error,
                  title: 'Are you sure?',
                  desc: "Are you sure you want to delete this user?",
                  buttons: [
                    DialogButton(
                      onPressed: () {
                        deleteService.postDelete(id);
                        // IndexScreen().list.removeAt(index);

                        Navigator.popAndPushNamed(context, 'index2');
                      },
                      width: 120,
                      child: const Text(
                        "DELETE",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                      child: const Text(
                        "CLOSE",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ).show();
              },
              backgroundColor: const Color(0xFFFE4A49),
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
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.

              onPressed: (BuildContext context) async {
                if (actived == 'Deactivate') {
                  final lista = IndexScreen();

                  deactivateService.postDeactivate(id);
                  /*
                  lista.list[index] = MySlidable(
                    tit: tit,
                    actived: 'Activate',
                    bg: const Color(0xFF7BC043),
                    id: id,
                    index: index,
                  );*/
                  Navigator.popAndPushNamed(context, 'index2');
                } else {
                  final lista = IndexScreen();
                  activateService.postActivate(id);
                  /*
                  lista.list[index] = MySlidable(
                    tit: tit,
                    actived: 'Deactivate',
                    bg: Colors.red,
                    id: id,
                    index: index,
                  );*/
                  Navigator.popAndPushNamed(context, 'index2');
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
