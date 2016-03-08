require 'rails_helper'

RSpec.describe "events/index", type: :view do
  context 'user has no events' do
    before do
      assign(:events, Event.none)
    end

    it 'displays you have no events message' do
      render

      expect (rendered).to contain("You currently have no events")
    end

  end

  context 'user has events' do
    before do
      my_first_event = Event.create(id:42, title: "First Amazing Event", start_at: Time.now + 5.days, end_at: Time.now + 6.days, eventbrite_event_id: 123, uses_per_code: 1)
      my_second_event = Event.create(id: 43, title: "Second Amazing Event", start_at: Time.now + 3.days, end_at: Time.now + 4.days, eventbrite_event_id: 124, uses_per_code: 1)

      events = [my_first_event, my_second_event]
      assign(:events, events)
    end

    it 'displays the users events' do
      render

      expect(rendered).to contain("First Amazing Event")
      expect(rendered).to contain("Second Amazing Event")
    end
  end



end
