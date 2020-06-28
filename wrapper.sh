#!/bin/bash

export BOTLOGIN=/phantombot/config/botlogin.txt

function setProp {
  local prop=$1
  local var=${2}
  if [ -n "$var" ]; then
    # normalize booleans
    case ${var^^} in
      TRUE|FALSE)
        var=${var,,} ;;
    esac

    echo "Setting ${prop} to '${var}' in ${BOTLOGIN}"
    echo "${prop}=${var}" >> ${BOTLOGIN}
  else
    echo "Skip setting ${prop}"
  fi
}

setProp "apioauth" "$APIOAUTH"
setProp "channel" "$CHANNEL"
setProp "clientid" "$CLIENTID"
setProp "musicenable" "$MUSICENABLE"
setProp "oauth" "$OAUTH"
setProp "owner" "$OWNER"
setProp "panelpassword" "$PANELPASSWORD"
setProp "paneluser" "$PANELUSER"
setProp "twitchalertskey" "$TWITCHALERTSKEY"
setProp "twitchalertslimit" "$TWITCHALERTSLIMIT"
setProp "twitterUser" "$TWITTERUSER"
setProp "twitter_access_token" "$TWITTER_ACCESS_TOKEN"
setProp "twitter_consumer_key" "$TWITTER_CONSUMER_KEY"
setProp "twitter_consumer_secret" "$TWITTER_CONSUMER_SECRET"
setProp "twitter_secret_token" "$TWITTER_SECRET_TOKEN"
setProp "webauth" "$WEBAUTH"
setProp "webauthro" "$WEBAUTHRO"
setProp "webenable" "$WEBENABLE"
setProp "user" "$USER"
setProp "devcommands" "$DEVCOMMANDS"
setProp "datastore" "$DATASTORE"
setProp "mysqlhost" "$MYSQLHOST"
setProp "mysqlname" "$MYSQLNAME"
setProp "mysqlpass" "$MYSQLPASS"
setProp "mysqlport" "$MYSQLPORT"
setProp "mysqluser" "$MYSQLUSER"
setProp "youtubekey" "$YOUTUBEKEY"
setProp "ytauth" "$YTAUTH"
setProp "discord_token" "$DISCORD_TOKEN"
setProp "twitch_tcp_nodelay" "$TWITCH_TCP_NODELAY"

echo "Done setting variables..."

echo $USER

echo "Launching bot..."
cd /phantombot && ./launch-service.sh -D
