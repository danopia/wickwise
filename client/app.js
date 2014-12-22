Template.candleList.helpers({
  candles: function () {
    return Candles.find({ owner: Meteor.userId() });
  },

  hasCandles: function () {
    return Candles.find({ owner: Meteor.userId() }).fetch().length;
  },
});


Template.showCandle.helpers({
  candleImg: function () {
    return '/images/' + this.type.split(' ')[0].toLowerCase() + '.png';
  },
});

Template.showCandle.events({
  'change .burn-count': function (event) {
    Candles.update(this._id, { $set: {
      burns: +event.target.value,
    }});
  },
});


Template.addCandle.helpers({
  waxTypes: function () {
    return WaxTypes;
  },

  candleTypes: function () {
    return CandleTypes;
  },
});

Template.addCandle.events({
  'submit form': function (event) {
    Candles.insert({
      owner: Meteor.userId(),
      brand: event.target.brand.value,
      scent: event.target.scent.value,
      wax: event.target.wax.value,
      size: +event.target.size.value,
      type: event.target.type.value,
      //unburned: event.target.unburned.checked,
    });

    event.target.reset();
    return false;
  },
});
