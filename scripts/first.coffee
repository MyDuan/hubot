request = require('request')

_users = []

module.exports = (robot) ->
  robot.hear /user list/, (msg) ->
    text = msg.match[1]
    request.get
      url: "https://slack.com/api/users.list?token=#{process.env.HUBOT_SLACK_TOKEN}"
      , (err, response, body) ->
        # Slack APIからメンバーを取得
        i = 0
        for member in JSON.parse(body).members when (member.deleted==false and member.is_app_user==false and member.is_bot==false)
          if member.profile.display_name
            _users[i] = member.profile.display_name
            i++
        msg.send "#{_users}"
