# frozen_string_literal: true
# This migration comes from easy_feedback (originally 20210326185644)

class CreateEasyFeedbackReports < ActiveRecord::Migration[6.1]
  def change
    create_table :easy_feedback_reports do |t|
      t.string :detail
      t.string :reporter

      t.timestamps
    end
  end
end
