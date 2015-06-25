Redmine::Plugin.register :redmine_bulk_time_entries do
  name 'Redmine Bulk Time Entries plugin'
  author 'Maria Syczewska'
  description 'This is a plugin for Redmine for implementing bulk time entries'
  version '0.0.1'
  url 'https://github.com/efigence/redmine_bulk_time_entries'
  author_url 'https://github.com/efigence'
end

ActionDispatch::Callbacks.to_prepare do
  require 'redmine_bulk_time_entries/hooks/bulk_timelog'
  require 'redmine_bulk_time_entries/patches/time_entry_patch'
end
