import 'dart:math';

Random random = Random();
List names = [
  "Kunal Anand",
  "Piyush Vashist",
  "shaurya Singh",
  "Abhishek Anil",
  "Ali naki",
  "Abhishek Kumar",
  "Harsh Mittal",
  "Chirag Mishra",
  "Gautam Singh",
  "Akash sharma",
  "Divyam Garg",
];

List messages = [
  "Hey, are you free? let's have a dance tonight",
  "Are you available tomorrow?",
  "I am tired now, will resume match tomorrow",
  "This cracked me up 😂😂",
  "Danzerra Rocks!!!",
  "The last game was awesome🚀",
  "Mahesh signed for Barca❤️❤️",
  "I am not free today.",
  "Are you angry at something?",
  "Let's try a dance on despacito.",
  "Can I hear your voice?",
];

List captions = [
  "Hey, are you free? let's have a dance tonight",
  "Are you available tomorrow?",
  "I am tired now, will resume match tomorrow",
  "This cracked me up 😂😂",
  "Danzerra Rocks!!!",
  "The last game was awesome🚀",
  "Mahesh signed for Barca❤️❤️",
  "I am not free today.",
  "Are you angry at something?",
  "Let's try a dance on despacito.",
  "Can I hear your voice?",
];

List notifs = [
  "${names[random.nextInt(10)]} and ${random.nextInt(100)} others liked your post",
  "${names[random.nextInt(10)]} mentioned you in a comment",
  "${names[random.nextInt(10)]} shared your post",
  "${names[random.nextInt(10)]} commented on your post",
  "${names[random.nextInt(10)]} replied to your comment",
  "${names[random.nextInt(10)]} reacted to your comment",
  "${names[random.nextInt(10)]} asked you to join a Group️",
  "${names[random.nextInt(10)]} asked you to like a page",
  "You have memories with ${names[random.nextInt(10)]}",
  "${names[random.nextInt(10)]} Tagged you and ${random.nextInt(100)} others in a post",
  "${names[random.nextInt(10)]} Sent you a friend request",
];

List notifications = List.generate(
    13,
    (index) => {
          "name": names[random.nextInt(10)],
          "dp": "assets/images/cm${random.nextInt(10)}.jpeg",
          "time": "${random.nextInt(50)} min ago",
          "notif": notifs[random.nextInt(10)],
        });

List posts = List.generate(
    13,
    (index) => {
          "name": names[random.nextInt(10)],
          "dp": "assets/images/cm${random.nextInt(10)}.jpeg",
          "time": "${random.nextInt(50)} min ago",
          "img": "assets/images/a${random.nextInt(5)}.jpg",
          "captions": captions[random.nextInt(10)],
        });

List chats = List.generate(
    13,
    (index) => {
          "name": names[random.nextInt(10)],
          "dp": "assets/images/cm${random.nextInt(10)}.jpeg",
          "msg": messages[random.nextInt(10)],
          "counter": random.nextInt(20),
          "time": "${random.nextInt(50)} min ago",
          "isOnline": random.nextBool(),
        });

List groups = List.generate(
    13,
    (index) => {
          "name": "Group ${random.nextInt(20)}",
          "dp": "assets/images/cm${random.nextInt(10)}.jpeg",
          "msg": messages[random.nextInt(10)],
          "counter": random.nextInt(20),
          "time": "${random.nextInt(50)} min ago",
          "isOnline": random.nextBool(),
        });

List types = ["text", "image"];
List conversation = List.generate(
    10,
    (index) => {
          "username": "Group ${random.nextInt(20)}",
          "time": "${random.nextInt(50)} min ago",
          "type": types[random.nextInt(2)],
          "replyText": messages[random.nextInt(10)],
          "isMe": random.nextBool(),
          "isGroup": false,
          "isReply": random.nextBool(),
        });

List friends = List.generate(
    13,
    (index) => {
          "name": names[random.nextInt(10)],
          "dp": "assets/images/cm${random.nextInt(10)}.jpeg",
          "status": "Anything could be here",
          "isAccept": random.nextBool(),
        });
