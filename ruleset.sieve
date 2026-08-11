require ["variables", "fileinto", "imap4flags"];

set "TRASH" "INBOX.Trash";
set "AI" "INBOX.AI";
set "APPLE" "INBOX.Apple";

# Github: repo notifications are marked as read and moved to trash
if allof(
  address :matches "From" "*@github.com",
  anyof(
    header :matches "Subject" "Re: [*/*]*",
    header :matches "Subject" "[*/*]*"
  )
) {
  addflag "\\Seen";
  fileinto "${TRASH}";
  stop;
}

# Apple
if anyof(
  address :matches "From" "*@email.apple.com",
  address :matches "From" "*@insideapple.apple.com",
  address :matches "From" "*@id.apple.com",
  address :matches "From" "*@apple.com",
  address :matches "From" "*@appleid.apple.com",
  address :matches "From" "*@apple-support.com",
  address :matches "From" "*@services.apple.com",
  address :matches "From" "*@orders.apple.com",
  address :matches "From" "*@icloud.com",
  address :matches "From" "*@icloud.com.cn",
  address :matches "From" "*@icloud.gzdata.com.cn",
  address :matches "From" "*@itunes.com"
) {

  if allof(
    header :matches "From" "*TestFlight*",
    address :matches "From" "*@email.apple.com"
  ) {
    addflag "\\Seen";
  }

  fileinto "${APPLE}";
  stop;
}

# AI: OpenAI / Claude (Anthropic) / Grok (xAI)
if anyof(
  address :matches "From" "*@openai.com",
  address :matches "From" "*@*.openai.com",
  address :matches "From" "*@anthropic.com",
  address :matches "From" "*@*.anthropic.com",
  address :matches "From" "*@claude.ai",
  address :matches "From" "*@*.claude.ai",
  address :matches "From" "*@x.ai",
  address :matches "From" "*@*.x.ai",
  address :matches "From" "*@grok.com",
  address :matches "From" "*@*.grok.com"
) {
  fileinto "${AI}";
  stop;
}
