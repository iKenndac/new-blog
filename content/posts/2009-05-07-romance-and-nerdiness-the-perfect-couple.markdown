---
kind: article
author: Daniel Kennett
created_at: '2009-05-07 13:10:43'
layout: post
slug: romance-and-nerdiness-the-perfect-couple
status: publish
title: 'Romance and Nerdiness: The Perfect Couple'
wordpress_id: '335'
categories:
- General
---

A few days ago it was my girlfriend's birthday. After much deliberation, I'd decided what to get her - a Sony Reader. However, her birthday was on a weekday this year, and at the moment I'm busy enough with work to make it difficult to justify a day off. Out of nowhere, the idea popped into my head to do a treasure hunt.

<strong>Design</strong>

After a bit of planning, I thought it'd be a great idea. However, I didn't want to hide an expensive piece of electronics in some random bush, and keeping the treasure hunt confined to the house seemed a bit boring.

The UK partner for the Sony Reader is <a href="http://www.waterstones.co.uk/" target="_blank">Waterstone's</a> - a large chain of book shops. Whenever I've been into a Waterstone's, the staff there seemed pretty cool so I went in to my local Hitchin branch to buy the Reader. As I was paying, the conversation went like this:

- <strong>Me: </strong>Um... can I have someone else come and pick this up later?
- <strong>Teller: </strong>Sure, just have them bring in the receipt and we'll hold it for them until they can get it. 
- <strong>Me: </strong>Ah, well... The person can't know what it is until you hand it over to them.

They were resistant to the idea until I explained what I was trying to do. After some discussion, which included fetching the manager over, the staff were extremely helpful and suggested ideas including hiding the proof of purchase in an envelope my girlfriend would bring along with her. In the end, they agreed to hold the Reader in their safe and tool mine and my girlfriend's details as well.

Leaving the store happy, I began to design the hunt properly. This was the flow:

- My girlfriend would find a birthday card on her desk after I'd left for work, which contained a web address.
- Visiting that web address would set off the hunt and lead her to the first clue card, which would lead her on a trail of eleven cards.
- Each card would contain a clue to the next card and a number to be put into the web page.
- When all the numbers are successfully entered, the web page would reveal that the numbers in fact make up a GPS coordinate, and one final clue.
- Upon navigating to the GPS location, the clue leads my girlfriend to Waterstone's. 

<!--more-->

<strong>Implementation</strong>

Now to the fun part. The web page is a simple PHP page that takes in the numbers and saves them in a cookie. When all the numbers are entered correctly, the form would be replaced with instructions and a final clue. 

This is the page when first visited:

<img src="http://ikennd.ac/pictures/for_posts/2009/05/alanas-birthday-adventure.png" />
{:.center}

When you enter all of the numbers correctly, the page changes to this:

<img src="http://ikennd.ac/pictures/for_posts/2009/05/alanas-birthday-adventure-2.png" />
{:.center}

Now it's time to make and hide the cards. The five clues inside the house were hidden inside drawers and scanners and things just so they weren't stumbled upon while looking for another clue. However, once outside you don't want to spend ages searching through the wrong bush so the cards were fairly open once you figured out the previous clue and got to the right place. Two of the clues were fairly close together in our village of Clifton, and two others were in the Chicksands woods nearby. 

<img src="http://ikennd.ac/pictures/for_posts/2009/05/clues.png" />
{:.center}

<p style="text-align:center;">Above: The location of the clues outside our house.</p>

<strong>Battle Plan: Go!</strong>

So, on Tuesday morning I wake up, make excuses about having to to work on her birthday and screech out of the house. Instead of going to work, I'm driving around mid Bedfordshire attaching clues to things hoping my girlfriend doesn't catch up with me.

<img src="http://ikennd.ac/pictures/for_posts/2009/05/duckpond.jpg" />
{:.center}

<img src="http://ikennd.ac/pictures/for_posts/2009/05/chicksands.jpg" />
{:.center}

<strong>Debrief</strong>

In short, the mission was a success. After worrying that the cards would go missing, or my girlfriend wouldn't be able to solve the clues, or that the Waterstones wouldn't give her the Reader, everything went off without a hitch. She did get stuck on a couple of the clues, but a helpful nudge via text message got her back on track. It took her between two and three hours to complete the puzzle - which is a good amount of time, I think. Too fast and it's almost not worth the effort, but too long and it gets boring. 

<img src="http://ikennd.ac/pictures/for_posts/2009/05/cards.jpg" />
{:.center}

I was worried that it was a stupid idea at first, but everyone I told (including the staff at Waterstone's) thought it was a wonderful idea, and I have to admit I'd really enjoy having something like this done for me. Of course, if you're less of a nerd than me (highly likely), you can do it without custom web scripts and GPS co-ordinates. I thought about leaving them out myself, but couldn't resist an excuse to code a fun little web page. 

In the end, it worked out great. After the hunt was over, my girlfriend said "As soon as I saw that web page, I thought: 'Ah, this is Daniel all over!'". I'm a nerd, and everyone knows it. Why hide it?