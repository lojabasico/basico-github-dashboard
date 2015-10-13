require 'basico-octokit'
class ChartGenerator
  class << self
    def ticket_solved(*args)
    end

    def ticket_labels(*args)
      labels = self.closed_tickets(*args).summary_labels.collect {|sl| sl.ticket_label.name}
      series = self.closed_tickets(*args).summary_labels.collect {|sl| sl.total}

      series, labels = series.zip(labels).sort.reverse.transpose
      ChartData.new({
        labels: labels,
        series: series
      })
    end

    def ticket_users(*args)
      labels = self.closed_tickets(*args).summary_users.collect {|su|su.ticket_user.login}
      series = self.closed_tickets(*args).summary_users.collect {|su|su.total}

      series,labels = series.zip(labels).sort.reverse.transpose
      ChartData.new({
        labels: labels,
        series: series
      })
    end

    def closed_tickets(repo,date_start,date_end)
      Rails.cache.fetch("closed_tickets_#{repo}_#{date_start}_#{date_end}",expires_in: 24.hours) do
        BasicoOctokit::SummaryApi::Issues.closed(date_start,date_end,repo, "closed")
      end
    end

  end
end
