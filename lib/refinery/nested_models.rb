require 'refinerycms-core'
require 'refinery/nested_models/view_methods'

module Refinery
  module NestedModels
    require 'refinery/nested_models/engine'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end
