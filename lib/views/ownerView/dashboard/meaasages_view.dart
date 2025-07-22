import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/viewModel/chat_viewModel.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/user_chat_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    Provider.of<ChatViewModel>(context, listen: false).getAllConversations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatViewmodel = Provider.of<ChatViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "My Chats",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
          ],
        ),
        scrolledUnderElevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Color(0xFF113953),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Consumer<ChatViewModel>(builder: (context, value, child) {
              if (value.isLoading) {
                // 🔄 Show loader
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: chatViewmodel.conversationMessageList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              conversationId: chatViewmodel
                                  .conversationMessageList[index].id,
                              fullName: chatViewmodel
                                  .conversationMessageList[index]
                                  .participant
                                  .fullName,
                              imageUrl: chatViewmodel
                                  .conversationMessageList[index]
                                  .participant
                                  .profilePicture,
                            ),
                          ));
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    ),
                    title: Text(
                      chatViewmodel
                          .conversationMessageList[index].participant.fullName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      chatViewmodel
                              .conversationMessageList[index].lastMessage ??
                          "No Last messages yet",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    trailing: Text(
                      chatViewmodel.convertToPakistanLocalTimeOnly(chatViewmodel
                          .conversationMessageList[index].lastUpdated),
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
