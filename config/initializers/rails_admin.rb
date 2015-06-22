RailsAdmin.config do |config|

  ### Popular gems integration

  # Field specs
  config.model 'User' do
    list do
      field :email
      field :code_allowance
      field :created_at
      field :sign_in_count
      field :last_sign_in_at
    end
  end

  config.model 'Attendee' do
    list do
      field :name
      field :email
      field :access_code
      field :ordered_at
    end
  end

  config.model 'AccessCode' do
    list do
      field :user_id
      field :code
      field :created_at
      field :attendees
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
