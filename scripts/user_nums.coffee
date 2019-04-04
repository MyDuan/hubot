env       = process.env.NODE_ENV || 'development';
config    = require(__dirname + '/../config/config.json')[env];
cronJob   = require('cron').CronJob
Sequelize = require('sequelize').Sequelize;

if(!config.password)
  config.password = process.env.HUBOT_DB_PASS
Seq = new Sequelize(config.database, config.username, config.password, config);
User = Seq.import(__dirname + "/../models/web_user")
Seq.sync()

axios = require('axios');
FBURL = "https://www.facebook.com/lightenedjp";
module.exports = (robot) ->
  robot.hear /user numbers/i, (msg) ->
    User.count().then (c) ->
      axios.get(FBURL).then (response) ->
        html = response.data;
        like = html.match(/#x300d;(.*?)&#x4ef6;/)[1];
        msg.send "```user namebers in db: #{c}" +"\n"+
        "Likes in facebook: #{like}```"

  send = (channel, msg) ->
      robot.send {room: channel}, msg

  new cronJob('0 00 19 * * 1-5', () ->
    User.count().then (c) ->
      axios.get(FBURL).then (response) ->
        html = response.data;
        like = html.match(/#x300d;(.*?)&#x4ef6;/)[1];
        send '#ml', "```user namebers in db: #{c}" +"\n"+
        "Likes in facebook: #{like}```"
  ).start()

  new cronJob('0 30 19 * * 1-5', () ->
      send '#ml', "@here 退勤の時間ですよう~~"
  ).start()
