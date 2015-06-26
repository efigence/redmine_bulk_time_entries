require File.expand_path('../../test_helper', __FILE__)

class AccountTest < Redmine::IntegrationTest
  fixtures :users

  def setup
    log_user("jsmith", "jsmith")
  end

  def test_hook_should_fetch_time_range
    get '/time_entries/new'
    assert_response :success
    assert_select '#time_entry_time_range'
    assert_select '#time_entry_spent_to'
  end

end
