class MainController < ApplicationController
  def index

  end

  def import
    Referral.import(params[:file])
    redirect_to statements_url, notice: "Statements imported."
  end

  def site
  end

  def referrer
  end

  def category
  end

  def share
  end
end
