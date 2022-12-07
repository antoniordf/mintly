module ApplicationHelper
  def max_tick_graph(period)
    case period
    when 1 then return 2
    when 7 then return 7
    else
      return 3
    end
  end
end
