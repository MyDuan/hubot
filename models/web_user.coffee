'use strict';
module.exports = (sequelize, DataTypes) ->
  web_user = sequelize.define('web_user',
    {
      user_id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        unique: true,
        primaryKey: true
      }
      user_name: {
        type: DataTypes.STRING,
      }
      email:  {
        type: DataTypes.STRING,
        isEmail: true
      }
      deleted_at: {
        type: DataTypes.DATE
      }
    }
    paranoid:    true
    underscored: true
  );
