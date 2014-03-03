class MainController < ApplicationController
  def index

  end

  def import
    Referral.import(params[:file])
    redirect_to root_url, notice: "Referrers imported."
  end

  def site
    @site = Referral.where(:site => params[:site])
    @search = @site.search(params[:q])
    @search.sorts = 'updated_at desc' if @search.sorts.empty?
    @referrals_all = @search.result(:distinct => true)
    @referrals = @referrals_all.page(params[:page]).per(20)
    @search.build_condition
  end

  def referrer
  end

  def category
  end

  def share
  end
end
