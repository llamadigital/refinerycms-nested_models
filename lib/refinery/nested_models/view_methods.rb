module Refinery
  module NestedModels
    module ViewMethods

      def link_to_add_fields(name, f, association)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
          render(association.to_s.singularize + "_fields", f: builder)
        end
        link_to(name, '#', class: "add_fields", data: {id: id, add: true, fields: fields.gsub("\n", "")})
      end

      def link_to_remove_field(label, builder)
        ret = ''
        ret += builder.hidden_field :_destroy, :class => 'destroy'
        ret += link_to_function label, 'return true', class: 'remove_fields', data: {remove: true}
        raw ret
      end
    end
  end
end

::ActionView::Base.send(:include, Refinery::NestedModels::ViewMethods)
