import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/playlist_model.dart';

class PlaylistReorder extends StatelessWidget {
  final List<PlaylistModel> playlists;
  final Function(int oldIndex, int newIndex) onReorder;

  const PlaylistReorder({super.key, required this.playlists, required this.onReorder});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      padding: const EdgeInsets.all(16),
      onReorder: onReorder,
      children: playlists.map((pl) => ListTile(
        key: ValueKey(pl.id),
        leading: Text(pl.coverEmoji, style: const TextStyle(fontSize: 28)),
        title: Text(pl.name, style: const TextStyle(color: MusicColors.text)),
        subtitle: Text('${pl.trackCount} أغنية', style: const TextStyle(color: MusicColors.text2)),
        trailing: const Icon(Icons.drag_handle, color: MusicColors.text2),
      )).toList(),
    );
  }
}
