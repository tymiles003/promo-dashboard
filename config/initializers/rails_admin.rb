RailsAdmin.config do |config|
  config.model 'User' do
    object_label_method do
      :full_name
    end

    field :first_name
    field :last_name
    field :email
    field :admin
    field :events
    field :codes_created
    field :attendees_referred
    field :created_at
    field :sign_in_count
    field :last_sign_in_at

    edit do
      exclude_fields :current_event_access_codes, :current_event_attendees, :current_event_access_code_types, :codes_created, :attendees_referred
      exclude_fields :created_at, :sign_in_count, :last_sign_in_at
    end

    list do
      # scopes [:current_event, nil]
      items_per_page 100
    end
  end

  config.model 'UserAccessCodeType' do
    list do
      items_per_page 100
    end

    object_label_method do
      :to_s
    end

    field :event do
      formatted_value do
        bindings[:object].event.title
      end
    end
    field :user
    field :access_code_type
    field :allowance

    edit do
      exclude_fields :event
    end
  end

  config.model 'UserEvent' do
    list do
      # scopes [:current_event, nil]
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
      # scopes [:current_event, nil]
    end

    field :title
    field :description
    field :start_at
    field :end_at
    field :eventbrite_url
    field :users
    field :ticket_classes
    field :access_code_types

    edit do
      field :eventbrite_event_id, :string do
        label do
          'EventBrite Event ID'
        end
      end
    end
  end

  config.model 'TicketClass' do
    object_label_method do
      :name
    end
    field :event
    field :name
    field :description
    field :cost
    field :donation
    field :sales_start
    field :sales_end
    field :eventbrite_ticket_class_id
    field :hide_on_dashboard

    list do
      exclude_fields :eventbrite_ticket_class_id
    end

  end

  config.model 'AccessCodeType' do
    object_label_method do
      :name
    end

    list do
      # scopes [:current_event, nil]
    end

    field :event
    field :name
    field :default_allowance
    field :ticket_classes
  end

  config.model 'AccessCode' do
    object_label_method do
      :code
    end

    list do
      # scopes [:current_event, nil]
      items_per_page 100
      field :user do
        formatted_value do
          bindings[:object].user.full_name
        end
      end

      field :access_code_type do
        formatted_value do
          if bindings[:object] && bindings[:object].has_method?(:access_code_type)
            bindings[:object].access_code_type.name
          else
            'No Access Code Type!'
          end
        end
      end
      field :code
      field :attendees_referred
      field :attendees
      field :created_at
    end

    edit do
      exclude_fields :access_code_type
    end
  end

  config.model 'Attendee' do
    object_label_method do
      :name
    end

    list do
      # scopes [:current_event, nil]
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
