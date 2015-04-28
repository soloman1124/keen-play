require 'active_support'
require 'active_support/core_ext'
require 'keen'
require 'faker'

def events_hash
  Hash.new { |h, k| h[k] = [] }
end

def publish events
  Keen.publish_batch events
end

def fake_email
  Random.rand(1000000).to_s + Faker::Internet.email
end

# 5_000 users visited the donation form
events = events_hash.tap do |hash|
  5_000.times.each do
    anonymous_id = SecureRandom.uuid
    time = Random.rand(2*24*60).minutes.ago
    hash[:test_page_view] << {
      anonymousId: anonymous_id,
      properties: {
        path: 'donation_form'
      },
      keen: {
        timestamp: time.iso8601
      }
    }
  end
end
publish events


# 4_000 users visited the donation form and filled in emails
events = events_hash.tap do |hash|
  4_000.times.each do
    anonymous_id = SecureRandom.uuid
    time = Random.rand(2*24*60).minutes.ago
    hash[:test_page_view] << {
      anonymousId: anonymous_id,
      properties: {
        path: 'donation_form'
      },
      keen: {
        timestamp: time.iso8601
      }
    }

    time += Random.rand(5*60).seconds
    hash[:test_page_view] << {
      anonymousId: anonymous_id,
      properties: {
        path: 'donation_form#email',
        email: fake_email
      },
      keen: {
        timestamp: time.iso8601
      }
    }
  end
end
publish events


# 3_000 users donated
events = events_hash.tap do |hash|
  3_000.times.each do
    anonymous_id = SecureRandom.uuid
    time = Random.rand(2*24*60).minutes.ago
    hash[:test_page_view] << {
      anonymousId: anonymous_id,
      properties: {
        path: 'donation_form'
      },
      keen: {
        timestamp: time.iso8601
      }
    }

    donor_email = fake_email
    time += Random.rand(5*60).seconds
    hash[:test_page_view] << {
      anonymousId: anonymous_id,
      properties: {
        path: 'donation_form#email',
        email: donor_email
      },
      keen: {
        timestamp: time.iso8601
      }
    }

    time += Random.rand(5*60).seconds
    hash[:test_page_received_donation] << {
      anonymousId: anonymous_id,
      properties: {
        donor_email: donor_email
      },
      keen: {
        timestamp: time.iso8601
      }
    }
  end
end
publish events

# 2_000 users got the donation emails
events = events_hash.tap do |hash|
  2_000.times.each do
    anonymous_id = SecureRandom.uuid
    time = Random.rand(2*24*60).minutes.ago
    hash[:test_page_view] << {
      anonymousId: anonymous_id,
      properties: {
        path: 'donation_form'
      },
      keen: {
        timestamp: time.iso8601
      }
    }

    donor_email = fake_email
    time += Random.rand(5*60).seconds
    hash[:test_page_view] << {
      anonymousId: anonymous_id,
      properties: {
        path: 'donation_form#email',
        email: donor_email
      },
      keen: {
        timestamp: time.iso8601
      }
    }

    time += Random.rand(10*60).minutes
    hash[:test_email_send] << {
      anonymousId: anonymous_id,
      properties: {
        receiver: donor_email,
        subject: 'Donation Reminder'
      },
      keen: {
        timestamp: time.iso8601
      }
    }
  end
end
publish events


# 2_000 users got the donation emails and donated
events = events_hash.tap do |hash|
  2_000.times.each do
    anonymous_id = SecureRandom.uuid
    time = Random.rand(2*24*60).minutes.ago
    hash[:test_page_view] << {
      anonymousId: anonymous_id,
      properties: {
        path: 'donation_form'
      },
      keen: {
        timestamp: time.iso8601
      }
    }

    donor_email = fake_email
    time += Random.rand(5*60).seconds
    hash[:test_page_view] << {
      anonymousId: anonymous_id,
      properties: {
        path: 'donation_form#email',
        email: donor_email
      },
      keen: {
        timestamp: time.iso8601
      }
    }

    time += Random.rand(10*60).minutes
    hash[:test_email_send] << {
      anonymousId: anonymous_id,
      properties: {
        receiver: donor_email,
        subject: 'Donation Reminder'
      },
      keen: {
        timestamp: time.iso8601
      }
    }

    time += Random.rand(10*60).minutes
    hash[:test_page_received_donation] << {
      anonymousId: anonymous_id,
      properties: {
        donor_email: donor_email
      },
      keen: {
        timestamp: time.iso8601
      }
    }
  end
end
publish events
