require 'basico-octokit'
class IssuesController < ApplicationController

  def index

    if params[:repo].present?

          @repo = params[:repo]
          @from = !params[:from].empty? && params[:from] || (Date.today - 30).strftime("%d/%m/%Y")
          @to = !params[:to].empty? && params[:to] || (Date.today + 1).strftime("%d/%m/%Y")

          begin
            #summary = BasicoOctokit::SummaryApi::Issues.closed(Date.parse(@from.to_s),Date.parse(@to.to_s),@repo, "closed")
            @ticket_users = ChartGenerator.ticket_users(@repo, Date.parse(@from.to_s),Date.parse(@to.to_s))
            @ticket_labels = ChartGenerator.ticket_labels(@repo, Date.parse(@from.to_s),Date.parse(@to.to_s))

          rescue Octokit::Unauthorized
            @error = AppError.new
            @error.message = '401 - Bad token. Unauthorized'
          end

    end

  end

end
