# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  
    can :manage, Task, owner_id: user.id
    can :read, Task, participations: { user_id: user.id }
  end
end
