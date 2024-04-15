# frozen_string_literal: true

class AController < ApplicationController
  before_action :require_login
  before_action :require_admin

  # Check that user is an admin. This is only a precaution, because user admin
  # actions will also be checked against the policy per-model.
  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path, notice: 'You must be an admin to access this page'
    end
  end
end
