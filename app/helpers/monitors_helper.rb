module MonitorsHelper
  def host_name(name)
    if name.start_with?('23')
      result = "Staging API (#{name})"
    elsif name.start_with?('54')
      result = "Production API (#{name})"
    elsif name.start_with?('162')
      result = "CPG-Production API (#{name})"
    else
      result = name
    end
    link_to result, "http://#{name}/resque/overview", :target => '_blank'
  end
end
