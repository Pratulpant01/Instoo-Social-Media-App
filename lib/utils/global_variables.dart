import 'package:flutter/material.dart';
import 'package:instoo/screens/add_post_screen.dart';

import '../screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('Search'),
  AddPostScreen(),
  Text('Likes'),
  Text('Profile'),
];
