RailsAdmin.config do |config|

  config.model 'UserEvent' do
    list do
      scopes [:current_event, nil]
      items_per_page 100
    end

    field :user
    field :event
    field :code_allowance do

    end
  end

  # Field specs
  config.model 'Event' do
    object_label_method do
      :title
    end

    list do
      scopes [:current_event, nil]
    end

    field :title
    field :description
    field :start_at
    field :end_at

    field :uses_per_code
    field :eventbrite_url
    field :users

    edit do
      field :eventbrite_event_id, :string do
        label do
          'EventBrite Event ID'
        end
      end
      field :ticket_class_ids
    end
  end

  config.model 'User' do
    object_label_method do
      :full_name
    end

    field :first_name
    field :last_name
    field :email
    field :admin
    field :events
    field :current_event_attendees
    field :current_event_access_codes
    field :codes_created
    field :attendees_referred
    field :created_at
    field :sign_in_count
    field :last_sign_in_at

    edit do
      exclude_fields :current_event_attendees, :current_event_access_codes, :codes_created, :attendees_referred
      exclude_fields :created_at, :sign_in_count, :last_sign_in_at
    end

    list do
      scopes [:current_event, nil]
      items_per_page 100
    end
  end

  config.model 'AccessCode' do
    object_label_method do
      :code
    end

    list do
      scopes [:current_event, nil]
      items_per_page 100
      field :user do
        formatted_value do
          bindings[:object].user.full_name
        end
      end
      field :code
      field :attendees_referred
      field :attendees
      field :created_at
    end
  end

  config.model 'Attendee' do
    object_label_method do
      :name
    end

    list do
      scopes [:current_event, nil]
      items_per_page 100
      field :name
      # field :gender do
      #   formatted_value do
      #     if value === true
      #       "Female"
      #     elsif value === false
      #       "Male"
      #     else
      #       "Unknown"
      #     end
      #   end
      #   pretty_value do
      #     if value === true
      #       "Female"
      #     elsif value === false
      #       "Male"
      #     else
      #       "Unknown"
      #     end
      #   end
      # end
      field :email
      field :user do
        label do
          "Inviting User"
        end
        formatted_value do
          bindings[:object].user.full_name
        end
      end
      field :access_code do
        formatted_value do
          bindings[:object].access_code.full_name
        end
      end
      field :ordered_at
      # field :last_genderize_at
    end
  end

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end

  ## == Cancan ==
  config.authorize_with :cancan
  config.current_user_method { current_user }

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
