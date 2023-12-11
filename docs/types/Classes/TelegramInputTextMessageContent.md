# TelegramInputTextMessageContent

Describes the input text message payload that can be attached as part of answer to a `Telegram` bot inline query.
Source: https://core.telegram.org/bots/api#inputtextmessagecontent

**Inheritance**

[TelegramInputMessageContent](/types/Classes/TelegramInputMessageContent.md)
&gt;
TelegramInputTextMessageContent

## Constructors

### `TelegramInputTextMessageContent(String text)`

Creates a new instance of the input message with the provided message text

#### Parameters

| Param  | Description                                  |
| ------ | -------------------------------------------- |
| `text` | The text of the message, `1-4096 characters` |

---

## Properties

### `entities` → `List<TelegramMessageEntity>`

The list of special entities that appear in a message text. E.g. hashtag, username, URL, etc.

---

## Methods

### `withMessageEntity(TelegramMessageEntity entity)`

Adds a special entity that appear in the message text. For example username tags

#### Parameters

| Param    | Description                                                                                                                                 |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `entity` | The instance of [TelegramMessageEntity](/types/Classes/TelegramMessageEntity.md), special message entity. E.g. hashtag, username, URL, etc. |

#### Return

**Type**

TelegramInputTextMessageContent

**Description**

The current instance of the [TelegramSendFileOptions](/types/Classes/TelegramSendFileOptions.md) class

### `withMessageEntities(TelegramMessageEntity entities)`

Adds special entities that appear in the message text. For example username tags

#### Parameters

| Param      | Description                                                                                                                                         |
| ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| `entities` | The list of [TelegramMessageEntity](/types/Classes/TelegramMessageEntity.md) instances, special message entities. E.g. hashtag, username, URL, etc. |

#### Return

**Type**

TelegramInputTextMessageContent

**Description**

The current instance of the [TelegramSendFileOptions](/types/Classes/TelegramSendFileOptions.md) class

### `withParseMode(String mode)`

Sets the message text parse mode. Needed when the message text is formatted with `HTML` or `Markdown` markup

#### Parameters

| Param  | Description                                                                          |
| ------ | ------------------------------------------------------------------------------------ |
| `mode` | The type of the formatting to use. Possible values: `HTML`, `Markdown`, `MarkdownV2` |

#### Return

**Type**

TelegramInputTextMessageContent

**Description**

The current instance of the [TelegramInputTextMessageContent](/types/Classes/TelegramInputTextMessageContent.md) class

### `disableWebPagePreview()`

Disables link previews for links in the sent message

#### Return

**Type**

TelegramInputTextMessageContent

**Description**

The current instance of the [TelegramInputTextMessageContent](/types/Classes/TelegramInputTextMessageContent.md) class

---
