module RedmineBulkTimeEntries
  module Patches
    module TimeEntryPatch
      def self.included(base)
        base.class_eval do
          unloadable

          attr_accessor :date_range

          validate :spent_to_cannot_be_before_spent_on
          before_save :calculate_timelog_for_date_range

          safe_attributes 'spent_to'

          def spent_to_cannot_be_before_spent_on
          end

          def calculate_timelog_for_date_range
          end

        end
      end
    end
  end
end

unless TimeEntry.included_modules.include?(RedmineBulkTimeEntries::Patches::TimeEntryPatch)
  TimeEntry.send(:include, RedmineBulkTimeEntries::Patches::TimeEntryPatch)
end
