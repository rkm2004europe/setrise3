import 'package:flutter/material.dart';
import '../models/template_model.dart';

const List<TemplateModel> availableTemplates = [
  TemplateModel(
    id: '1', name: 'Daily Vlog', captionPlaceholder: 'My day in 60 seconds...', hashtags: '#vlog #daily #setrise', color: Color(0xFF6C63FF),
  ),
  TemplateModel(
    id: '2', name: 'Challenge', captionPlaceholder: 'Can you do this? 🤔', hashtags: '#challenge #trending', color: Color(0xFFFF2D55),
  ),
  TemplateModel(
    id: '3', name: 'Review', captionPlaceholder: 'Honest review of...', hashtags: '#review #product', color: Color(0xFFFF9500),
  ),
  TemplateModel(
    id: '4', name: 'Tutorial', captionPlaceholder: 'How to... Step by step', hashtags: '#tutorial #learn', color: Color(0xFF34C759),
  ),
  TemplateModel(
    id: '5', name: 'Meme', captionPlaceholder: 'When you... 😂', hashtags: '#meme #funny', color: Color(0xFF007AFF),
  ),
];
