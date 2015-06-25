# Redmine Bulk Time Entries plugin (work in progress - do not use)

#### Plugin which enables registering bulk time entries.

## Requirements

Developed and tested on Redmine 3.0.3.

## Installation

1. Go to your Redmine installation's plugins/directory.
2. `git clone https://github.com/efigence/redmine_bulk_time_entries`
3. Go back to root directory.
4. `rake redmine:plugins:migrate RAILS_ENV=production`
5. Restart Redmine.

## Usage

* In case of longer periods of absence user does not have to complete timelog day by day - it is possible to choose a range and automatically fill in the hours for each day between these two dates


## License

    Redmine Bulk Time Entries plugin
    Copyright (C) 2015  efigence S.A.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
