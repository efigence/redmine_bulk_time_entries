require File.expand_path('../../test_helper', __FILE__)

class TimeEntryTest < ActiveSupport::TestCase
  fixtures :users, :projects

  def setup
    @time_entry = TimeEntry.new
    @time_entry.project_id = Project.first.id
    @time_entry.activity_id = 2
    @time_entry.hours = 5
    @time_entry.user_id = User.first.id
    @time_entry.spent_on = '2015-03-23'
  end

  def test_should_create_one_time_entry_without_given_time_range
    assert_difference 'TimeEntry.count', +1 do
      @time_entry.save
    end
  end

  def test_time_entry_with_spent_to_earlier_than_spent_on_should_not_be_saved
    assert_difference 'TimeEntry.count', 0 do
      @time_entry.spent_to = @time_entry.spent_on - 1.week
      @time_entry.save
    end
  end

  def test_should_create_multiple_time_entries_with_given_time_range
    assert_difference 'TimeEntry.count', +6 do
      @time_entry.spent_to = @time_entry.spent_on + 1.week
      @time_entry.save
    end
  end

end
