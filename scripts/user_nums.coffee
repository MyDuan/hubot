env       = process.env.NODE_ENV || 'development';
config    = require(__dirname + '/../config/config.json')[env];

Sequelize = require('sequelize').Sequelize;
config.database = 'web_app';
Seq = new Sequelize(config.database, config.username, config.password, config);
User = Seq.import(__dirname + "/../models/web_user")
Seq.sync()

module.exports = (robot) ->

  robot.hear /user numbers/i, (msg) ->
    User.count().then (c) ->
      msg.send "#{c}"