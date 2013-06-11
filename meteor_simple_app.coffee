Entries = new Meteor.Collection("number_list")

if Meteor.is_client
  #Template.random_number.number_list = [{number: "Hello world"}]
  Template.random_number.number_list =  -> Entries.find()
  #Template.random_number.number_list = [{number: "Hello world"}, {number: "one more time"}]

  Template.random_number.events =
    'submit #new_entry': (event) ->
      event.preventDefault()
      Entries.insert(number: $('#new_entry_name').val())
      $('#new_entry_name').val('')

    'click #pick': ->
      picked = _.shuffle(Entries.find(picked: {$ne: true}).fetch())[0]
      if picked
        Entries.update(picked._id, $set: {picked: true})
        