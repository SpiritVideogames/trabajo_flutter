// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

import '../services/services.dart';
import '../widgets/widgets.dart';

//List<MySlidable> list = [];

class Index2Screen extends StatefulWidget {
  const Index2Screen({
    Key? key,
  }) : super(key: key);

  @override
  State<Index2Screen> createState() => _Index2ScreenState();
}

class _Index2ScreenState extends State<Index2Screen> {
  List<DataUsers> users = [];
  final usersService = UsersServices();
  Future refresh() async {
    setState(() => users.clear());
    final usersService = Provider.of<UsersServices>(context, listen: false);
    await usersService.loadUsers();
    setState(() {
      users = usersService.users;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    final activateService = Provider.of<ActivateServices>(context);
    final deactivateService = Provider.of<DeactivateServices>(context);
    final deleteService = Provider.of<DeleteServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: const ExampleExpandableFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: users.isEmpty
          ? const Center(
              child:
                  SpinKitWave(color: Color.fromRGBO(0, 153, 153, 1), size: 50))
          : RefreshIndicator(
              onRefresh: refresh,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  bool Act;
                  bool Deact;
                  if (users[index].actived == 1) {
                    Act = false;
                    Deact = true;
                  } else {
                    Deact = false;
                    Act = true;
                  }
                  return Container(
                    color: Colors.white,
                    child: Slidable(

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
                                  text:
                                      "Are you sure you want to delete this user?",
                                  showCancelBtn: true,
                                  confirmBtnColor: Colors.red,
                                  confirmBtnText: 'Delete',
                                  onConfirmBtnTap: () {
                                    deleteService
                                        .postDelete(users[index].id.toString());

                                    // IndexScreen().list.removeAt(index);
                                    setState(() {
                                      users.removeAt(index);
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
                              visible: Deact,
                              child: SlidableAction(
                                onPressed: (BuildContext context) {
                                  deactivateService.postDeactivate(
                                      users[index].id.toString());

                                  setState(() {
                                    users[index].actived = 0;
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
                              visible: Act,
                              child: SlidableAction(
                                onPressed: (BuildContext context) {
                                  activateService.postActivate(
                                    users[index].id.toString(),
                                  );

                                  setState(() {
                                    users[index].actived = 1;
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
                          subtitle: Text(users[index].email!),
                          title: Text(
                              '${users[index].firstname!} ${users[index].secondname!}',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 18, 201, 159))),
                          //  subtitle:    (Text(_Index2ScreenState().users[index].email!)),
                          leading: const Icon(Icons.account_circle_rounded,
                              size: 45),
                        )),
                  );
                },
                itemCount: users.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 0.5,
                      color: const Color.fromARGB(255, 18, 201, 159));
                },
              )),
    );
  }
}
