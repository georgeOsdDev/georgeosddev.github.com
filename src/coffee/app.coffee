window.onerror = (message, url, lineNumber) ->
  msg = """An Error Occured on this page.
  Error: #{message}
  Url: #{url}
  Line: #{lineNumber}
  """
  console.log msg

###--------------------------------------------------
coderwall badges
###

Badge = Backbone.Model.extend({})
Badges = Backbone.Collection.extend({
  model: Badge
  url: (uname) ->
    "http://coderwall.com/:USERNAME.json?callback=?".replace(":USERNAME", uname)
  fetch: (uname) ->
    self = this
    $.getJSON self.url(uname),(data) ->
      console.log data
      self.reset(data["data"]["badges"])
})

BadgeView = Backbone.View.extend({
  el: '#coderwallbadges',
  initialize: ->
    self = this
    _.bindAll(self, "render")
    self.collection = new Badges()
    self.collection.on("reset", self.render)
    self.collection.fetch(self.$el.attr("data-source"))

  render: ->
    self = this
    self.collection.each (badge,i) ->
      div = document.createElement("div")
      div.className = "badge floatLeft"
      div.id = "badge_#{i}"
      badgeImg = new Image()
      badgeImg.src = badge.get("badge")
      badgeImg.alt = badge.get("name")
      description = document.createElement("div")
      description.innerHTML = badge.get("description")
      description.className = "tooltip display-none"
      div.appendChild(badgeImg)
      div.appendChild(description)
      $(div).on "mouseover", ->
        $("div",this).removeClass("display-none")
      $(div).on "mouseout", ->
        $("div",this).addClass("display-none")
      self.$el.append(div)
})

#--------------------------------------------------
#jQuery ready
$ ->
  new BadgeView()
