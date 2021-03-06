import 'package:contacts_flutter/global/logging_bloc_delegate.dart';
import 'package:contacts_flutter/presentation/screen/contact_details/contact_details_screen.dart';
import 'package:contacts_flutter/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';
import 'global/di/di_container.dart' as di;
import 'global/di/di_container.dart';
import 'global/screens.dart';
import 'presentation/bloc/contacts/bloc.dart';
import 'presentation/screen/contacts/contacts_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = LoggingBlocDelegate();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Contacts',
      theme: appTheme,
      initialRoute: Screens.InitialRoute,
      routes: {
        Screens.InitialRoute: (_) => BlocProvider<ContactsBloc>(
              create: (_) => sl<ContactsBloc>()..add(FetchContacts()),
              child: ContactsScreen(),
            ),
        Screens.Details: (_) => ContactDetailsScreen()
      },
    );
  }
}
