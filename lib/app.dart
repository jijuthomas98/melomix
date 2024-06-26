import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/features/auth/logic/auth_bloc.dart';
import 'package:melomix/features/musicPlayer/logic/music_player_bloc.dart';
import 'package:melomix/features/search/data/repository/search_repository.dart';
import 'package:melomix/features/search/data/repository/search_repository_impl.dart';
import 'package:melomix/features/search/logic/search_bloc.dart';
import 'package:melomix/utils/constants/strings.dart';
import 'package:melomix/services/routers/router_config.dart';
import 'package:melomix/utils/theme.dart';

class Melomix extends StatelessWidget {
  const Melomix({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<SearchRepository>(
            create: (context) => SearchRepositoryImpl(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (_) => AuthBloc()..add(const AuthStatusChecked()),
            ),
            BlocProvider<SearchBloc>(
              create: (context) => SearchBloc(
                RepositoryProvider.of<SearchRepository>(context),
              ),
            ),
            BlocProvider<MusicPlayerBloc>(create: (_) => MusicPlayerBloc())
          ],
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              routerConfig.refresh();
            },
            child: MaterialApp.router(
              title: AppStrings.appName,
              theme: appTheme(),
              themeMode: ThemeMode.dark,
              routerConfig: routerConfig,
              debugShowCheckedModeBanner: false,
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
