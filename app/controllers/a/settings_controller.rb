# frozen_string_literal: true

class A::SettingsController < AController
  def create
    # @errors = ActiveModel::Errors.new
    setting_params.each_key do |key|
      next if setting_params[key].nil?

      setting = Setting.new(var: key)
      setting.value = setting_params[key].strip
      # @errors.merge!(setting.errors) unless setting.valid?
    end

    # render :new if @errors.any?

    setting_params.each_key do |key|
      Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
    end

    redirect_to new_a_setting_path, notice: 'Setting was successfully updated.'
  end

  private

  def setting_params
    params.require(:setting).permit(:dev)
  end
end
