module ReviewDecorator
  include ActionView::Helpers

  def rate_badge
    case rate
    when 0..1.9
      "badge badge-danger"
    when 2..3.9
      "badge badge-warning"
    when 4..5
      "badge badge-success"
    end
  end
end
