import 'package:flutter/material.dart';

/// Reusable Setting Tile Widgets
///
/// Collection of standardized widgets for building consistent settings UI.
/// These widgets ensure uniform appearance and behavior across all settings.

/// Standard switch setting tile
class SettingSwitchTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool isLoading;

  const SettingSwitchTile({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.value,
    this.onChanged,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Switch(
              value: value,
              onChanged: onChanged,
            ),
      onTap: isLoading || onChanged == null ? null : () => onChanged!(!value),
    );
  }
}

/// Standard dropdown setting tile
class SettingDropdownTile<T> extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final bool isLoading;

  const SettingDropdownTile({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.value,
    required this.items,
    this.onChanged,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                items: items,
                onChanged: isLoading || onChanged == null ? null : onChanged,
                isDense: true,
              ),
            ),
    );
  }
}

/// Standard action setting tile (for buttons/actions)
class SettingActionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Widget? trailing;
  final bool isLoading;
  final Color? iconColor;

  const SettingActionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onPressed,
    this.trailing,
    this.isLoading = false,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.primary,
            )
          : null,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing ??
          (isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.arrow_forward_ios, size: 16)),
      onTap: isLoading ? null : onPressed,
    );
  }
}

/// Standard informational setting tile (read-only)
class SettingInfoTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? value;
  final Color? iconColor;

  const SettingInfoTile({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
            )
          : null,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: value != null
          ? Text(
              value!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
    );
  }
}

/// Settings section header
class SettingSectionHeader extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;

  const SettingSectionHeader({
    super.key,
    required this.title,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

/// Settings group container with optional divider
class SettingGroup extends StatelessWidget {
  final List<Widget> children;
  final bool showDivider;
  final EdgeInsetsGeometry? margin;

  const SettingGroup({
    super.key,
    required this.children,
    this.showDivider = true,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (showDivider && i < children.length - 1)
              Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
          ],
        ],
      ),
    );
  }
}