import 'package:to_do_project/presentation/auth/bloc/auth_bloc.dart';
import 'package:to_do_project/presentation/auth/login_screen.dart';
import 'package:to_do_project/service_locator.dart';
import 'package:to_do_project/utlis/shared_preference.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Пример статистики
    const completedTasks = 42;
    const totalTasks = 50;
    const completionRate = completedTasks / totalTasks * 100;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'profile.title'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'profile.settings'.tr(),
            onPressed: () {
              // Open settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            // Аватар и информация о пользователе
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      'АП',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
              sharedPreference.getUser()?.email ?? 'profile.not_authorized'.tr(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
                  const SizedBox(height: 4),
                  
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                     onPressed: () {
                        serviceLocator<AuthCubit>().signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false);
                      },
              label: Text('profile.logout'.tr()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Статистика
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: theme.colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.bar_chart),
                        const SizedBox(width: 8),
                        Text(
                          'profile.statistics.title'.tr(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          context,
                          'profile.statistics.completed_tasks'.tr(),
                          '$completedTasks',
                          Icons.task_alt,
                          Colors.green,
                        ),
                        _buildStatItem(
                          context,
                          'profile.statistics.total_tasks'.tr(),
                          '$totalTasks',
                          Icons.assignment,
                          Colors.blue,
                        ),
                        _buildStatItem(
                          context,
                          'profile.statistics.completion_rate'.tr(),
                          '${completionRate.toStringAsFixed(0)}%',
                          Icons.insights,
                          Colors.purple,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('profile.statistics.progress'.tr()),
                            Text('$completedTasks ${'profile.statistics.of'.tr()} $totalTasks'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: completedTasks / totalTasks,
                            minHeight: 10,
                            backgroundColor: theme.colorScheme.surfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Предпочтения и настройки
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: theme.colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text('profile.menu.language'.tr()),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text('profile.languages.english'.tr()),
                                onTap: () {
                                  context.setLocale(const Locale('en'));
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: Text('profile.languages.russian'.tr()),
                                onTap: () {
                                  context.setLocale(const Locale('ru'));
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: Text('profile.languages.kazakh'.tr()),
                                onTap: () {
                                  context.setLocale(const Locale('kk'));
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }
}