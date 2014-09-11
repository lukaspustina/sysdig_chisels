# Sysdig Chisels

This is my repository for [sysdig](http://www.sysdig.org) [chisels](http://www.sysdig.org/wiki/chisels-overview/).

## Installation

Installation is simple. Copy or clone the chisels you like to either `.`, `./chisels`, `~/.chisels` or `/usr/share/sysdig/chisels`. See man page for sysdig for details.

## Chisels

### Find Time Gap

The `find_time_gap` chisel only shows events with a time difference to the preceeding event larger than a threshould. The default threshold is 1 sec and can be optionally changed via a parameter. Sysdig filters work as usual.

#### Examples

* Example only considering events from process _sysdig_ and default threshold of 1 second

    ```
    $ sysdig -c find_time_gap proc.name=sysdig
    ```

* Example only considering events from process _sysdig_ and threshold of 100 ms

    ```
    $ sysdig -c find_time_gap 0.1 proc.name=sysdig
    12646 15:29:40.765903793 (0.111808714) sysdig > switch next=14593(mongod) pgft_maj=0 pgft_min=7517 vm_size=161072 vm_rss=11032 vm_swap=0
    440231 15:29:56.837824534 (0.102809561) sysdig > switch next=0 pgft_maj=0 pgft_min=7534 vm_size=161072 vm_rss=11032 vm_swap=0
    ```

