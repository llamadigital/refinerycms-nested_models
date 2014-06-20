module Refinery
  module NestedModels
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::NestedModels

      engine_name :refinery_nested_models

      initializer "register refinerycms_nested_models plugin" do
        # do not register plugin
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::NestedModels)
      end

      Refinery::Core.configure do |config| #   # Register extra javascript for backend
        config.register_javascript 'refinery/nested_models.js'
        config.register_stylesheet "refinery/nested_models.css", :media => 'screen'
      end
    end
  end
end
