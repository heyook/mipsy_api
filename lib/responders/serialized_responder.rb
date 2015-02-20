module Responders
  module SerializedResponder

    def initialize(controller, resources, opts={})
      super
      serializer = opts.delete(:serializer) || \
        (controller.class.name.gsub("Controller","").singularize + "Serializer").constantize

      if resource.kind_of?(ActiveRecord::Relation)
        options.merge!(arrayserializer: serializer)
      else
        options.merge!(serializer: serializer)
      end
    end

  end
end
