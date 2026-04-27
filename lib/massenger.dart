import 'package:flutter/material.dart';

class MassengerScreen extends StatelessWidget {
  const MassengerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: circleAvatarWidget(Icons.table_rows_rounded),
        ),
        title: Text('Chats'),
        actions: [
          circleAvatarWidget(Icons.edit),
          SizedBox(width: 16),
          circleAvatarWidget(Icons.camera_alt_outlined),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 105,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Image.network(
                                "https://fortune.com/img-assets/wp-content/uploads/2025/02/GettyImages-2174052044-e1739963944740.jpg?w=1440&q=75",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 3,
                              right: 0,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: 60,
                          child: Text(
                            " bill Gates founder",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Image.network(
                                "https://fortune.com/img-assets/wp-content/uploads/2025/02/GettyImages-2174052044-e1739963944740.jpg?w=1440&q=75",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "bill Gates",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "hello I am bill gates fssssssssssssssssssssssounder of Microsoft company",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "10:30",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleAvatarWidget(IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}
