# frozen_string_literal: true

module TTY
  module Exit
    module Registry
      # A storage for custom exit codes
      #
      # @api private
      def self.exits
        @exits ||= {}
      end

      # Register a custom exit code
      #
      # @param [String] name
      # @param [Integer] code
      # @param [String] message
      #
      # @api public
      def self.register_exit(name, code, message)
        exits[name] = {code: code, message: message}
        exits[code] = {code: code, message: message}
      end
    end # Registry
  end # Exit
end # TTY
