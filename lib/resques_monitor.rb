require 'open-uri'

module ResquesMonitor

  def self.get_resque_data(ips)
    hosts = ips
    resque_data = []

    hosts.each do |host|
      html = `curl "http://#{ResqueMonitor.config.resque_login}:#{ResqueMonitor.config.resque_password}@#{host}/resque/overview"`
      doc = Nokogiri::HTML(html)

      queues = ''
      queues_results = []

      doc.css('.queues').each do |link|
        queues += link.content
      end
      queues = queues.gsub(' ', '').split("\n\n\n").each do |element|
        element.gsub!("\n", ' ')
      end
      queues.shift
      queues.each do |queue|
        queue.strip!
        result = queue.split(' ')
        queues_results << result if result.size == 2
        break if result[0] == 'failed'
      end

      workers = ''
      workers_results = []
      doc.css('.workers').each do |link|
        workers += link.content
      end
      workers = workers.gsub(' ', '').split("\n\n\n\n\n").each do |element|
        element.gsub!("\n", ' ')
      end
      if workers.size > 1
        workers.shift
        workers.each do |worker|
          worker.strip!
          workers_results << worker.split(' ')
        end
      end

      workers_title = ''
      doc.css('.wi').each do |link|
        workers_title += link.content
      end
      workers_title = workers_title.gsub('Queues', '')

      resque_data << {host => {queues: queues_results, workers: workers_results, workers_title: workers_title}}
    end

    resque_data
  end
end