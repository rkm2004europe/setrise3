// lib/features/date/models/dating_profile_model.dartdate/models/dating_profile_model.dart

import 'package:flutter/material.dart';

class DatingProfile {
  final String id;
  final String name;
  final int age;
  final String city;
  final String country;
  final String distanceKm;
  final String bio;
  final List<String> photos;
  final List<String> interests;
  final String? job;
  final String? education;
  final bool isVerified;
  final bool isOnline;
  final bool isLocked;
  final bool isBoosted;
  final int compatibilityPct;

  const DatingProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.city,
    required this.country,
    required this.distanceKm,
    required this.bio,
    required this.photos,
    required this.interests,
    this.job,
    this.education,
    this.isVerified = false,
    this.isOnline = false,
    this.isLocked = false,
    this.isBoosted = false,
    this.compatibilityPct = 0,
  });

  static List<DatingProfile> mockProfiles() => [
    const DatingProfile(
      id: 'p1', name: 'Noor', age: 24, city: 'Dubai', country: 'UAE',
      distanceKm: '3 km',
      bio: '☕ Coffee addict · ✈️ World explorer · 📸 Part-time photographer.',
      photos: ['https://randomuser.me/api/portraits/women/44.jpg'],
      interests: ['Travel', 'Photography', 'Coffee', 'Yoga'],
      job: 'UX Designer', education: 'AUD Dubai',
      isVerified: true, isOnline: true, isBoosted: true, compatibilityPct: 94,
    ),
    const DatingProfile(
      id: 'p2', name: 'Layla', age: 22, city: 'Riyadh', country: 'KSA',
      distanceKm: '12 km',
      bio: '🎨 Art & design · 📚 Book lover · 🌿 Plant mom.',
      photos: ['https://randomuser.me/api/portraits/women/68.jpg'],
      interests: ['Art', 'Books', 'Design', 'Plants'],
      job: 'Graphic Designer',
      isOnline: false, isLocked: true, compatibilityPct: 87,
    ),
    const DatingProfile(
      id: 'p3', name: 'Sara', age: 26, city: 'Abu Dhabi', country: 'UAE',
      distanceKm: '28 km',
      bio: '💻 Software engineer · 🏋️ Gym addict · 🍣 Sushi fanatic.',
      photos: ['https://randomuser.me/api/portraits/women/22.jpg'],
      interests: ['Tech', 'Fitness', 'Sushi', 'Hiking'],
      job: 'Software Engineer', education: 'NYUAD',
      isVerified: true, isOnline: true, compatibilityPct: 91,
    ),
    const DatingProfile(
      id: 'p4', name: 'Rania', age: 23, city: 'Kuwait City', country: 'Kuwait',
      distanceKm: '45 km',
      bio: '🌙 Night owl · 🎬 Film nerd · 🎮 Gamer girl.',
      photos: ['https://randomuser.me/api/portraits/women/55.jpg'],
      interests: ['Films', 'Gaming', 'Anime', 'Music'],
      job: 'Architecture Student',
      isOnline: true, isBoosted: true, compatibilityPct: 78,
    ),
    const DatingProfile(
      id: 'p5', name: 'Hana', age: 27, city: 'Doha', country: 'Qatar',
      distanceKm: '67 km',
      bio: '💼 Entrepreneur · ☀️ Sunset chaser · 🏄 Beach lover.',
      photos: ['https://randomuser.me/api/portraits/women/31.jpg'],
      interests: ['Entrepreneurship', 'Beach', 'Travel', 'Tennis'],
      job: 'CEO & Founder', education: 'QU',
      isVerified: true, isOnline: false, compatibilityPct: 89,
    ),
    const DatingProfile(
      id: 'p6', name: 'Yasmine', age: 25, city: 'Cairo', country: 'Egypt',
      distanceKm: '89 km',
      bio: '🎵 Musician · 🌺 Flower lover · 🍕 Pizza philosopher.',
      photos: ['https://randomuser.me/api/portraits/women/79.jpg'],
      interests: ['Music', 'Flowers', 'Food', 'Poetry'],
      job: 'Music Teacher',
      isOnline: true, compatibilityPct: 82,
    ),
  ];
}

class MatchModel {
  final String id;
  final String name;
  final String imageUrl;
  final bool isNew;
  final bool isOnline;
  final String? lastMessage;
  final String timeAgo;
  final int unreadCount;

  const MatchModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isNew = false,
    this.isOnline = false,
    this.lastMessage,
    this.timeAgo = '',
    this.unreadCount = 0,
  });

  static List<MatchModel> mockMatches() => const [
    MatchModel(id: 'm1', name: 'Sarah',   imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg', isNew: true,  isOnline: true,  timeAgo: '2m'),
    MatchModel(id: 'm2', name: 'Nora',    imageUrl: 'https://randomuser.me/api/portraits/women/68.jpg', isNew: true,  isOnline: false, timeAgo: '18m'),
    MatchModel(id: 'm3', name: 'Lina',    imageUrl: 'https://randomuser.me/api/portraits/women/22.jpg', isNew: true,  isOnline: true,  timeAgo: '1h'),
    MatchModel(id: 'm4', name: 'Rania',   imageUrl: 'https://randomuser.me/api/portraits/women/55.jpg', isNew: false, isOnline: false, lastMessage: 'Hey! 👋 How are you?',         timeAgo: '3h', unreadCount: 2),
    MatchModel(id: 'm5', name: 'Hana',    imageUrl: 'https://randomuser.me/api/portraits/women/31.jpg', isNew: false, isOnline: true,  lastMessage: 'We should meet for coffee ☕', timeAgo: '5h'),
    MatchModel(id: 'm6', name: 'Yasmine', imageUrl: 'https://randomuser.me/api/portraits/women/79.jpg', isNew: false, isOnline: false, lastMessage: 'That sounds amazing!',          timeAgo: '1d'),
    MatchModel(id: 'm7', name: 'Amira',   imageUrl: 'https://randomuser.me/api/portraits/women/12.jpg', isNew: false, isOnline: true,  lastMessage: 'Are you free this weekend?',   timeAgo: '2d', unreadCount: 5),
  ];
}

