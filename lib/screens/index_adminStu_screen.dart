import 'package:cool_alert/cool_alert.dart';
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
List<DataUsers> users = [];

Future refresh(BuildContext context) async {
  users.clear();
  final usersService = Provider.of<UsersServices>(context, listen: false);
  usersService.loadUsers();
}

class Index2Screen extends StatefulWidget {
  Index2Screen({
    Key? key,
  }) : super(key: key);

  @override
  State<Index2Screen> createState() => _Index2ScreenState();
}

class _Index2ScreenState extends State<Index2Screen> {
  final _key = GlobalKey<ExpandableFabState>();
  List<DataUsers> usersFinal = [];
  @override
  void initState() {
    super.initState();
    refresh(context);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      final usersService = Provider.of<UsersServices>(context);

      users = usersService.users.cast<DataUsers>();

      for (int i = 0; i < users.length; i++) {
        if (users[i].deleted == 0) {
          usersFinal.add(users[i]);
        }
      }
      if (usersService.isLoading) LoadingScreen();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: const ExampleExpandableFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: RefreshIndicator(
          onRefresh: () async {
            refresh(context);
            Navigator.pushReplacementNamed(context, 'index2');
          },
          child: ListView.builder(
            itemBuilder: (context, index) {
              bool Act;
              bool Deact;
              if (usersFinal[index].actived == 1) {
                Act = false;
                Deact = true;
              } else {
                Deact = false;
                Act = true;
              }
              return MySlidable(
                usersFinal: usersFinal,
                Act: Act,
                Deact: Deact,
                id: usersFinal[index].id.toString(),
                index: index,
                tit: '${usersFinal[index].name} ${usersFinal[index].surname}',
              );
            },
            itemCount: usersFinal.length,
          )),
    );
  }
}

class MySlidable extends StatefulWidget {
  final String tit;
  final bool Act;
  final bool Deact;
  final String id;
  final int index;
  final List<DataUsers> usersFinal;
  const MySlidable({
    Key? key,
    required this.tit,
    required this.id,
    required this.index,
    required this.Act,
    required this.Deact,
    required this.usersFinal,
  }) : super(key: key);

  @override
  State<MySlidable> createState() => _MySlidableState();

  static void goview(String route, BuildContext context) {
    Navigator.pushNamed(context, route);
  }
}

class _MySlidableState extends State<MySlidable> {
  @override
  Widget build(BuildContext context) {
    final activateService = Provider.of<ActivateServices>(context);
    final deactivateService = Provider.of<DeactivateServices>(context);
    final deleteService = Provider.of<DeleteServices>(context);
    bool act = widget.Act;
    bool deact = widget.Deact;
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
              onPressed: (BuildContext _) async {
                await CoolAlert.show(
                  context: context,
                  type: CoolAlertType.warning,
                  title: 'Are you sure?',
                  text: "Are you sure you want to delete this user?",
                  showCancelBtn: true,
                  confirmBtnColor: Colors.red,
                  confirmBtnText: 'Delete',
                  onConfirmBtnTap: () {
                    deleteService.postDelete(widget.id);

                    // IndexScreen().list.removeAt(index);
                    setState(() {
                      widget.usersFinal.removeAt(widget.index);
                      refresh(context);
                    });

                    Navigator.pop(context);
                  },
                  onCancelBtnTap: () {
                    Navigator.pop(context);
                  },
                );
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (BuildContext context) {
                Navigator.pushReplacementNamed(context, 'edit');
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
            Visibility(
              visible: deact,
              child: SlidableAction(
                onPressed: (BuildContext context) {
                  deactivateService.postDeactivate(widget.id);

                  setState(() {
                    widget.usersFinal[widget.index].actived = 0;
                    refresh(context);
                  });
                  //Navigator.restorablePushNamed(context, 'index2');
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.no_accounts_outlined,
                label: 'Deactivate',
              ),
            ),
            Visibility(
              visible: act,
              child: SlidableAction(
                onPressed: (BuildContext context) {
                  activateService.postActivate(widget.id);

                  setState(() {
                    widget.usersFinal[widget.index].actived = 1;
                    refresh(context);
                  });
                  // Navigator.restorablePushNamed(context, 'index2');
                },
                backgroundColor: const Color(0xFF7BC043),
                foregroundColor: Colors.white,
                icon: Icons.check_outlined,
                label: 'Activate',
              ),
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: ListTile(
          title: Text(widget.tit),
        ));
  }
}
