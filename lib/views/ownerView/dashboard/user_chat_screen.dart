import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/viewModel/chat_viewModel.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId, fullName, imageUrl;

  const ChatScreen(
      {super.key,
      required this.conversationId,
      required this.fullName,
      required this.imageUrl});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ChatViewModel>(context, listen: false)
          .getAllMessages(widget.conversationId);

      // Scroll to bottom after loading messages
      Future.delayed(Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  // @override
  // void initState() {
  //   Provider.of<ChatViewModel>(context, listen: false)
  //       .getAllMessages(widget.conversationId);

  //   //     // Scroll to bottom after loading messages
  //   Future.delayed(Duration(milliseconds: 100), () {
  //     scrollController.animateTo(
  //       scrollController.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   });
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final chatViewmodel = Provider.of<ChatViewModel>(
      context,
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          leadingWidth: 30,
          scrolledUnderElevation: 0,
          title: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(widget.imageUrl),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  widget.fullName,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<ChatViewModel>(
        builder: (context, value, child) {
          if (value.isLoading) {
            // 🔄 Show loader
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (value.messagesList.isEmpty) {
            // 🔄 Show loader
            return Center(
              child: Text("No messages started...."),
            );
          }

          return ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              padding:
                  EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 80),
              itemCount: value.messagesList.length,
              itemBuilder: (context, index) {
                final msg = value.messagesList[index];
                final isMe = value.messageModel.messages![index].senderId ==
                    value.userId;
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue : Color(0xFFE1E1E2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      msg.message!,
                      style:
                          TextStyle(color: isMe ? Colors.white : Colors.black),
                    ),
                  ),
                );
              });
        },
      ),
      bottomSheet: Container(
        height: 65,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15),
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Type Something here.......",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            chatViewmodel.isIconLoading
                ? Padding(
                    padding: EdgeInsets.all(12),
                    child: const CircularProgressIndicator())
                : IconButton(
                    icon: Icon(Icons.send, color: Colors.blue, size: 28),
                    onPressed: () async {
                      await chatViewmodel
                          .sendMessage(widget.conversationId,
                              _controller.text.trim().toString())
                          .then(
                        (value) {
                          _controller.clear();
                        },
                      );

                      Future.delayed(Duration(milliseconds: 100), () {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      });
                    }
                    // sendMessage,
                    ),
          ],
        ),
      ),
    );
  }
}
