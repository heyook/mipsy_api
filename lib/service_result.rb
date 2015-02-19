module ServiceResult
  class Error < Hash
    def initialize(message)
      super
      self[:errors] = {msg: message}
    end
  end

  def success(content)
    [true, content]
  end

  def error(message)
    [false, Error.new(message)]
  end

  class ActiveRecordModelService
    include ServiceResult

    def initialize(block)
      @block = block
    end

    def call(model)
      if @block.call(model)
        success(model)
      else
        error(model.errors.full_messages.first)
      end
    end
  end

  module Responder
    def respond_with_service(*args, &block)
      service_class = nil
      arguments     = nil

      if block_given?
        model         = args.pop || raise('missing model')
        service_class = ActiveRecordModelService.new(block)
        arguments     = [model]
      else
        service_name  = args[0] || raise('missing service param')
        service_class = "#{service_name.to_s.camelize}Service".constantize
        arguments     = args[1..-1]
      end

      result, content = *service_class.call(*arguments)

      if result
        render json: content
      else
        Rails.logger.warn "Service error encountered: #{content}."
        render json: content, status: :unprocessable_entity
      end
    end
  end
end
