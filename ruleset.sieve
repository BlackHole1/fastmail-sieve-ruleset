require ["variables", "fileinto", "imap4flags"];

set "GITHUB" "INBOX.Github";
set "GITHUB_OOMOL" "INBOX.Github.Oomol";
set "GITHUB_ELECTRON" "INBOX.Github.Electron";
set "GITHUB_PNPM" "INBOX.Github.PNPM";
set "GITHUB_BLACKHOLE1" "INBOX.Github.BlackHole1";
set "GITHUB_OTHER_NOTIFICATIONS" "INBOX.Github.Other.Notifications";

set "OTHER_CROWDIN" "INBOX.Other.Crowdin";
set "OTHER_FASTMAIL" "INBOX.Other.Fastmail";
set "OTHER_APPLE" "INBOX.Other.Apple";
set "OTHER_GOOGLE" "INBOX.Other.Google";
set "OTHER_AWS" "INBOX.Other.AWS";
set "OTHER_JIRA" "INBOX.Other.JIRA";
set "OTHER_GSOC" "INBOX.Other.GSoC";

# Github
if allof(
  address :matches "From" "*@github.com"
) {
  if anyof(
    header :matches "Subject" "Re: [oomol/*",
    header :matches "Subject" "[oomol/*"
  ) {
    fileinto "${GITHUB_OOMOL}";
    stop;
  }

  if anyof(
    header :matches "Subject" "Re: [electron/*",
    header :matches "Subject" "[electron/*"
  ) {
    fileinto "${GITHUB_ELECTRON}";
    stop;
  }

  if anyof(
    header :matches "Subject" "Re: [pnpm/*",
    header :matches "Subject" "[pnpm/*"
  ) {
    fileinto "${GITHUB_PNPM}";
    stop;
  }

  fileinto "${GITHUB}";
  stop;
}

# Crowdin
if allof(
  address :matches "From" "*@crowdin.com"
) {
  fileinto "${OTHER_CROWDIN}";
  stop;
}

# FastMail
if anyof(
  address :matches "From" "*@fastmail.help",
  address :matches "From" "*@fastmail.com"
) {
  fileinto "${OTHER_FASTMAIL}";
  addflag "$notify";
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

  fileinto "${OTHER_APPLE}";
  stop;
}

# Google
if anyof(
  address :matches "From" "*@google.com",
  address :matches "From" "*@googlemail.com",
  address :matches "From" "*@accounts.google.com",
  address :matches "From" "*@googlegroups.com"
) {
  fileinto "${OTHER_GOOGLE}";
  addflag "$notify";
  stop;
}

# AWS
if anyof(
  address :matches "From" "*@amazon.com",
  address :matches "From" "*@aws.amazon.com"
) {
  fileinto "${OTHER_AWS}";
  addflag "$notify";
  stop;
}

# JIRA
if anyof(
  address :matches "From" "*@am.atlassian.com",
  address :matches "From" "*@*.atlassian.net"
) {
  addflag "\\Seen";
  fileinto "${OTHER_JIRA}";
  stop;
}

# GSoC
if anyof(
  address :matches "From" "summer-of-code@electronjs.org",
  address :matches "From" "google-summer-of-code-mentors-list@googlegroups.com"
) {
  fileinto "${OTHER_GSOC}";
  stop;
}
