require 'rails_helper'

RSpec.describe "events/index", type: :view do
  it 'handles no events case' do
    events = Event.where("1 = 0")
    assign(:events, events)

    render

    expect (rendered).to include("You currently have no events")
  end

  it 'displays the users events' do

    my_first_event = Event.create(title: "First Amazing Event", start_at: Time.now + 5.days, end_at: Time.now + 6.days, eventbrite_event_id: 123, uses_per_code: 1)
    my_second_event = Event.create(title: "Second Amazing Event", start_at: Time.now + 3.days, end_at: Time.now + 4.days, eventbrite_event_id: 124, uses_per_code: 1)

    events = [my_first_event, my_second_event]
    assign(:events, events)

    render

    expect(rendered).to include("First Amazing Event")
    expect(rendered).to include("Second Amazing Event")
  end
end
