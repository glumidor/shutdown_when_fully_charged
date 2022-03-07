# shutdown_when_fully_charged
for my MacBook Air in combination with Better Battery 2

I wanted the BetterBattery2 to be running while charging the macbook battery

therefore I wrote a litte shell script which I start when connecting to the power supply (normally when my work is finished and I go home).
the script checks every minute how long the battery needs to get fully charged,
waits for the "finishing charge" time
and shuts down my mac
