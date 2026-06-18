import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_room_model.dart';
import '../services/recommendation_engine.dart';
import '../widgets/live_room_card.dart';
import 'live_room_screen.dart';

class LiveDiscoverScreen extends StatefulWidget {
  const LiveDiscoverScreen({super.key});

  @override
  State<LiveDiscoverScreen> createState() => _LiveDiscoverScreenState();
}

class _LiveDiscoverScreenState extends State<LiveDiscoverScreen> {
  final RecommendationEngine _engine = RecommendationEngine();
  List<LiveRoomModel> _rooms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    final rooms = await _engine.getRecommended(
      interests: ['تقنية', 'موسيقى'],
      viewedHostIds: [],
      likedCategories: ['ترفيه', 'فن'],
    );
    setState(() {
      _rooms = rooms;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: LiveColors.accent))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _rooms.length,
                      itemBuilder: (_, i) => LiveRoomCard(
                        room: _rooms[i],
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LiveRoomScreen(room: _rooms[i]))),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
          const SizedBox(width: 12),
          const Text('اكتشف', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ]),
      );
}
