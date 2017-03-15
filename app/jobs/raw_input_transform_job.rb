class RawInputTransformJob < ActiveJob::Base
  def perform(import_id)
    import = Import.find_by id: import_id
    return unless import
    raw_input = import.raw_inputs.where(state: nil).first
    return unless raw_input

    RawInputChanges.apply raw_input
    self.class.perform_later(import_id)
  end
end
