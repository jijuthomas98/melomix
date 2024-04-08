import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:melomix/features/core/data/model/song/song.dart';
import 'package:melomix/utils/extensions/extensions.dart';

class SongItemWidget extends StatelessWidget {
  final Song song;
  const SongItemWidget({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildLeading(),
      title: _buildTitle(context),
      subtitle: _buildSubtitle(context),
    );
  }

  Widget _buildLeading() {
    return CachedNetworkImage(
      imageUrl: song.getLowQualityImageUrl() ?? '',
      height: 56,
      width: 56,
      errorWidget: (context, url, error) {
        return const SizedBox.square(
          dimension: 56,
          child: Icon(Icons.music_note),
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            song.name,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.75,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      song.album!.name,
      style: context.textTheme.titleMedium,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
