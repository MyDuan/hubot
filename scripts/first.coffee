request = require('request')
console.log(process.env.HUBOT_SLACK_TOKEN)
module.exports = (robot) ->
  robot.hear /test (.*)?/, (msg) ->
    text = msg.match[1]
    request.get
      url: "https://slack.com/api/users.list?token=#{process.env.HUBOT_SLACK_TOKEN}"
      , (err, response, body) ->
        # Slack APIからメンバーを取得
        memberid = (member.id for member in JSON.parse(body).members when member.profile.display_name is text)
        msg.send "<@#{memberid}>"
