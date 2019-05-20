module ReservationDecorator
  include ActionView::Helpers

  def status_tag
    case status
    when 0
      {name: "ok",class: "badge badge-primary"}
    when 1
      {name: "cancel",class: "badge badge-danger"}
    end
  end
end
