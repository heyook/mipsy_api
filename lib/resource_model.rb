module ResourceModel
  module Model
    extend ActiveSupport::Concern
    include ActiveModel::Model

    included do
      attr_reader :resource
    end

    module ClassMethods
      def call(*args)
        new(*args).tap { |res| res.call }
      end

      def alias_resource(name)
        define_method(name) { resource }
      end
    end

    def as_json(*)
      if resource.valid?
        resource_json
      else
        super
      end
    end

    def resource_json
      raise NotImplementedError
    end

    def call
      raise NotImplementedError
    end
  end
end
