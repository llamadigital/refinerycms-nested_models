jQuery ->
  window.init_nested_sorts()

  $('form').on 'click', '[data-remove="true"]', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('[data-nested-item="true"]').hide()
    event.preventDefault()

  $('form').on 'click', '[data-add="true"]', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    fields = $(this).data('fields')
    $(this).before(fields.replace(regexp, time))
    init_modal_dialogs()
    init_nested_sorts()
    init_tooltips()
    event.preventDefault()

window.init_nested_sorts = ->
  $('[data-sortable="true"]').each (index,value) ->
    $(value).sortable
      axis: 'y',
      stop: ->
        updateNestedSortablePositions()
      handle: '[data-handle="true"]'
      forcePlaceholderSize: true
      items: '[data-sortable-item="true"]'
  updateNestedSortablePositions()

window.updateNestedSortablePositions = ->
  $('[data-sortable="true"]').each (index,value) ->
    $(value).find('[data-sortable-item="true"]').each (nestedIndex,nestedValue) -> 
      $(nestedValue).find('[data-position="true"]').val(nestedIndex)
     
  
