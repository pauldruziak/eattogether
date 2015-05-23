module EventsHelper
  def group_by_family(participants)
    participants.group_by { |p| p.family_name }.reduce({}) do |a, (family_name, participants_by_family)|
      a.merge family_name => sprintf('%.2f', participants_by_family.map(&:amount).sum)
    end
  end
end
