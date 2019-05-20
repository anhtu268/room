module LocationDecorator
  include ActionView::Helpers

  def select_option
    Location.pluck :name
  end

  def status_tag
    return {name: t("decorators.location.activated"),class: "badge badge-success"} if status
    {name: t("decorators.location.non_activated"),class: "badge badge-dark"}
  end

  def location_type_option
    LocationType.option_list.collect {|p| [ p.name, p.id ] }
  end

  def rate_badge
    case total_rate
    when 0..1.9
      "badge badge-danger"
    when 2..3.9
      "badge badge-warning"
    when 4..5
      "badge badge-success"
    end
  end
end
