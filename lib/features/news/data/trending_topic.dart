class TrendingTopic {
  final String title;
  final int postsCount;
  final String? hashtag;

  const TrendingTopic({
    required this.title,
    required this.postsCount,
    this.hashtag,
  });
}

const List<TrendingTopic> trendingTopics = [
  TrendingTopic(title: 'SetRise Update', postsCount: 45000, hashtag: '#SetRise'),
  TrendingTopic(title: 'Flutter 4.0', postsCount: 32000, hashtag: '#Flutter'),
  TrendingTopic(title: 'AI Revolution', postsCount: 28000, hashtag: '#AI'),
  TrendingTopic(title: 'iPhone 18 Pro', postsCount: 21000, hashtag: '#Apple'),
  TrendingTopic(title: 'World Cup 2026', postsCount: 67000, hashtag: '#WorldCup'),
];
