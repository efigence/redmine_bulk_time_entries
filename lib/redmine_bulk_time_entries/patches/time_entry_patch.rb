require 'holidays'
require 'holidays/pl'

module RedmineBulkTimeEntries
  module Patches
    module TimeEntryPatch
      def self.included(base)
        base.class_eval do
          unloadable

          attr_accessor :time_range
          attr_accessor :spent_to

          validate :spent_to_cannot_be_before_spent_on
          after_save :create_time_entries_for_time_range

          safe_attributes 'spent_to'

          def spent_to_cannot_be_before_spent_on
            errors.add(:spent_to, "should be later than Date") if
            spent_to && spent_on && spent_to < spent_on
          end

          def create_time_entries_for_time_range
            return unless spent_to
            create_time_entries(self.spent_on, spent_to)
          end

          def spent_to
            return @spent_to if @spent_to.kind_of?(Date) || @spent_to.nil?
            Date.parse(@spent_to)
          rescue
            nil
          end

          protected

          def holiday?(date)
            date.saturday? || date.sunday? || date.holiday?
          end

          def create_time_entries(date, max_date)
            return unless date < max_date
            date += 1
            create_time_entry(date) unless holiday?(date)
            create_time_entries(date, max_date)
          end

          def create_time_entry(date)
            t = self.dup
            t.spent_on = date
            t.spent_to = nil
            t.save
          end

        end
      end
    end
  end
end

unless TimeEntry.included_modules.include?(RedmineBulkTimeEntries::Patches::TimeEntryPatch)
  TimeEntry.send(:include, RedmineBulkTimeEntries::Patches::TimeEntryPatch)
end
