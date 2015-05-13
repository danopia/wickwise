Template.candleList.helpers
  candles: ->
    Candles.find owner: Meteor.userId()

  hasCandles: ->
    Candles.find(owner: Meteor.userId()).fetch().length

Template.showCandle.helpers
  candleImg: ->
    '/images/' + @type.split(' ')[0].toLowerCase() + '.png'

Template.showCandle.events
  'change .burn-count': (event) ->
    Candles.update @_id, $set:
      burns: +event.target.value

  'click .remove-btn': ->
    bootbox.confirm 'Do you want to delete this candle from your list?', =>
      Candles.remove @_id
    return false

Template.showCandle.onRendered ->
  update = (response, newValue) ->
    _id = $(@).closest('.candle').data('id')
    field = $(@).data('model')

    data = {}
    data[field] = newValue
    Candles.update _id, $set: data

  @$('[data-type=text].editable, [data-type=number].editable').editable
    display: false
    success: update

  @$('[data-model=wax].editable').editable
    display: false
    success: update
    source: WaxTypes.map (type) ->
      value: type
      text: type

  @$('[data-model=type].editable').editable
    display: false
    success: update
    source: CandleTypes.map (type) ->
      value: type
      text: type

Template.addCandle.helpers
  waxTypes: -> WaxTypes
  candleTypes: -> CandleTypes

Template.addCandle.events
  'submit form': (event) ->
    {brand, scent, wax, size, type} = event.target
    Candles.insert
      owner: Meteor.userId()
      brand: brand.value
      scent: scent.value
      wax: wax.value
      size: +size.value
      type: type.value

    event.target.reset()
    return false
