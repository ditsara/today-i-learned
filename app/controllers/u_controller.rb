# frozen_string_literal: true

class UController < ApplicationController
  before_action :require_login
end
