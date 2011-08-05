TellyGo
=====

## Description

TellyGo is an experiment in social dynamics for video chat. It emphasizes both participation (via randomly selected Telly Stars) and quality of content (no text chat, community rating).

## Technologies Used

 * Flex for video chat
 * RubyAMF for Flex to Rails communication
 * Rails
 * MongoDB
 
 
## RubyAMF
 
I had to patch the vendored rubyamf so it wouldn't crash when ActiveRecord isn't loaded. It doesn't currently support mongo documents, so I kept the transport to just simple data formats and collections. A good project would be to update RubyAMF to handle other ORMs.

## Security

As it's currently written, there are no protections against someone hijacking the video streams, as they are easily discoverable. To lock this behavior down, I'd like to make the red5 server talk to the rails server to determine user / channel credentials.
