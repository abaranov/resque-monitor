module MonitorsHelper
  def host_name(name)
    if name.start_with?('23')
      result = "Staging API (#{name})"
    elsif name.start_with?('162.150.163.67')
      result = "CPG-Staging API (#{name})"
    elsif name.start_with?('54')
      result = "Production API (#{name})"
    elsif name.start_with?('162')
      result = "CPG-Production API (#{name})"
    elsif name.end_with?('8888')
      result = "Staging Collector (#{name})"
    elsif name.end_with?('8889')
      result = "Production Collector (#{name})"
    else
      result = name
    end
    link_to result, "http://#{name}/resque/overview", :target => '_blank'
  end
end
