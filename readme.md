anagram-rb
==========

# Implementation notes

The unmarshalled processed dictionary is stored in a class variable.
Normally I would store this data in a RDMS such as PostgreSQL or perhaps in a store such as Redis.
In order to keep the implementation as simple to run as possible I chose to store the datastructure in a class variable.
I am aware that this is not generally good practice.

The dictionary is processed 'offline' and the processed version is committed to git.
