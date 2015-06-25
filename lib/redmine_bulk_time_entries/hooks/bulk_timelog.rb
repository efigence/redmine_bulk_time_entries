class BulkTimelogHookListener < Redmine::Hook::ViewListener
  render_on :view_timelog_edit_form_bottom, :partial => "timelog/bulk_timelog"
end

