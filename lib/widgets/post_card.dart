import 'package:flutter/material.dart';
import 'package:instoo/utils/colors.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(snap['profImage']),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snap['username']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              backgroundColor: mobileBackgroundColor,
                              child: ListView(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shrinkWrap: true,
                                children: [
                                  'Delete',
                                  'Share',
                                  'Copy Link',
                                  'Embedd',
                                ]
                                    .map((e) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 16,
                                            ),
                                            child: Text(e),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ));
                  },
                  icon: Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
            ),
          ),
          // Image Section

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),

          //Like Comment Section

          Row(
            children: [
              //Like Widget
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),

              // Comment Section
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.comment,
                ),
              ),

              // Share Widget

              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send_outlined,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bookmark_border,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Description & Number of comments

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${snap['likes'].length} likes',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: '${snap['username']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '  ${snap['description']}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    child: Text(
                      'View all 242 comments',
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  child: Text(
                    DateFormat.yMMMd().format(
                      snap['datePublished'].toDate(),
                    ),
                    style: TextStyle(
                      fontSize: 13,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
