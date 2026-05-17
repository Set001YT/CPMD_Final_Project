import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../favorites/presentation/providers/favorites_providers.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final favCount = ref.watch(favoritesStreamProvider).valueOrNull?.length ?? 0;
    final authUser = ref.watch(authStateProvider).valueOrNull;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.9),
                    AppColors.primary.withValues(alpha: 0.4),
                    cs.surface,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHigh,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                      child: const Icon(Icons.person_rounded,
                          size: 48, color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      authUser?.name ?? 'Guest User',
                      style: textTheme.titleLarge?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      authUser?.email ?? 'Sign in to sync your favorites',
                      style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Stats
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: cs.outline.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      _Stat(label: 'Favorites', value: '$favCount', textTheme: textTheme, cs: cs),
                      VerticalDivider(color: cs.outline.withValues(alpha: 0.4), width: 1, thickness: 1, indent: 8, endIndent: 8),
                      _Stat(label: 'Movies Seen', value: '—', textTheme: textTheme, cs: cs),
                      VerticalDivider(color: cs.outline.withValues(alpha: 0.4), width: 1, thickness: 1, indent: 8, endIndent: 8),
                      _Stat(label: 'Reviews', value: '—', textTheme: textTheme, cs: cs),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Appearance
                _SectionHeader('Appearance', textTheme, cs),
                const SizedBox(height: 8),
                _Card(cs: cs, children: [
                  _ToggleTile(
                    icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    title: 'Dark Mode',
                    subtitle: isDark ? 'Currently dark' : 'Currently light',
                    value: isDark,
                    textTheme: textTheme,
                    cs: cs,
                    onChanged: (_) => ref.read(themeProvider.notifier).toggle(),
                  ),
                ]),
                const SizedBox(height: 20),

                // Account
                _SectionHeader('Account', textTheme, cs),
                const SizedBox(height: 8),
                _Card(cs: cs, children: [
                  if (authUser == null)
                    _ActionTile(
                      icon: Icons.login_rounded,
                      title: 'Sign In',
                      subtitle: 'Connect with Firebase Auth',
                      textTheme: textTheme,
                      cs: cs,
                      onTap: () => context.go(AppRoutes.login),
                    )
                  else ...[
                    _InfoTile(
                      icon: Icons.verified_user_outlined,
                      title: 'Signed in as',
                      value: authUser.email,
                      textTheme: textTheme,
                      cs: cs,
                    ),
                    Divider(height: 1, color: cs.outline.withValues(alpha: 0.3), indent: 56, endIndent: 16),
                    _ActionTile(
                      icon: Icons.logout_rounded,
                      title: 'Sign Out',
                      subtitle: 'See you next time!',
                      textTheme: textTheme,
                      cs: cs,
                      onTap: () => ref.read(authControllerProvider.notifier).signOut(),
                    ),
                  ],
                ]),
                const SizedBox(height: 20),

                // About
                _SectionHeader('About', textTheme, cs),
                const SizedBox(height: 8),
                _Card(cs: cs, children: [
                  _InfoTile(icon: Icons.movie_filter_rounded, title: 'CineWave', value: 'v1.0.0', textTheme: textTheme, cs: cs),
                  Divider(height: 1, color: cs.outline.withValues(alpha: 0.3), indent: 56, endIndent: 16),
                  _InfoTile(icon: Icons.api_rounded, title: 'Data Source', value: 'TMDB API', textTheme: textTheme, cs: cs),
                  Divider(height: 1, color: cs.outline.withValues(alpha: 0.3), indent: 56, endIndent: 16),
                  _InfoTile(icon: Icons.code_rounded, title: 'Built with', value: 'Flutter + Riverpod', textTheme: textTheme, cs: cs),
                ]),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label, value;
  final TextTheme textTheme;
  final ColorScheme cs;
  const _Stat({required this.label, required this.value, required this.textTheme, required this.cs});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(children: [
          Text(value, style: textTheme.titleLarge?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(label, style: textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
        ]),
      );
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final TextTheme textTheme;
  final ColorScheme cs;
  const _SectionHeader(this.title, this.textTheme, this.cs);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Text(title.toUpperCase(),
            style: textTheme.labelSmall?.copyWith(
                color: cs.onSurfaceVariant, letterSpacing: 1.2, fontWeight: FontWeight.w600)),
      );
}

class _Card extends StatelessWidget {
  final ColorScheme cs;
  final List<Widget> children;
  const _Card({required this.cs, required this.children});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outline.withValues(alpha: 0.4)),
        ),
        child: Column(children: children),
      );
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final TextTheme textTheme;
  final ColorScheme cs;
  const _ToggleTile({required this.icon, required this.title, required this.subtitle, required this.value, required this.onChanged, required this.textTheme, required this.cs});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: cs.primaryContainer, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: cs.onPrimaryContainer, size: 20),
        ),
        title: Text(title, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: cs.onSurface)),
        subtitle: Text(subtitle, style: textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: cs.onPrimary,
          activeTrackColor: cs.primary,
          inactiveThumbColor: cs.onSurfaceVariant,
          inactiveTrackColor: cs.surfaceContainerHighest,
        ),
      );
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;
  final TextTheme textTheme;
  final ColorScheme cs;
  const _ActionTile({required this.icon, required this.title, required this.subtitle, required this.onTap, required this.textTheme, required this.cs});

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: cs.primaryContainer, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: cs.onPrimaryContainer, size: 20),
        ),
        title: Text(title, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: cs.onSurface)),
        subtitle: Text(subtitle, style: textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
        trailing: Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant),
      );
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title, value;
  final TextTheme textTheme;
  final ColorScheme cs;
  const _InfoTile({required this.icon, required this.title, required this.value, required this.textTheme, required this.cs});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: cs.surfaceContainerHigh, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: cs.onSurfaceVariant, size: 20),
        ),
        title: Text(title, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: cs.onSurface)),
        trailing: Text(value, style: textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
      );
}
