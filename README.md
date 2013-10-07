# Nested Models extension for Refinery CMS.

## How to use

``` ruby
gem 'refinerycms-nested_models'
```


## Nesting Models

You need to nest models in the normal rails way, with accepts nested attributes for e.g. the following in the 'parent' model:

``` ruby
has_many :nested_models
accepts_nested_attributes_for :nested_models, allow_destroy: true
attr_accessible :nested_models_attributes
```

And the following in the nested model: 

``` ruby
belongs_to :page, class_name: 'Refinery::Page'
```

This is the basic setup, you then need to add to your views.

In the form of the parent model you should add the followuing:

``` erb
<div class='field'>
  <%= f.label :nested_models %>
  <%= f.fields_for :nested_models do |j| %>
    <%= render 'refinery/admin/pages/nested_model_fields', :f => j %>
  <% end %>
  <%= link_to_add_fields 'Add nested model', f, :nested_models %>
</div>
```

The this block renders any existing nested objects in the page and also adds a link for adding new nested models.  This works by embedding the html which should be insert into the page in the data-field of the link.  When you click the link JS is executed to replace some placeholders in the data-field and insert it into the page, above the link.  Some callbacks are also executed to enable any modals in the newly inserted HTML.

You will also need to create the partial file mentioned (refinery/admin/pages/nested_model_fields - where nested_model_fields is the singular name of the association from the parent model with "_fields" appended to it).

Below is an example of the nested model fields:

``` erb
<fieldset class='nested'>
  <div class='field'>
    <%= f.label :name %>
    <%= f.text_field :name %>
  </div>
  <div class='field'>
    <%= f.label :image %>
    <%= render 'refinery/admin/image_picker', f: f, field: :image_id, image: f.object.image %>
  </div>
  <%= link_to_remove_field 'Remove this nested model', f %>
</fieldset>
```

This form contains any attributes which should appear from the nested model as well as a link_to_remove_field.  Link to remove field adds a link to a JS function and a hidden field to mark the nested element for removal.

### Sorting nested elements

To sort nested elements you should add the following code in your parent form: 

``` erb
<div class='field' data-sortable='true'>
```

And this into the nested model fields: 

``` erb
<%= refinery_icon_tag 'arrow_switch', 'data-handle' => true, :title => 'Reorder', :class => 'handle' %>
  <%= f.hidden_field :position, 'data-position' => true %>
```

And the following to the nested model:

``` ruby
  attr_accessible :position
```

### Adding refinery images to nested models

Add the following to the nested model:

``` ruby
belongs_to :image, class_name: 'Refinery::Image'
```

And this to the nested field partial:

``` erb
<%= render 'refinery/admin/image_picker', f: f, field: :image_id, image: f.object.image %>
```

