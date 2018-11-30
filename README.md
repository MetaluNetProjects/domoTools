# domoTools

domoTools is a set of Pure Data abstractions aiming to simplify the creation of a new "domophone". A domophone is an electronic music instrument, created during a participative workshop, and generally built around used home furnishings and appliances (ironing board, vacuum cleaner...).

domoTools makes extensive use of [**AutoPreset**](<https://github.com/MetaluNet/AutoPreset>) library (available through "deken" Pd externals installation interface).

Open **domoTools-help.pd** which demonstrates the different parts.

-------------
## PARTS:

### gammabs
**gammabs** provides a 1-octave piano keyboard GUI allowing to (un)select any of the 12 keys; the selected keys thus form a musical scale, that can be used later to fine-tune a given midi note number, bringing it closer to the scale.

### domonet
**domonet** synchronizes tempo clock, musical scale and song name between all instruments that are connected to the same network. It uses Carabiner, which embeds Ableton Link tempo-synchronizing protocol (it should use abl_link~ external, but which doesn't work yet on rasperryPi for unknown reason). Only linux64 and rPi binaries are included in this package. 

### songMaster
**songMaster** stores and recalls any declared parameter value, depending of the current song name.

### notebank
**notebank** allows to load a set of sound files, and to tag them with their midi note number.  
Then a **noteplayer** abstraction can play any of these "notes", while tuning them to the scale.

### decoupeur
**decoupeur** loads a sound file, then builds a table of indices representing the different measured sound fragments (delimited by rapid and loud enough attacks).

Then a proposed sequencer plays these fragments in a generated palindromic auto-changing order.

### effects
It's a set of autopreset-formatted effect abstractions.
They can be bounded to a given autopreset-reference, in order to recall their settings; it's then possible to morph parameters between different setting slots.

### rhythmic
**rhythmic** provides a rhythm-pattern editor GUI and associated playing utility. A rhythmic instrument example is also proposed.

--------------
## dependencies
**domoTools** needs several externals:

- moonlib
- iemlib
- creb
- ggee
- hcs
- AutoPreset

---------------
(c) 2018 Antoine Rousseau @ metalu.net

license: GNU GPL (see [LICENSE.txt](LICENSE.txt)) 
