import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/data/models/conversation_model.dart';
import 'package:fyp_renterra_frontend/viewModel/chat_viewModel.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  final ConversationModel? conversationModel;
  final String? conversationId;
  final String fullName, imageUrl;

  const ChatScreen({
    super.key,
    this.conversationModel,
    this.conversationId,
    required this.fullName,
    required this.imageUrl,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool loader = true;
  bool isScroll = true;
  late Timer _timer;
  ChatViewModel? chatViewmodel;

  @override
  void initState() {
    super.initState();
    startRepeatingApiCall();
  }

  void startRepeatingApiCall() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => apiCall());
    apiCall(); // Call once at start
  }

  void apiCall() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ChatViewModel>(context, listen: false)
          .getAllMessages(
              conversationId: widget.conversationId!, isload: loader)
          .then((value) {
        if (scrollController.hasClients) {
          // Add a short delay or another post frame callback
          Future.delayed(Duration(milliseconds: 100), () {
            if (scrollController.hasClients && isScroll == true) {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
              isScroll = false;
            }
          });
        }
      });
      loader = false; // Set this after scrolling is complete
    });
  }

  @override
  void dispose() {
    chatViewmodel?.messagesList.clear();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    chatViewmodel = Provider.of<ChatViewModel>(context);

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
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<ChatViewModel>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (value.messagesList.isEmpty) {
            return Center(child: Text("No messages yet..."));
          }

          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 80),
            itemCount: value.messagesList.length,
            itemBuilder: (context, index) {
              final msg = value.messagesList[index];
              final isMe = msg.senderId == value.userId;

              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue : Color(0xFFE1E1E2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    msg.message!,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            },
          );
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
                    hintText: "Type something here...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            chatViewmodel!.isIconLoading
                ? Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator())
                : IconButton(
                    icon: Icon(Icons.send, color: Colors.blue, size: 28),
                    onPressed: () async {
                      await chatViewmodel!
                          .sendMessage(
                        widget.conversationId!,
                        _controller.text.trim(),
                      )
                          .then((_) {
                        _controller.clear();
                        FocusScope.of(context).unfocus();
                      });

                      Future.delayed(Duration(milliseconds: 100), () {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
