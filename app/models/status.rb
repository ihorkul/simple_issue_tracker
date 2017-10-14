class Status < ApplicationRecord
  DEFAULT_STATUSES = [{ name: 'Waiting for Staff Response',    id: 1 },
                      { name: 'Waiting for Customer Response', id: 2 },
                      { name: 'On Hold',                       id: 3 },
                      { name: 'Cancelled',                     id: 4 },
                      { name: 'Completed',                     id: 5 }
                     ].freeze
end
