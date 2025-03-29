import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/bloc/massege/massage_bloc.dart';
import 'package:my_chat_gpt/bloc/massege/massage_event.dart';
import 'package:my_chat_gpt/bloc/massege/massage_state.dart';
import 'package:my_chat_gpt/data/database/chat_database.dart';
import 'package:my_chat_gpt/model/massage.dart';
import 'package:my_chat_gpt/util/constants.dart';
import 'package:my_chat_gpt/util/extentions.dart';
import 'package:my_chat_gpt/widget/global/appbar_global.dart';
import 'package:stream_typewriter_text/stream_typewriter_text.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _textController = TextEditingController();
  List<ChatMessage> messages = [];
  bool isAnimated = false;
  @override
  void initState() {
    super.initState();
    _loadMessages(); // بارگذاری پیام‌های ذخیره‌شده
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: appBarGlobal(theme, context),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<MassageBloc, MassageState>(
                listener: (context, state) {
                  if (state is MessageResponseS) {
                    _saveMessage(
                        state.response, false); // ذخیره پاسخ هوش مصنوعی
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    controller: _controller,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];

                      // اگر پیام، پاسخ هوش مصنوعی و آخرین پیام باشد، از انیمیشن استفاده کن
                      if (!msg.isUser && index == messages.length - 1) {
                        return lastMessageAi(msg, theme);
                      }

                      // پیام‌های عادی (کاربر یا پیام‌های قبلی هوش مصنوعی)
                      return chatbox2(msg, theme);
                      //chatbox1(msg, theme);
                    },
                  );
                },
              ),
            ),
            _buildInputField(theme),
          ],
        ),
      ),
    );
  }

  Align lastMessageAi(ChatMessage msg, ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 350.w),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColor.normal,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            StreamTypewriterAnimatedText(
              text: msg.message,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
              onFinished: () {
                setState(() {
                  isAnimated = !isAnimated;
                });
              },
              speed: const Duration(milliseconds: 50),
            ),
            Text(
              msg.timestamp.formatTime(msg.timestamp),
              style: theme.textTheme.displaySmall!
                  .copyWith(color: AppColor.strong),
              textAlign: TextAlign.start,
            )
          ]),
        ),
      ),
    );
  }

  Align chatbox2(ChatMessage msg, ThemeData theme) {
    // اگر پیام کاربر باشد
    if (msg.isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 350.w),
          child: Container(
            //width: 340.w,
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColor.active,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Column(
                //    mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    //overflow: TextOverflow.ellipsis,
                    msg.message,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    msg.timestamp.formatTime(msg.timestamp),
                    style: theme.textTheme.displaySmall!
                        .copyWith(color: AppColor.strong),
                    textAlign: TextAlign.end,
                  )
                ]),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 350.w),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColor.normal,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  msg.message,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  msg.timestamp.formatTime(msg.timestamp),
                  style: theme.textTheme.displaySmall!
                      .copyWith(color: AppColor.strong),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  Align chatbox1(ChatMessage msg, ThemeData theme) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: msg.isUser ? AppColor.active : AppColor.normal,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Text(
            msg.message,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
          ),
          Text(msg.timestamp.formatTime(msg.timestamp))
        ]),
      ),
    );
  }

  Widget _buildInputField(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 7.5.w),
      child: TextField(
        minLines: 1,
        maxLines: 20,
        keyboardType: TextInputType.multiline,
        controller: _textController,
        style: theme.textTheme.bodyLarge!.copyWith(color: AppColor.txgrey),
        decoration: InputDecoration(
          fillColor: AppColor.normal,
          filled: true,
          hintText: 'Send a message',
          hintStyle:
              theme.textTheme.bodyMedium!.copyWith(color: AppColor.strong),
          suffixIcon: InkWell(
            onTap: () {
              final text = _textController.text.trim();
              if (text.isNotEmpty) {
                _saveMessage(text, true); // ذخیره پیام کاربر
                context.read<MassageBloc>().add(SendMassageE(text));
                _textController.clear();
                _scrollToBottom();
              }
            },
            child: Icon(
              Icons.send,
              color: AppColor.strong,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.active, width: 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.active, width: 0),
          ),
        ),
      ),
    );
  }

  Future<void> _loadMessages() async {
    final dbMessages = await ChatDatabase().fetchMessages();
    setState(() {
      messages = dbMessages;
    });
  }

  Future<void> _saveMessage(String message, bool isUser) async {
    final chatMessage = ChatMessage(
      message: message,
      isUser: isUser,
      timestamp: DateTime.now().toIso8601String(),
    );
    await ChatDatabase().insertMessage(chatMessage);
    setState(() {
      messages.add(chatMessage);
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}
