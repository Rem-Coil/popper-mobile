import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/actions/bloc/actions_bloc.dart';
import 'package:popper_mobile/screen/actions/bloc/actions_event.dart';
import 'package:popper_mobile/screen/actions/bloc/actions_state.dart';

class ActionsScreen extends StatefulWidget {
  static const route = '/actions';

  const ActionsScreen({Key? key}) : super(key: key);

  @override
  State<ActionsScreen> createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen> {
  @override
  void initState() {
    BlocProvider.of<ActionsBloc>(context)..add(UpdateListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('История операций'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                padding: EdgeInsets.zero,
                onTap: () {
                  BlocProvider.of<ActionsBloc>(context)
                    ..add(SyncActionsEvent());
                },
                child: ListTile(
                  leading: Icon(Icons.autorenew_rounded),
                  title: Text('Синхронизовать'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<ActionsBloc, ActionsState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.actions.length,
            itemBuilder: (context, index) {
              final action = state.actions[index];
              return ListTile(
                title: Text(describeEnum(action.type)),
                subtitle: Text(action.formattedDate),
                trailing: !action.isSynchronized
                    ? Icon(Icons.warning_amber_outlined, color: Colors.red)
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
