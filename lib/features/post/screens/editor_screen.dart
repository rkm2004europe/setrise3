import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/filters_data.dart';
import 'publish_screen.dart';

class EditorScreen extends StatefulWidget {
  final String mediaPath;
  final bool isVideo;
  const EditorScreen({super.key, required this.mediaPath, required this.isVideo});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  int _selectedFilterIndex = 0;
  double _filterIntensity = 1.0;
  String? _selectedMusicTrack;
  String? _taggedProduct;
  String? _selectedLocation;
  String? _mentionedUser;

  // الوظائف المستقبلية ستكون في services
  void _pickMusic() async {
    // TODO: open music picker sheet and set _selectedMusicTrack
  }

  void _pickProduct() async {
    // TODO: open product search and set _taggedProduct
  }

  void _pickLocation() async {
    // TODO: open map and set _selectedLocation
  }

  void _pickMention() async {
    // TODO: open mention sheet and set _mentionedUser
  }

  @override
  Widget build(BuildContext context) {
    final filter = availableFilters[_selectedFilterIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Media preview (placeholder)
          Center(
            child: Container(
              color: Colors.white10,
              child: Center(
                child: Text(
                  widget.isVideo ? 'Video Player' : 'Image Preview',
                  style: const TextStyle(color: Colors.white54),
                ),
              ),
            ),
          ),

          // Top bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.white, size: 28),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Navigate to publish screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PublishScreen(
                            mediaPath: widget.mediaPath,
                            isVideo: widget.isVideo,
                            filter: filter,
                            filterIntensity: _filterIntensity,
                            musicTrack: _selectedMusicTrack,
                            product: _taggedProduct,
                            location: _selectedLocation,
                            mentionedUser: _mentionedUser,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: PostColors.accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Next', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom tools
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Filters bar
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: availableFilters.length,
                    itemBuilder: (context, index) {
                      final f = availableFilters[index];
                      final isSelected = index == _selectedFilterIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFilterIndex = index;
                            _filterIntensity = 1.0;
                          });
                        },
                        child: Container(
                          width: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isSelected ? PostColors.accent : Colors.white10,
                            borderRadius: BorderRadius.circular(14),
                            border: isSelected ? Border.all(color: PostColors.accent, width: 2) : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(f.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(f.name, style: TextStyle(color: isSelected ? PostColors.accent : Colors.white70, fontSize: 10)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // Tools row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ToolBtn(icon: Icons.tune, label: 'Trim', onTap: () {}),
                      _ToolBtn(icon: Icons.speed, label: 'Speed', onTap: () {}),
                      _ToolBtn(icon: Icons.flip, label: 'Flip', onTap: () {}),
                      _ToolBtn(icon: Icons.music_note, label: 'Music', onTap: _pickMusic),
                      _ToolBtn(icon: Icons.shopping_bag, label: 'Product', onTap: _pickProduct),
                      _ToolBtn(icon: Icons.location_on, label: 'Location', onTap: _pickLocation),
                      _ToolBtn(icon: Icons.person_add, label: 'Mention', onTap: _pickMention),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ToolBtn({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10)),
        ],
      ),
    );
  }
}
