# include ::ThePublication::PublicationStates
module ThePublication
  module PublicationStates
    extend ActiveSupport::Concern

    STATES = %w[ draft published deleted ]

    included do
      state_field_name = :state
      state_field_name = self::STATE_FILED_NAME if defined? self::STATE_FILED_NAME

      validates_inclusion_of state_field_name, in: STATES

      scope :with_state, ->(states){ where state_field_name => Array.wrap(states) }
      scope :for_manage, ->{ with_state %w[ draft published ] }

      scope :draft,      ->{ with_state :draft     }
      scope :published,  ->{ with_state :published }
      scope :deleted,    ->{ with_state :deleted   }

      STATES.each do |state|
        define_method "#{ state }?" do
          self.send(state_field_name).to_s == state.to_s
        end

        define_method "#{ state }!" do
          self.send("#{ state_field_name }=", state)
          save!
        end
      end # STATES.each
    end # included

  end # StatesProcessing
end
