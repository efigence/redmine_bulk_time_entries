require File.expand_path('../../test_helper', __FILE__)

class TimeEntryTest < ActiveSupport::TestCase
  fixtures :users, :projects

  def setup
    @time_entry = TimeEntry.new(:activity_id => 2, :hours => 5, :spent_on => '2015-03-23')
    @time_entry.project_id = Project.first.id
    @time_entry.user_id = User.first.id
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
    TimeEntry.destroy_all

    assert_difference 'TimeEntry.count', +6 do
      @time_entry.spent_to = @time_entry.spent_on + 1.week
      @time_entry.save
    end

    assert_equal 6, TimeEntry.all.map(&:spent_on).uniq.count
  end

  def test_should_exclude_holidays_from_creating_bulk_time_entries

    assert_difference 'TimeEntry.count', +1 do
      @time_entry.spent_on = '2015-04-30'
      @time_entry.spent_to = '2015-05-03'
      @time_entry.save
    end
  end

end
