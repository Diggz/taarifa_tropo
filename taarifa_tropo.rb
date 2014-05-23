require 'json'
require 'restclient'


myCallerID = $currentCall.callerID.to_s
myCalledID = $currentCall.calledID.to_s
wpid = ''
wpstatus = ''

wait(200)

say "Thank you for calling the water point reporting system."


# Question 1
ask "Please enter the 5 digit water point identification number. Press pound when finished.", 
{
    :choices => "[5 DIGITS]",
    :terminator => '#',
    :timeout => 15.0,
    :mode => "dtmf",
    :interdigitTimeout => 5,
    :attempts => 3,
    :onChoice => lambda { |response|
        wpid = response.value
        say "You entered" + response.value
    },
    :onBadChoice => lambda { |response|
        say "Sorry, I didn't get that."
    }
}


# Question 2
ask "Please enter the water point status. Press one for working, two for broken.", 
{
    :choices => "1,2",
    :terminator => '#',
    :timeout => 15.0,
    :mode => "dtmf",
    :interdigitTimeout => 5,
    :attempts => 3,
    :onChoice => lambda { |response|
        wpstatus = response.value
        say "You entered" + response.value
    },
    :onBadChoice => lambda { |wpstatus|
        say "Sorry, I didn't get that."
    }
}

# Post these answers to TAARIFA API (When it is ready)

# RestClient.post 'http://foobar.com/resource', { "foo" => wpid, "bar" => wpstatus }.to_json 

if wpstatus == '1' 
   say "Thank you for your report. Water Point " + wpid + " is now reported as working. Drink up!"
   wpstatus = 'Working'
else
   say "Thank you for your report. Water Point " + wpid + " is now reported as broken. Sad face."
   wpstatus = 'Broken'
end

# This next part was just for demo 

# message "New report from:" + myCallerID + " WaterPoint ID: " + wpid + " Status: "+ wpstatus, {
    :to => "+14077586356",  
    :network => 'SMS'}