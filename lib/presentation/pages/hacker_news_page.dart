import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/hacker_news/hacker_news_cubit.dart';

class HackerNewsPage extends StatelessWidget {
  const HackerNewsPage({super.key});

  Future<void> openUrl(String storyUrl) async {
    final url = Uri.parse(storyUrl);
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      log('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('dd-MM-yyyy hh:mm');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('News',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => HackerNewsCubit()..getTopStories(),
            child: BlocBuilder<HackerNewsCubit, HackerNewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return const CircularProgressIndicator();
                } else if (state is NewsLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.news.length,
                    itemBuilder: (context, index) {
                      final story = state.news[index];
                      final date = df.format(
                          DateTime.fromMillisecondsSinceEpoch(
                              story.createdAt * 1000));
                      return _storyItem(story, date);
                    },
                  );
                } else {
                  return Center(
                    child: Text(state.toString()),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  ListTile _storyItem(story, String date) {
    return ListTile(
      leading: Container(
          height: 30.0,
          width: 30.0,
          decoration: const BoxDecoration(color: Colors.deepPurple),
          child: Center(
            child: Text(
              story.points.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          )),
      title: Text(
        story.title,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(date),
      onTap: () => openUrl(story.url),
      trailing: story.url.isNotEmpty
          ? const Icon(Icons.open_in_new)
          : const SizedBox(),
    );
  }
}
