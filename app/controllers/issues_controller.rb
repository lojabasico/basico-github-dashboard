require 'basico-octokit'
class IssuesController < ApplicationController
  def index

    if params[:repo].present?
          @repo = params[:repo]
          @from = !params[:from].empty? && params[:from] || (Date.today - 30).strftime("%d/%m/%Y")
          @to = !params[:to].empty? && params[:to] || (Date.today + 1).strftime("%d/%m/%Y")

          summary = BasicoOctokit::SummaryApi::Issues.closed(Date.parse(@from.to_s),Date.parse(@to.to_s),@repo, "closed")
    end
  end
end
