module RedmineBulkTimeEntries
  module Patches
    module TimeEntryPatch
      def self.included(base)
        base.class_eval do
          unloadable

          attr_accessor :time_range
          attr_accessor :spent_to

          validate :spent_to_cannot_be_before_spent_on
          after_save :create_time_entries_for_date_range

          def spent_to_cannot_be_before_spent_on
            errors.add(:spent_to, "should be later than beginning date") if
            spent_to && spent_to < spent_on
          end

          def create_time_entries_for_date_range
            if self.spent_to
              self.spent_on += 1.day
              while self.spent_on <= self.spent_to
                if !self.spent_on.saturday? && !self.spent_on.sunday?
                  t = self.dup
                  t.spent_on = self.spent_on
                  t.spent_to = nil
                  t.save
                end
                self.spent_on += 1.day
              end
            end
          end

        end
      end
    end
  end
end

unless TimeEntry.included_modules.include?(RedmineBulkTimeEntries::Patches::TimeEntryPatch)
  TimeEntry.send(:include, RedmineBulkTimeEntries::Patches::TimeEntryPatch)
end
