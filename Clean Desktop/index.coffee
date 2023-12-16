# Videsh Arivazhagan
# Mond Clock for Übersicht
# Mond Version 1.0
# 2023-12-16

settings =
    lang: 'en'

clock12h = true

locale =
  en:
    weekdays: [
      'Sunday'
      'Monday'
      'Tuesday'
      'Wednesday'
      'Thursday'
      'Friday'
      'Saturday'
    ]
    months: [
      'January'
      'February'
      'March'
      'April'
      'May'
      'June'
      'July'
      'August'
      'September'
      'October'
      'November'
      'December'
    ]
  de:
    weekdays: [
      'Sonntag'
      'Montag'
      'Dienstag'
      'Mittwoch'
      'Donnerstag'
      'Freitag'
      'Samstag'
    ]
    months: [
      'Januar'
      'Februar'
      'März'
      'April'
      'Mai'
      'Juni'
      'Juli'
      'August'
      'September'
      'Oktober'
      'November'
      'Dezember'
    ]

# Replace weekdays and months in your language.
# Replace yourLang with your Language name
# Set the Lang in the setting on the top to your Language Name

  yourLang:
    weekdays: [
      'Sonntag'
      'Montag'
      'Dienstag'
      'Mittwoch'
      'Donnerstag'
      'Freitag'
      'Samstag'
    ]
    months: [
      'Januar'
      'Februar'
      'März'
      'April'
      'Mai'
      'Juni'
      'Juli'
      'August'
      'September'
      'Oktober'
      'November'
      'Dezember'
    ]

command: ""

settings: settings
locale: locale

refreshFrequency: 100

style: """

  @font-face {
    font-family: Anurati;
    src: url("Anurati.otf") format("opentype");
  }
  @font-face {
    font-family: Aquatico-Regular;
    src: url("Aquatico.otf") format("opentype");
  }
  @font-face {
    font-family: Quicksand-Regular;
    src: url("Quicksand Regular 400.otf") format("truetype");
  }

  color: #000
  top: 19%
  left: 50%
  font-family: Helvetica, sans-serif
  font-size: 10px
  line-height: 1
  text-transform: uppercase
  transform: translate(-50%, -50%)

  .container
    text-align: center
    display: block
    height: 100%
    overflow: hidden

  .txt-default
    font-family: 'Quicksand'
    line-height: 2
    font-size: 30px
    color: #ffffff

  .txt-default-small
    line-height: 2
    font-size: 30px
    color: #ffffff

  .txt-white

  .txt-large
    font-size: 5rem
    letter-spacing: 20px
    font-weight: 700
    font-family: 'Anurati'
    margin-left: 50px
    color: #ffffff

  .month:after
    content: ","
"""

render: () -> """
  <div class='container'>
    <span class='weekday txt-white txt-large'></span>
    <div class='txt-default'>
        <span class='day'></span>
        <span class='month'></span>
        <span class='year'></span>
     </div>
    <div class='txt-default-small'>
      <span class='line txt-default-small'>-</span>
      <span class='hours txt-default-small'>:</span>
	<span class="txt-default-small">:</span>
      <span class='minutes txt-default-small'></span>

      <span class='seconds txt-default-small'></span>
       <span class="txt-default-small">  </span>
      <span class='ampm txt-default-small'></span>
      <span class='line txt-default-small'>-</span>
    </div>
  </div>
"""

afterRender: (domEl) ->

update: (output, domEl) ->
  date = @getDate()

  $(domEl).find('.hours').text(date.hours)
  $(domEl).find('.minutes').text(date.minutes)
  # $(domEl).find('.seconds').text(date.seconds)
  $(domEl).find('.weekday').text(date.weekday)
  $(domEl).find('.day').text(date.day)
  $(domEl).find('.month').text(date.month)
  $(domEl).find('.year').text(date.year)
  if clock12h
    $(domEl).find('.ampm').text(date.ampm)


zeroFill: (value) ->
  return ('0' + value).slice(-2)



getDate: () ->
  date = new Date()
  hour = date.getHours()
  ampm = ""
  if clock12h
    ampm = "am"
    if hour >= 12
      ampm = "pm"
    hour2 = hour % 12;
    hour = hour2 ? hour : 12;
    

  hours = @zeroFill(hour);
  ampm2 = @zeroFill(ampm2);
  minutes = @zeroFill(date.getMinutes())
  seconds = @zeroFill(date.getSeconds())
  weekday = @locale[@settings.lang].weekdays[date.getDay()]
  day = @zeroFill(date.getDate())
  month = @locale[@settings.lang].months[date.getMonth()]
  year = date.getFullYear()

  return {
    hours: hours
    ampm: ampm
    minutes: minutes
    seconds: seconds
    weekday: weekday
    day: day
    month: month
    year: year
  }