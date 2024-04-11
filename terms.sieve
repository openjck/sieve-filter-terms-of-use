require [
  "include",
  "environment",
  "variables",
  "relational",
  "comparator-i;ascii-numeric",
  "spamtest",
  "fileinto",
  "imap4flags"
];

# Generated: When using Proton Mail, do not run this script on spam messages.
if allof (
  environment :matches "vnd.proton.spam-threshold" "*",
  spamtest :value "ge" :comparator "i;ascii-numeric" "${1}"
) {
  return;
}

# This is the folder that matching messages should be moved to.
set "folder" "Filtered out";

if allof (
  header :comparator "i;unicode-casemap" :contains "Subject" [
    "update",
    "updating",
    "change",
    "changing"
  ],
  header :comparator "i;unicode-casemap" :contains "Subject" [
    "policy",
    "policies",
    "terms",
    "user agreement",
    "legal agreement",
    "privacy notice",
    "privacy statement"
  ]
) {
  fileinto "${folder}";
}
