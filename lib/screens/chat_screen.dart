import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:ichat/bloc/massege/massage_bloc.dart';
import 'package:ichat/bloc/massege/massage_event.dart';
import 'package:ichat/bloc/massege/massage_state.dart';
import 'package:ichat/components/drawer_global.dart';
import 'package:ichat/data/database/chat_database.dart';
import 'package:ichat/model/massage_model.dart';
import 'package:ichat/them/fonts_style.dart';
import 'package:ichat/util/extentions.dart';
import 'package:ichat/components/appbar_global.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Map<String, bool> _animationShown = {}; // برای ردیابی نمایش انیمیشن
  Map<String, bool> _animationFinished = {}; // برای ردیابی اتمام انیمیشن

  final ScrollController _controller = ScrollController();
  final TextEditingController _textController = TextEditingController();
  List<Message> messages = [];
  @override
  void initState() {
    super.initState();
    _loadMessages(); // load messages
  }

  bool lastMessage = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppbarGlobal(),
        drawer: DrawerGlobal(),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<MessegeBloc, MassageState>(
                listener: (context, state) {
                  if (state is MessageResponseS) {
                    _saveMessage(state.response, false); //save ai message
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    controller: _controller,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];

                      // if ai message and last message
                      if (!msg.isUser &&
                          index == messages.length - 1 &&
                          lastMessage == true) {
                        if (_animationFinished[msg.timestamp] == true) {
                          // if lastMessage animated done
                          return aiChat(msg);
                        } else {
                          // if lastMessage animated not done
                          return lastMessageAiWithAnimated(msg);
                        }
                        // return lastMessageAiWithAnimated(
                        //   msg,
                        // );
                      }

                      return aiChat(msg);
                      //chatbox1(msg, theme);
                    },
                  );
                },
              ),
            ),
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  Align lastMessageAiWithAnimated(
    Message msg,
  ) {
    // lastMessage = false;
    int totalRepeatCount = 1;
    if (_animationFinished[msg.timestamp] == true) {
      // if animated done
      return aiChat(msg);
    }
    if (_animationShown[msg.timestamp] == true) {
      // if animated not done

      return aiChat(msg);
    }
    _animationShown[msg.timestamp] = true; // نمایش انیمیشن

    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 350.w),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AnimatedTextKit(
              totalRepeatCount: totalRepeatCount,
              animatedTexts: [
                TypewriterAnimatedText(
                  msg.message,
                  textStyle: MyFonts.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  speed: Duration(milliseconds: 6),
                ),
              ],
              onFinished: () {
                setState(() {
                  _animationFinished[msg.timestamp] = true; // اتمام انیمیشن
                });
              },
            ),
            // StreamTypewriterAnimatedText(
            //   text: msg.message,
            //   style: MyFonts.bodyMedium.copyWith(
            //     color: Theme.of(context).colorScheme.tertiary,
            //   ),
            //   onFinished: () {
            //     setState(() {
            //       _animationFinished[msg.timestamp] = true; // اتمام انیمیشن
            //     });
            //   },
            //   speed: const Duration(milliseconds: 15),
            // ),
            Text(
              msg.timestamp.formatTime(msg.timestamp),
              style: MyFonts.displaySmall
                  .copyWith(color: Theme.of(context).colorScheme.primary),
              textAlign: TextAlign.start,
            )
          ]),
        ),
      ),
    );
  }

  Align aiChat(
    Message msg,
  ) {
    // if message is user
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
              color: Theme.of(context).colorScheme.secondary,
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
                    style: MyFonts.bodyMedium.copyWith(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  Text(
                    msg.timestamp.formatTime(msg.timestamp),
                    style: MyFonts.displaySmall
                        .copyWith(color: Theme.of(context).colorScheme.primary),
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
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MarkdownBody(data: msg.message,),
                SelectionArea(
                  child: GptMarkdown(
                    msg.message,
                    style: MyFonts.bodyMedium.copyWith(
                        color: Theme.of(context).colorScheme.tertiary),
                    // overflow: TextOverflow.ellipsis,
                    onLinkTab: (url, title) => launchUrl(Uri.parse(url)),

                    // codeBuilder: (context, name, code, closed) {
                    //   return CodeBlock(code: code);
                    // },
                  ),
                ),
                //
                // SelectableText(
                //   msg.message,
                //   style: MyFonts.bodyMedium.copyWith(
                //     color: Theme.of(context).colorScheme.tertiary,
                //   ),
                // ),
                Text(
                  msg.timestamp.formatTime(msg.timestamp),
                  style: MyFonts.displaySmall
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  Align chatbox1(Message msg, ThemeData theme) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: msg.isUser
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Text(
            msg.message,
            style: MyFonts.bodyMedium
                .copyWith(color: Theme.of(context).colorScheme.tertiary),
          ),
          Text(msg.timestamp.formatTime(msg.timestamp))
        ]),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 7.5.w),
      child: TextField(
        minLines: 1,
        maxLines: 20,
        keyboardType: TextInputType.multiline,
        controller: _textController,
        style: MyFonts.bodyLarge
            .copyWith(color: Theme.of(context).colorScheme.primary),
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.inversePrimary,
          filled: true,
          hintText: 'Send a message',
          hintStyle: MyFonts.bodyMedium
              .copyWith(color: Theme.of(context).colorScheme.primary),
          suffixIcon: InkWell(
            onTap: () {
              final text = _textController.text.trim();
              if (_textController.text.isNotEmpty) {
                _saveMessage(text, true); // ذخیره پیام کاربر
                lastMessage = true;
                context.read<MessegeBloc>().add(SendMassageE(text));
                _textController.clear();
                _scrollToBottom();
              }
            },
            child: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 0),
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
    _scrollToBottom();
  }

  Future<void> _saveMessage(String message, bool isUser) async {
    final chatMessage = Message(
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
