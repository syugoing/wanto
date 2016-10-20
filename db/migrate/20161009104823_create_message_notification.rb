class CreateMessageNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :message, index: true, foreign_key: true
  end
end
