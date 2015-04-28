require 'active_support'
require 'active_support/core_ext'
require 'keen'

time = Time.now
result = Keen.funnel(
  {
    steps: [
      {
        event_collection: 'test_page_view',
        actor_property: 'anonymousId',
        filters: [
          {
            property_name: 'properties.path',
            operator: 'eq',
            property_value: 'donation_form'
          },
          {
            property_name: 'keen.timestamp',
            operator: 'lt',
            property_value: 24.hours.ago.iso8601
          }
        ]
      },
      {
        event_collection: 'test_page_view',
        actor_property: 'anonymousId',
        with_actors: true,
        filters: [
          {
            property_name: 'properties.path',
            operator: 'eq',
            property_value: 'donation_form#email'
          },
          {
            property_name: 'keen.timestamp',
            operator: 'lt',
            property_value: 24.hours.ago.iso8601
          }
        ]
      }
    ]
  },
  {
    response: :all_keys,
    method: :post
  }
)

puts "TIME: #{Time.now - time}"
p result['result']
actors = result['actors'][1]
p actors.count

time = Time.now
result = Keen.funnel(
  {
    steps: [
      {
        event_collection: 'test_page_view',
        actor_property: 'properties.email',
        filters: [
          {
            property_name: 'properties.path',
            operator: 'eq',
            property_value: 'donation_form#email'
          },
          {
            property_name: 'anonymousId',
            operator: 'in',
            property_value: actors
          }
        ]
      },
      {
        event_collection: 'test_page_received_donation',
        actor_property: 'properties.donor_email',
        inverted: true
      },
      {
        event_collection: 'test_email_send',
        actor_property: 'properties.receiver',
        with_actors: true,
        inverted: true,
        filters: [
          {
            property_name: 'properties.subject',
            operator: 'eq',
            property_value: 'Donation Reminder'
          }
        ]
      }
    ]
  },
  {
    response: :all_keys,
    method: :post
  }
)
puts "TIME: #{Time.now - time}"
p result['result']
actors = result['actors'][2]
p actors.first(10)
