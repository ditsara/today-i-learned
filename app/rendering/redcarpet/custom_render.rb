class Redcarpet::CustomRender < Redcarpet::Render::HTML
  def postprocess(full_document)
    Rails.logger.debug "custom render"
    full_document
  end
end
