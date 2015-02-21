---
kind: article
author: Daniel Kennett
layout: post
title: "Making your Unit Tests AWESOME"
slug: making-your-unit-tests-awesome
created_at: 2012-05-22 18:15
comments: true
categories:
- Programming-Work
---

This blog has had far too much content about cycling and getting fit and other boring stuff like that. It's time to return the blog to it's roots — doing dumb stuff with computers!

I recently added some unit tests to [CocoaLibSpotify](https://github.com/spotify/cocoalibspotify), the Objective-C Spotify framework I'm responsible for. I'm new to using tests, and the benefits have been great — I'm somewhat a convert to test-driven development now. However, this post isn't yet another essay on TDD — it's about how to make your testing AWESOME.

On a recent hackday, I took the Mac mini that builds CocoaLibSpotify and runs the unit tests and gave it a slightly more… visual indicator on the test results.

[<img src="http://pcdn.500px.net/7840881/202d5d2e2e3a53050e0c977b1abbc9dfae181793/4.jpg" />](http://500px.com/photo/7840881) \\
 *Yellow = running tests, green = all passed, red = one more more failed.* 
{:.center}

To accomplish this, I made a simpler version of my [previous project](http://ikennd.ac/blog/2011/10/arduino-dioder-part-three/) to control four individual RGB LED strips. The simplified unit uses an Arduino Uno instead of a Mega2560, and only has two channels instead of four (only one of which is used in this project).

[<img src="http://pcdn.500px.net/7840903/7b0e4b152b896ade6775bded0935b7568c04b1e5/4.jpg" />](http://500px.com/photo/7840903) \\
 *The completed hardware - running wires underneath the board makes it much neater!* 
{:.center}

Once the hardware was up-and-running, I made a [slightly modified](https://github.com/iKenndac/Arduino-Dioder-Playground/commit/ad1f02da6f13099718d813353887acec3132618e) version of the control software to go on the Arduino (since the Uno has different PWM pins to the Mega2560) and was ready to go! At this point, the unit is compatible with all of the [previous code](https://github.com/iKenndac/Arduino-Dioder-Playground) I've written for sending colours, except only channels 1 and 2 do anything.

Next, we get a strip of thin plastic and make a loop roughly the size of the Mac mini's base, stick a [flexible LED strip](http://www.ikea.com/se/sv/catalog/products/00191735/) to it and voilà! One glowing Mac mini!

[<img src="http://pcdn.500px.net/7840897/77b4e1cccea73713ed5ab6e3a6db0d6e09905a41/4.jpg" />](http://500px.com/photo/7840897)
{:.center}


[<img src="http://pcdn.500px.net/7840885/94dbe9e3ea37c71222017dab775e6a14199f4415/4.jpg" />](http://500px.com/photo/7840885)
{:.center}

[<img src="http://pcdn.500px.net/7840892/131b5d03bccf210273523585e2a5fcbe679cad3c/4.jpg" />](http://500px.com/photo/7840892)
{:.center}

## Linking to Unit Tests ##

Since this was a hackday, the rest of the project is slightly… slap-dash.

First, I wrote a stupid simple Ruby/Sinatra application that provides a REST API over HTTP, allowing you to push colours with a standard HTTP GET request:

`http://localhost:4567/push-color?red=0&green=255&blue=0`

The entirety of the code is below in its horrible, hardcoded, fragile glory. It's worth noting that the Uno uses exactly the same protocol as the Mega, so it still needs to be given four colours even though it only supports two.

~~~~~~~~ ruby
require 'sinatra'
require 'serialport'
require 'json'

port = SerialPort.new("/dev/tty.usbmodemfa131", 57600)

get '/push-color' do

    # Push one colour to each channel
    red = params[:red].to_i
    green = params[:green].to_i
    blue = params[:blue].to_i

    message = Array.new(15, 0)
    message[0] = 0xBA
    message[1] = 0xBE
    message[2] = green
    message[3] = blue
    message[4] = red
    message[5] = green
    message[6] = blue
    message[7] = red
    message[8] = green
    message[9] = blue
    message[10] = red
    message[11] = green
    message[12] = blue
    message[13] = red
    message[14] = 0

    for currentIndex in 2..13
        message[14] = message[14] ^ message[currentIndex]
    end

    port.write(message.pack('c*'))

    return "<body style=\"background-color:rgb(#{red}, #{green}, #{blue})\">#{message.to_s}</body>"

end
~~~~~~~~

Next, continuing the trend of implementing this in the worst way possible, I added HTTP requests directly into the unit test code in CocoaLibSpotify. If you start the tests with the command-line parameter `-StatusColorServer localhost:4567` it'll make HTTP requests to the given server:

~~~~~~~~
-(void)pushColorToStatusServer:(UIColor *)color {
    
    NSString *statusServerAddress = [[NSUserDefaults standardUserDefaults] stringForKey:kTestStatusServerUserDefaultsKey];
    if (statusServerAddress.length == 0) return;
    
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    
    [color getRed:&red green:&green blue:&blue alpha:NULL];
    
    NSString *requestUrlString = [NSString stringWithFormat:@"http://%@/push-color?red=%lu&green=%lu&blue=%lu",
                                  statusServerAddress,
                                  (NSUInteger)red * 255,
                                  (NSUInteger)green * 255,
                                  (NSUInteger)blue * 255];
    
    NSURL *requestUrl = [NSURL URLWithString:requestUrlString];                              
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl 
                                             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                         timeoutInterval:1.0];
    
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:nil
                                      error:nil];
    
}
~~~~~~~~

And that, my friends, is it! The unit tests set the colour to yellow when it starts the tests, then red or green depending on the outcome. Don't forget to put your IP address on the company IRC so your colleagues can blink the lights all day long!
