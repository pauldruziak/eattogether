Given(/^що я та (.*?) входимо до сім'ї "(.*?)"$/) do |user_name, family_name|
  @family = create :family, event: @event, creator: @user, name: family_name
  other_user = User.find_by_name(user_name)
  @event.participants.where(user_id: [@user.id, other_user.id]).update_all family_id: @family.id
end
