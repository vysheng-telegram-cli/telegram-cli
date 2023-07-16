# Telegram messenger CLI

Command-line interface for [Telegram](http://telegram.org). Uses readline interface. It is client implementation of TGL library.

> This is a fork of [kenorb's repository](https://github.com/kenorb-contrib/tg), who has been maintaining [vysheng's repository](https://github.com/vysheng/tg) after he discontinued public development of this project.

## API, Protocol documentation

Documentation for Telegram API is available here: <http://core.telegram.org/api>

Documentation for MTproto protocol is available here: <http://core.telegram.org/mtproto>

## Building

The preferred way of building telegram-cli is a [Docker container](https://github.com/vysheng-telegram-cli/docker-telegram-cli), however the native building instructions are also given below. 

Clone this GitHub repository with `--recursive` parameter to clone submodules:

```
git clone --recursive https://github.com/vysheng-telegram-cli/telegram-cli.git && cd tg
```

Prerequisites:

```
sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson-dev libpython-dev libpython3-dev libgcrypt-   dev zlib1g-dev lua-lgi make
```

Compile with CMake:

```
mkdir build
cd build
cmake ..
cmake --build .
```

## Python Support

Python support is currently limited to Python 2.7 or Python 3.1+. Other versions may work but are not tested.

## Usage

```
bin/telegram-cli -k <public-server-key>
```

By default, the public key is stored in tg-server.pub in the same folder or in /etc/telegram-cli/server.pub. If not, specify where to find it:

```
bin/telegram-cli -k tg-server.pub
```

Client support TAB completion and command history.

Peer refers to the name of the contact or dialog and can be accessed by TAB completion.
For user contacts peer name is Name <underscore> Lastname with all spaces changed to underscores.
For chats it is it's title with all spaces changed to underscores
For encrypted chats it is <Exсlamation mark> <underscore> Name <underscore> Lastname with all spaces changed to underscores.

If two or more peers have same name, <sharp>number is appended to the name. (for example A_B, A_B#1, A_B#2 and so on)

## Supported commands

### Messaging

* **msg** \<peer\> Text - sends message to this peer
* **fwd** \<user\> \<msg-seqno\> - forward message to user. You can see message numbers starting client with -N
* **chat_with_peer** \<peer\> starts one on one chat session with this peer. /exit or /quit to end this mode.
* **add_contact** \<phone-number\> \<first-name\> \<last-name\> - tries to add contact to contact-list by phone
* **rename_contact** \<user\> \<first-name\> \<last-name\> - tries to rename contact. If you have another device it will be a fight
* **mark_read** \<peer\> - mark read all received messages with peer
* **delete_msg** \<msg-seqno\> - deletes message (not completly, though)
* **restore_msg** \<msg-seqno\> - restores delete message. Impossible for secret chats. Only possible short time (one hour, I think) after deletion

### Multimedia

* **send_photo** \<peer\> \<photo-file-name\> - sends photo to peer
* **send_video** \<peer\> \<video-file-name\> - sends video to peer
* **send_text** \<peer\> \<text-file-name> - sends text file as plain messages
* **send_document** \<peer\> \<document-file-name\> - sends document to peer
* **load_photo**/load_video/load_video_thumb/load_audio/load_document/load_document_thumb \<msg-seqno\> - loads photo/video/audio/document to download dir
* **view_photo**/view_video/view_video_thumb/view_audio/view_document/view_document_thumb \<msg-seqno\> - loads photo/video to download dir and starts system default viewer
* **fwd_media** \<msg-seqno\> send media in your message. Use this to prevent sharing info about author of media (though, it is possible to determine user_id from media itself, it is not possible get access_hash of this user)
* **set_profile_photo** \<photo-file-name\> - sets userpic. Photo should be square, or server will cut biggest central square part

### Group chat options

* **chat_info** \<chat\> - prints info about chat
* **chat_add_user** \<chat\> \<user\> - add user to chat
* **chat_del_user** \<chat\> \<user\> - remove user from chat
* **rename_chat** \<chat\> \<new-name\>
* **create_group_chat** \<chat topic\> \<user1\> \<user2\> \<user3\> ... - creates a groupchat with users, use chat_add_user to add more users
* **chat_set_photo** \<chat\> \<photo-file-name\> - sets group chat photo. Same limits as for profile photos.

### Channels

* **channel_get_admins** \<channel\> [limit=100] [offset=0]	- Gets channel admins
* **channel_get_members** \<channel\> [limit=100] [offset=0]	- Gets channel members
* **channel_info** \<channel\>	- Prints info about channel (id, members, admin, etc.)
* **channel_invite** \<channel\> \<user\>	- Invites user to channel
* **channel_join** \<channel\>	- Joins to channel
* **channel_kick** \<channel\> \<user\>	- Kicks user from channel
* **channel_leave** \<channel\>	- Leaves from channel
* **channel_list** [limit=100] [offset=0]	- List of last channels
* **channel_set_about** \<channel\> \<about\>	- Sets channel about info.
* **channel_set_admin** \<channel\> \<admin\> \<type\>	- Sets channel admin. 0 - not admin, 1 - moderator, 2 - editor
* **channel_set_photo** \<channel\> \<filename\>	- Sets channel photo. Photo will be cropped to square
* **channel_set_username** \<channel\> \<username\>	 -Sets channel username info.

### Search

* **search** \<peer\> pattern - searches pattern in messages with peer
* **global_search** pattern - searches pattern in all messages

### Secret chat

* **create_secret_chat** \<user\> - creates secret chat with this user
* **visualize_key** \<secret_chat\> - prints visualization of encryption key. You should compare it to your partner's one
* **set_ttl** \<secret_chat\> \<ttl\> - sets ttl to secret chat. Though client does ignore it, client on other end can make use of it
* **accept_secret_chat** \<secret_chat\> - manually accept secret chat (only useful when starting with -E key)

### Stats and various info

* **user_info** \<user\> - prints info about user
* **history** \<peer\> [limit] - prints history (and marks it as read). Default limit = 40
* **dialog_list** - prints info about your dialogs
* **contact_list** - prints info about users in your contact list
* **suggested_contacts** - print info about contacts, you have max common friends
* **stats** - just for debugging
* **show_license** - prints contents of GPLv2
* **help** - prints this help
* **get_self** - get our user info

### Card
* **export_card** - print your 'card' that anyone can later use to import your contact
* **import_card** \<card\> - gets user by card. You can write messages to him after that.

### Other
* **quit** - quit
* **safe_quit** - wait for all queries to end then quit
* run `telegram-cli -q` to logout from account

## Troubleshooting

* if you got error: `get error FAIL: 38: can not parse arg #1` it maybe be unresolved username. You should use `resolve_username channel/group/user_name` before running action with it. [See this issue for more info](https://github.com/vysheng/tg/issues/823)

